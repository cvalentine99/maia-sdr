# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEVICE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CENTER_DAC_DEFAULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "REF_SEL_DEFAULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "P_SHIFT_DEFAULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "I_SHIFT_DEFAULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOCK_THRESH_DEFAULT" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.CENTER_DAC_DEFAULT { PARAM_VALUE.CENTER_DAC_DEFAULT } {
	# Procedure called to update CENTER_DAC_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CENTER_DAC_DEFAULT { PARAM_VALUE.CENTER_DAC_DEFAULT } {
	# Procedure called to validate CENTER_DAC_DEFAULT
	return true
}

proc update_PARAM_VALUE.REF_SEL_DEFAULT { PARAM_VALUE.REF_SEL_DEFAULT } {
	# Procedure called to update REF_SEL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REF_SEL_DEFAULT { PARAM_VALUE.REF_SEL_DEFAULT } {
	# Procedure called to validate REF_SEL_DEFAULT
	return true
}

proc update_PARAM_VALUE.P_SHIFT_DEFAULT { PARAM_VALUE.P_SHIFT_DEFAULT } {
	# Procedure called to update P_SHIFT_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.P_SHIFT_DEFAULT { PARAM_VALUE.P_SHIFT_DEFAULT } {
	# Procedure called to validate P_SHIFT_DEFAULT
	return true
}

proc update_PARAM_VALUE.I_SHIFT_DEFAULT { PARAM_VALUE.I_SHIFT_DEFAULT } {
	# Procedure called to update I_SHIFT_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.I_SHIFT_DEFAULT { PARAM_VALUE.I_SHIFT_DEFAULT } {
	# Procedure called to validate I_SHIFT_DEFAULT
	return true
}

proc update_PARAM_VALUE.LOCK_THRESH_DEFAULT { PARAM_VALUE.LOCK_THRESH_DEFAULT } {
	# Procedure called to update LOCK_THRESH_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOCK_THRESH_DEFAULT { PARAM_VALUE.LOCK_THRESH_DEFAULT } {
	# Procedure called to validate LOCK_THRESH_DEFAULT
	return true
}

proc update_PARAM_VALUE.DEVICE { PARAM_VALUE.DEVICE } {
	# Procedure called to update DEVICE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEVICE { PARAM_VALUE.DEVICE } {
	# Procedure called to validate DEVICE
	return true
}


proc update_MODELPARAM_VALUE.CENTER_DAC_DEFAULT { MODELPARAM_VALUE.CENTER_DAC_DEFAULT PARAM_VALUE.CENTER_DAC_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CENTER_DAC_DEFAULT}] ${MODELPARAM_VALUE.CENTER_DAC_DEFAULT}
}

proc update_MODELPARAM_VALUE.REF_SEL_DEFAULT { MODELPARAM_VALUE.REF_SEL_DEFAULT PARAM_VALUE.REF_SEL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REF_SEL_DEFAULT}] ${MODELPARAM_VALUE.REF_SEL_DEFAULT}
}

proc update_MODELPARAM_VALUE.P_SHIFT_DEFAULT { MODELPARAM_VALUE.P_SHIFT_DEFAULT PARAM_VALUE.P_SHIFT_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.P_SHIFT_DEFAULT}] ${MODELPARAM_VALUE.P_SHIFT_DEFAULT}
}

proc update_MODELPARAM_VALUE.I_SHIFT_DEFAULT { MODELPARAM_VALUE.I_SHIFT_DEFAULT PARAM_VALUE.I_SHIFT_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.I_SHIFT_DEFAULT}] ${MODELPARAM_VALUE.I_SHIFT_DEFAULT}
}

proc update_MODELPARAM_VALUE.LOCK_THRESH_DEFAULT { MODELPARAM_VALUE.LOCK_THRESH_DEFAULT PARAM_VALUE.LOCK_THRESH_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOCK_THRESH_DEFAULT}] ${MODELPARAM_VALUE.LOCK_THRESH_DEFAULT}
}

proc update_MODELPARAM_VALUE.DEVICE { MODELPARAM_VALUE.DEVICE PARAM_VALUE.DEVICE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEVICE}] ${MODELPARAM_VALUE.DEVICE}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}
