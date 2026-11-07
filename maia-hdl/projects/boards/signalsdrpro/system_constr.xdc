#
set_property PACKAGE_PIN n17 [get_ports gpio_resetb]       
#

#  
# 
#


#

#
#
#
#
#
 #
#
#

set_property PACKAGE_PIN n20 [get_ports rx_clk_in]           
#rx_clk_in_p        
set_property PACKAGE_PIN u18 [get_ports rx_frame_in]        
#rx_frame_in_p

set_property PACKAGE_PIN y19 [get_ports {rx_data_in[0]}]     
#rx_data_in_n[0]
set_property PACKAGE_PIN y18 [get_ports {rx_data_in[1]}]    
#rx_data_in_p[0]

set_property PACKAGE_PIN w20 [get_ports {rx_data_in[2]}]    
#rx_data_in_n[1]
set_property PACKAGE_PIN v20 [get_ports {rx_data_in[3]}]   
 #rx_data_in_p[1]

set_property PACKAGE_PIN w19 [get_ports {rx_data_in[4]}]    
#rx_data_in_n[2]
set_property PACKAGE_PIN w18 [get_ports {rx_data_in[5]}]    
#rx_data_in_p[2]

set_property PACKAGE_PIN r17 [get_ports {rx_data_in[6]}]     
#rx_data_in_n[3]
set_property PACKAGE_PIN r16 [get_ports {rx_data_in[7]}]   
#rx_data_in_p[3]

set_property PACKAGE_PIN v18 [get_ports {rx_data_in[8]}]    
#rx_data_in_n[4]
set_property PACKAGE_PIN v17 [get_ports {rx_data_in[9]}]    
#rx_data_in_p[4]

set_property PACKAGE_PIN w16 [get_ports {rx_data_in[10]}]   
#rx_data_in_n[5]
set_property PACKAGE_PIN v16 [get_ports {rx_data_in[11]}]   
#rx_data_in_p[5]

set_property PACKAGE_PIN y17 [get_ports {tx_data_out[0]}]    
#tx_data_out_n[0] 
set_property PACKAGE_PIN y16 [get_ports {tx_data_out[1]}]    
#tx_data_out_p[0] 

set_property PACKAGE_PIN u15 [get_ports {tx_data_out[2]}]   
#tx_data_out_n[1] 
set_property PACKAGE_PIN u14 [get_ports {tx_data_out[3]}]   
#tx_data_out_p[1] 

set_property PACKAGE_PIN w15 [get_ports {tx_data_out[4]}]   
#tx_data_out_n[2] 
set_property PACKAGE_PIN v15 [get_ports {tx_data_out[5]}]   
#tx_data_out_p[2] 

set_property PACKAGE_PIN y14 [get_ports {tx_data_out[6]}]     
#tx_data_out_n[3] 
set_property PACKAGE_PIN w14 [get_ports {tx_data_out[7]}]   
#tx_data_out_p[3] 

set_property PACKAGE_PIN w13 [get_ports {tx_data_out[8]}]    
#tx_data_out_n[4] 
set_property PACKAGE_PIN v12 [get_ports {tx_data_out[9]}]   
#tx_data_out_p[4] 

set_property PACKAGE_PIN u12 [get_ports {tx_data_out[10]}]  
#tx_data_out_n[5] 
set_property PACKAGE_PIN t12 [get_ports {tx_data_out[11]}] 
#tx_data_out_p[5]  

set_property PACKAGE_PIN n18 [get_ports tx_clk_out]       
#tx_clk_out_p
set_property PACKAGE_PIN t16 [get_ports tx_frame_out]     
#tx_frame_out_p



set_property PACKAGE_PIN p14 [get_ports txnrx]    
set_property PACKAGE_PIN r18 [get_ports enable] 
set_property PACKAGE_PIN m14 [get_ports iic_scl]           
set_property PACKAGE_PIN m15 [get_ports iic_sda]        
set_property PACKAGE_PIN p18 [get_ports spi_csn]        
set_property PACKAGE_PIN r14 [get_ports spi_clk]         
set_property PACKAGE_PIN p15 [get_ports spi_mosi]       
set_property PACKAGE_PIN r19 [get_ports spi_miso]        





set_property IOSTANDARD LVCMOS18 [get_ports gpio_resetb]
set_property IOSTANDARD LVCMOS18 [get_ports iic_scl]
set_property IOSTANDARD LVCMOS18 [get_ports iic_sda] 

set_property IOSTANDARD LVCMOS18 [get_ports spi_clk]
set_property IOSTANDARD LVCMOS18 [get_ports spi_csn]
set_property IOSTANDARD LVCMOS18 [get_ports spi_miso]
set_property IOSTANDARD LVCMOS18 [get_ports spi_mosi]
set_property IOSTANDARD LVCMOS18 [get_ports clk_out]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_data_in[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tx_data_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports enable]
set_property IOSTANDARD LVCMOS18 [get_ports rx_clk_in]
set_property IOSTANDARD LVCMOS18 [get_ports rx_frame_in]
set_property IOSTANDARD LVCMOS18 [get_ports tx_clk_out]
set_property IOSTANDARD LVCMOS18 [get_ports tx_frame_out]
set_property IOSTANDARD LVCMOS18 [get_ports txnrx]

create_clock -name rx_clk -period  8 [get_ports rx_clk_in]
create_clock -name clk_fpga_0 -period 10 [get_pins "i_system_wrapper/system_i/sys_ps7/inst/PS7_i/FCLKCLK[0]"]
create_clock -name clk_fpga_1 -period  5 [get_pins "i_system_wrapper/system_i/sys_ps7/inst/PS7_i/FCLKCLK[1]"]

create_clock -name spi0_clk      -period 40   [get_pins -hier */EMIOSPI0SCLKO]

set_input_jitter clk_fpga_0 0.3
set_input_jitter clk_fpga_1 0.15


#set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS18} [get_ports tx1_en]
#WRONG PORT
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS18} [get_ports tx1_en]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS18} [get_ports tx2_en]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS18} [get_ports sel_clk_src]

#set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS18} [get_ports rx1_led ]
#WRONG PORT
set_property -dict {PACKAGE_PIN a20 IOSTANDARD LVCMOS18} [get_ports rx1_led ]
set_property -dict {PACKAGE_PIN b19 IOSTANDARD LVCMOS18} [get_ports rx2_led ]

# GNSS module serial, bank 13 (VCCO 3.3 V), 43 ohm series resistors on the board.
# Schematic (SignalSDRPro Logic diagrams, sheets 40M_REF and PL_IO):
#   U7 IO_L11P_T1_SRCC_13  GPS_TXD_R  module TXD -> FPGA  (serial_rx)
#   U9 IO_L17P_T2_13       GPS_RXD_R  FPGA -> module RXD  (serial_tx)
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports gps_txd]
set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS33} [get_ports gps_rxd]
# GNSS 1PPS (GPS_1PPS_RAW), asynchronous pulse into PS EMIO GPIO 14
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports gps_pps]
set_false_path -from [get_ports gps_pps]

set_false_path -from [get_pins {i_system_wrapper/system_i/axi_ad9361/inst/i_rx/i_up_adc_common/up_adc_gpio_out_int_reg[0]/C}]
set_false_path -from [get_pins {i_system_wrapper/system_i/axi_ad9361/inst/i_tx/i_up_dac_common/up_dac_gpio_out_int_reg[0]/C}]
set_false_path -from [get_pins {i_system_wrapper/system_i/manual_decim/U0/gpio_core_1/Not_Dual.gpio_Data_Out_reg[0]/C}]





 

# ---------------------------------------------------------------------------
# 40 MHz VC-TCXO reference chain (schematic sheet 40M_REF, pins on PL_IO and
# AD936X). Bank 13 is 3.3 V. L16 (bank 35) and T19/T20 (bank 34) sit in 1.8 V
# banks but the board drives them from 3.3 V buffers through 43/51/37 ohm
# series resistors; that is the board as built, not a choice made here.
# ---------------------------------------------------------------------------
# FPGA_CLK: 40 MHz from the oscillator buffer U26B, L16 = IO_L11P_T1_SRCC_35.
# Clock for the ADF4001 blocks, and counted as data by vctcxo_lock.
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS18} [get_ports ref_40m]
create_clock -name clk_40m -period 25 [get_ports ref_40m]
# ADF4001 SPI clock, ref_40m / 8 from the adf4001_spi_clk register in system_top
create_generated_clock -name adf4001_spi_clk -source [get_pins adf4001_spi_clk_reg/C] -divide_by 8 [get_pins adf4001_spi_clk_reg/Q]
# REF_CHK: 10 MHz copy of J13 from the CDC3RL02 buffer, T19 = IO_25_34 (data only)
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS18} [get_ports ref_10m]
# TRIG: PPS input J11, T20
set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS18} [get_ports pps_ext]
set_false_path -from [get_ports {ref_10m pps_ext}]
# DAC8531 U19 and ADF4001 U5 on one SPI bus (bank 13)
set_property -dict {PACKAGE_PIN U5  IOSTANDARD LVCMOS33} [get_ports dac_nsync]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports pll_sck]
set_property -dict {PACKAGE_PIN V6  IOSTANDARD LVCMOS33} [get_ports pll_din]
set_property -dict {PACKAGE_PIN W6  IOSTANDARD LVCMOS33} [get_ports pll_csn]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports pll_muxout]
# 40M-VC-SEL, tune mux U14 select
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports vc_sel]
# ADF4001 MUXOUT = R divider output (10 MHz with the reference present),
# counted by ADF4001_refdet; V11 is not clock capable.
create_clock -name pll_muxout -period 50 [get_ports pll_muxout]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -of_objects [get_ports pll_muxout]]
# Everything crossing between the oscillator domain, MUXOUT and the PS
# clocks goes through two-flop synchronisers or is quasi-static (EMIO).
set_clock_groups -asynchronous -group [get_clocks {clk_40m adf4001_spi_clk}] -group [get_clocks pll_muxout] \
  -group [get_clocks {clk_fpga_0 clk_fpga_1 spi0_clk}]
# While MUXOUT is programmed as lock detect it is a level, sampled by the
# two-flop synchroniser in ADF4001_refctl: no timing relation to clk_40m.
set_false_path -from [get_ports pll_muxout] -to [get_cells -hier -filter {NAME =~ *i_adf4001_refctl/mux_s_reg*}]
