//
// DAC8531 (16-bit, 24-bit SPI frame) driver for vctcxo_lock.
//
// Same state machine and timing as dacxx11_spi.v (SCLK = clk/32, idles low,
// only toggles while nSYNC is low, DIN changes on the SCLK rising edge and is
// captured by the DAC on the falling edge, as SBAS192 requires: DIN setup 5 ns,
// hold 4.5 ns at the falling edge), with the DAC8531 frame instead of the
// DACx311 one:
//
//   DB23..DB18 don't care, DB17..DB16 PD1 PD0 (00 = normal operation),
//   DB15..DB0 the 16-bit code, MSB first, 24 SCLK cycles with nSYNC low.
//
// The DAC updates on the 24th falling edge. A frame that is cut short (nSYNC
// taken high before the 24th edge) is ignored by the chip; the board-level
// SPI arbiter relies on that when the ADF4001 takes the shared bus.
//

`timescale 1ns / 1ps

module dac8531_spi  (
    input   wire            clk,
    input   wire            rst,
    input   wire  [15:0]    data,
    output  reg             sclk,
    output  wire            mosi,
    output  reg             sync_n
);

localparam  IDLE        = 4'b0001;
localparam  SYNC_PRE    = 4'b0010;
localparam  DATA        = 4'b0100;
localparam  SYNC_END    = 4'b1000;

localparam [1:0] NORMAL_OPERATION = 2'b00;

reg     [3:0]   state;
reg     [4:0]   cnt_cycle;
reg     [4:0]   cnt_bit;
reg     [15:0]  last_data;
reg     [23:0]  data_shift;
wire            rising_edge;
wire            falling_edge;
reg             mosi_r;

always @(posedge clk) begin
    if (rst) begin
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE : begin
                // power-up: last_data resets to 0 while the DAC8531 itself
                // resets to zero scale, so the first write happens as soon
                // as the loop asks for anything else
                if (last_data != data) begin
                    state <= SYNC_PRE;
                end
            end
            SYNC_PRE : begin
                if (falling_edge) begin
                    state <= DATA;
                end
            end
            DATA : begin
                if (cnt_bit == 5'd23 && falling_edge) begin
                    state <= SYNC_END;
                end
            end
            SYNC_END : begin
                if (rising_edge) begin
                    state <= IDLE;
                end
            end
            default : state <= IDLE;
        endcase
    end
end

always @(posedge clk) begin
    if (rst) begin
        cnt_cycle <= 5'd0;
    end
    else if (state == SYNC_PRE || state == DATA || state == SYNC_END) begin
        cnt_cycle <= cnt_cycle + 1'b1;
    end
    else begin
        cnt_cycle <= 5'd0;
    end
end

assign rising_edge  = (cnt_cycle == 5'b10000);
assign falling_edge = (cnt_cycle == 5'b11111);

always @(posedge clk) begin
    if (rst) begin
        data_shift <= 24'd0;
    end
    else if (state == IDLE && (last_data != data)) begin
        data_shift <= {6'b000000, NORMAL_OPERATION, data};
    end
    else if (state == DATA && falling_edge) begin
        data_shift <= {data_shift[22:0], 1'b0};
    end
end

always @(posedge clk) begin
    if (rst) begin
        cnt_bit <= 5'd0;
    end
    else if (state == DATA) begin
        if (cnt_bit == 5'd23 && falling_edge) begin
            cnt_bit <= 5'd0;
        end
        else if (falling_edge) begin
            cnt_bit <= cnt_bit + 1'b1;
        end
    end
    else begin
        cnt_bit <= 5'd0;
    end
end

always @(posedge clk) begin
    if (rst) begin
        last_data <= 16'd0;
    end
    else if (state == IDLE && (last_data != data)) begin
        last_data <= data;
    end
end

always @(posedge clk) begin
    if (rst) begin
        sclk <= 1'b0;
    end
    else if (state == DATA && rising_edge) begin
        sclk <= 1'b1;
    end
    else if (state == DATA && falling_edge) begin
        sclk <= 1'b0;
    end
end

// next bit presented on the SCLK rising edge, captured by the DAC on the
// following falling edge, shifted after that edge
always @(posedge clk) begin
    if (rst) begin
        mosi_r <= 1'b0;
    end
    else if (state == DATA && rising_edge) begin
        mosi_r <= data_shift[23];
    end
end

assign mosi = mosi_r;

always @(posedge clk) begin
    if (rst) begin
        sync_n <= 1'b1;
    end
    else if (state == SYNC_PRE && falling_edge) begin
        sync_n <= 1'b0;
    end
    else if (state == SYNC_END && rising_edge) begin
        sync_n <= 1'b1;
    end
end

endmodule
