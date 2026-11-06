	create_bd_port -dir O rx1_led
	#create_bd_port -dir O rx2_led
	create_bd_port -dir O tx1_en
	# GNSS module serial (common/uart16550.tcl): serial_rx is the module TXD
	create_bd_port -dir I serial_rx
	create_bd_port -dir O serial_tx
	#create_bd_port -dir O tx2_led