	create_bd_port -dir O rx1_led
	#create_bd_port -dir O rx2_led
	create_bd_port -dir O tx1_en
	# GNSS module serial (common/uart16550.tcl): serial_rx is the module TXD
	create_bd_port -dir I serial_rx
	create_bd_port -dir O serial_tx
	#create_bd_port -dir O tx2_led
	# 40 MHz VC-TCXO reference discipline (common/libre-vctcxo-lock, see
	# vcxo_ctrl.tcl): the DAC8531 on the tune line, the buffered 40 MHz and
	# 10 MHz copies the board feeds back to the PL, the GNSS 1PPS and the
	# external PPS input J11
	create_bd_port -dir I CLKIN_10MHz
	create_bd_port -dir I CLK_40MHz_FPGA
	create_bd_port -dir O CLK_40M_DAC_DIN
	create_bd_port -dir O CLK_40M_DAC_SCLK
	create_bd_port -dir O CLK_40M_DAC_nSYNC
	create_bd_port -dir I PPS_GPS
	create_bd_port -dir I PPS_IN
	create_bd_port -dir O PPS_LED
	create_bd_port -dir O PPS_LOCKED
	create_bd_port -dir O REF_10M_LOCKED
