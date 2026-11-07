// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 1:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 1:0]  ddr_dqs_n,
  inout   [ 1:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [31:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout           iic_scl,
  inout           iic_sda,

  input           rx_clk_in,
  input           rx_frame_in,
  input   [11:0]  rx_data_in,
  output          tx_clk_out,
  output          tx_frame_out,
  output  [11:0]  tx_data_out,

  output          enable,
  output          txnrx,
  input           clk_out,

  // Only the AD9361 reset reaches the PL on this board (CAT_RSTn, N17).
  // CTRL_IN0-3 are tied low and CTRL_OUT0-7 and EN_AGC are not connected
  // (schematic sheet AD936X), so their EMIO lines just loop back below.
  inout           gpio_resetb,

  output          spi_csn , 
  output          spi_clk , 
  output          spi_mosi , 
  input           spi_miso ,
  output          tx1_en , tx2_en , sel_clk_src,
  output rx1_led,rx2_led,

  // GNSS module (U12) serial, schematic nets GPS_TXD_R / GPS_RXD_R:
  // gps_txd is the module's TXD (data into the FPGA), gps_rxd its RXD
  input           gps_txd,
  output          gps_rxd,
  // GNSS 1PPS (schematic net GPS_1PPS_RAW, pin T5): fed to PS EMIO GPIO 14
  // (Linux gpio 68) so the kernel pps-gpio driver can timestamp it, and to
  // the vctcxo_lock IP as PPS_GPS
  input           gps_pps,

  // 40 MHz VC-TCXO reference chain (schematic sheet 40M_REF). The oscillator
  // X2 is tuned through a 74LVC1G3157 mux U14 by either the DAC8531 U19
  // (vctcxo_lock IP in the block design, PPS or 10 MHz disciplined) or the
  // charge pump of the ADF4001 U5 locked to the external 10 MHz on J13.
  input           ref_40m,      // FPGA_CLK, buffered oscillator output (L16)
  input           ref_10m,      // REF_CHK, buffered copy of the J13 input (T19)
  input           pps_ext,      // TRIG, the PPS input J11 (T20)
  output          dac_nsync,    // 40M-DAC-nSYNC, DAC8531 (U5)
  output          pll_sck,      // PLL_SCK, shared by DAC8531 and ADF4001 (V10)
  output          pll_din,      // PLL_DIN, shared (V6)
  output          pll_csn,      // PLL_CSN, ADF4001 LE (W6)
  input           pll_muxout,   // PLL_LCKED, ADF4001 MUXOUT, also the LED (V11)
  output          vc_sel        // 40M-VC-SEL, mux select (Y13)
  );


assign {tx1_en,tx2_en,sel_clk_src} = 3'b101  ;
assign rx1_led = 1'b1 ;
assign rx2_led = 1'b0 ; 

  wire          pl_spi_clk_o ;
  wire          pl_spi_mosi ;
  wire          pl_spi_miso ;
  
  // internal signals

  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;

  // instantiations

  ad_iobuf #(.DATA_WIDTH(1)) i_iobuf (
    .dio_t (gpio_t[13]),
    .dio_i (gpio_o[13]),
    .dio_o (gpio_i[13]),
    .dio_p (gpio_resetb));

  // AD9361 en_agc / ctrl / status lines: no pad on this board, loop back
  assign gpio_i[12:0] = gpio_o[12:0];
  assign gpio_i[14] = gps_pps;
  assign gpio_i[31:15] = gpio_o[31:15];

  // ---------------------------------------------------------------------
  // Reference clock control on EMIO (Linux gpio 54 + n), same map as
  // plutoskyr2 so /etc/refclk.conf and S22refclk carry over:
  //   o[32] force external (ADF4001 loop always closed)
  //   i[33] 10 MHz present      i[35] charge pump active
  //   o[34] force internal (loop always open)
  //   i[51:36] R divider edges per 102.4 us window (1024 = 10 MHz)
  //   i[52] PLL locked          i[54:53] controller state
  //        (0 absent, 1 acquire, 2 locked, 3 recheck), see ADF4001_refctl.v
  // and for the tune mux:
  //   o[55] force the mux       o[56] forced value (1 = DAC, 0 = ADF4001)
  //   i[57] mux select as driven
  // ---------------------------------------------------------------------
  wire          ref_present;
  wire          ref_window;
  wire          ref_good;
  wire          ref_locked;
  wire  [1:0]   ref_state;
  wire          ref_present_out;
  wire          pll_cp_active;
  wire  [1:0]   pll_mux_is;
  wire          pll_cfg_done;
  wire          ref_cp_req;
  wire  [1:0]   ref_mux_req;
  wire          ref_det_enable;
  wire  [15:0]  ref_count;
  wire          pll_le;
  wire          pll_sclk_adf;
  wire          pll_mosi_adf;
  wire          dac_sclk;
  wire          dac_mosi;
  wire          dac_sync_n;

  assign gpio_i[63:58] = gpio_o[63:58];
  assign gpio_i[57]    = tune_dac;
  assign gpio_i[56:55] = gpio_o[56:55];
  assign gpio_i[54:53] = ref_state;
  assign gpio_i[52]    = ref_locked;
  assign gpio_i[51:36] = ref_count;
  assign gpio_i[35]    = pll_cp_active;
  assign gpio_i[34]    = gpio_o[34];
  assign gpio_i[33]    = ref_present_out;
  assign gpio_i[32]    = gpio_o[32];

  // ---------------------------------------------------------------------
  // Tune mux U14 (74LVC1G3157): S = 0 connects B1 (pin 1) to the tune
  // line, S = 1 connects B2 (pin 3). Established on the bench unit with
  // the mux forced each way and the DAC swept open loop: S = 0 is the
  // DAC8531 (dac 0 -> -14.8 ppm, 65535 -> +17.9 ppm), S = 1 is the
  // ADF4001 charge pump loop filter (R112/C291; a floating node while the
  // charge pump is three-stated, the oscillator then free-runs wherever
  // it drifted). R108 pulls S high, so an unconfigured PL leaves the loop
  // filter in charge. Automatic rule: the ADF4001 steers the oscillator
  // whenever its charge pump is active, i.e. the controller found a
  // 10 MHz on J13 and closed the loop; otherwise the DAC loop in the
  // block design does, from the GNSS PPS. The EMIO lines keep the
  // 1 = DAC convention of /etc/refclk.conf whichever way the pin goes.
  // ---------------------------------------------------------------------
  localparam VC_SEL_DAC = 1'b0;
  localparam VC_SEL_ADF = 1'b1;
  wire tune_dac = gpio_o[55] ? gpio_o[56] : ~pll_cp_active;
  assign vc_sel = tune_dac ? VC_SEL_DAC : VC_SEL_ADF;

  // ---------------------------------------------------------------------
  // Shared SPI bus: SCK and DIN go to both chips, each has its own select.
  // The ADF4001 frames (a few per second at most, 24 bits at 5 MHz) take
  // priority: while LE is low the DAC sees its nSYNC held high, so a DAC
  // frame that collides is simply dropped by the DAC8531 (fewer than 24
  // SCLK edges under nSYNC) and the loop rewrites it with its next update.
  // ---------------------------------------------------------------------
  wire bus_adf = ~pll_le;
  assign pll_csn   = pll_le;
  assign pll_sck   = bus_adf ? pll_sclk_adf : dac_sclk;
  assign pll_din   = bus_adf ? pll_mosi_adf : dac_mosi;
  assign dac_nsync = dac_sync_n | bus_adf;

  // ---------------------------------------------------------------------
  // ADF4001 PLL: the blocks from boards/plutoskyr2 (added by
  // common/xilinx_init.tcl), clocked by the oscillator itself. R = 1,
  // N = 4: 10 MHz phase detector, 40 MHz VCTCXO on RFIN A.
  // ---------------------------------------------------------------------
  reg  [2:0] adf_cnt = 3'd0;
  reg        adf4001_spi_clk = 1'b0;
  always @(posedge ref_40m) begin
    adf_cnt <= adf_cnt + 1'b1;
    if (adf_cnt == 3'd3) adf4001_spi_clk <= 1'b1;
    else if (adf_cnt == 3'd7) begin
      adf4001_spi_clk <= 1'b0;
      adf_cnt <= 3'd0;
    end
  end

  (* ASYNC_REG = "TRUE" *) reg [1:0] cfg_done_sync = 2'b00;
  always @(posedge ref_40m)
    cfg_done_sync <= {cfg_done_sync[0], pll_cfg_done};

  ADF4001_init i_adf4001_init (
    .clk            (adf4001_spi_clk),
    .rst_n          (1'b1),
    .ext_ref_en     (ref_cp_req),
    .mux_sel        (ref_mux_req),
    .cp_active      (pll_cp_active),
    .mux_is         (pll_mux_is),
    .init_done      (pll_cfg_done),
    .SPI_LE         (pll_le),
    .SPI_SCLK       (pll_sclk_adf),
    .SPI_MOSI       (pll_mosi_adf));

  ADF4001_refdet i_adf4001_refdet (
    .clk            (ref_40m),
    .muxout         (pll_muxout),
    .enable         (ref_det_enable),
    .present        (ref_present),
    .count          (ref_count),
    .window         (ref_window),
    .good           (ref_good));

  ADF4001_refctl i_adf4001_refctl (
    .clk            (ref_40m),
    .force_ext      (gpio_o[32]),
    .force_int      (gpio_o[34]),
    .det_present    (ref_present),
    .det_window     (ref_window),
    .det_good       (ref_good),
    .muxout         (pll_muxout),
    .cfg_applied    (cfg_done_sync[1] & (pll_mux_is == ref_mux_req)),
    .cp_en          (ref_cp_req),
    .mux_sel        (ref_mux_req),
    .det_enable     (ref_det_enable),
    .present        (ref_present_out),
    .locked         (ref_locked),
    .state          (ref_state));


  system_wrapper i_system_wrapper (
    .CLKIN_10MHz (ref_10m),
    .CLK_40MHz_FPGA (ref_40m),
    .CLK_40M_DAC_DIN (dac_mosi),
    .CLK_40M_DAC_SCLK (dac_sclk),
    .CLK_40M_DAC_nSYNC (dac_sync_n),
    .PPS_GPS (gps_pps),
    .PPS_IN (pps_ext),
    .PPS_LED (),
    .PPS_LOCKED (),
    .REF_10M_LOCKED (),
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .enable (enable),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .rx_clk_in (rx_clk_in),
    .rx_data_in (rx_data_in),
    .rx_frame_in (rx_frame_in),

    .serial_rx (gps_txd),
    .serial_tx (gps_rxd),
    
    // .ltc2630_mosi_0(ltc2630_mosi_0),
    // .ltc2630_ncs_0(ltc2630_ncs_0),
    // .ltc2630_sclk_0(ltc2630_sclk_0),

    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),

    .tx_clk_out (tx_clk_out),
    .tx_data_out (tx_data_out),
    .tx_frame_out (tx_frame_out),
    .txnrx (txnrx),
    .up_enable (gpio_o[15]),
    .up_txnrx (gpio_o[16]));

endmodule

// ***************************************************************************
// ***************************************************************************


