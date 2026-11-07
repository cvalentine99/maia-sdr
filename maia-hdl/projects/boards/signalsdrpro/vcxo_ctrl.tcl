# SignalSDRPro 40 MHz VC-TCXO (X2, DSA321SC) discipline through the DAC8531
# (U19) on its tune line, with the vctcxo_lock IP from
# projects/common/libre-vctcxo-lock (register map in vctcxo_lock.md).
#
# The board has two ways to steer the oscillator and a 74LVC1G3157 mux (U14,
# select 40M-VC-SEL on Y13) picks one: this DAC, or the charge pump of an
# ADF4001 PLL (U5) referenced to the external 10 MHz input J13. The ADF4001
# and the mux are handled in system_top.v (ADF4001_* blocks shared with
# plutoskyr2); this IP measures the oscillator against the GNSS 1PPS, the
# external PPS (J11) or the buffered 10 MHz (REF_CHK) and drives the DAC.
#
# Defaults differ from libre: REF_SEL_DEFAULT 2 = PPS_GPS, the onboard
# receiver, so the loop closes on its own once the GNSS has a fix.
# Measured on the bench unit (open-loop sweep, dac_mode=1, GNSS PPS as the
# reference, 0.025 ppm per freq_error count): dac 0 -> -592 counts
# (-14.8 ppm), 32768 -> +67 (+1.7 ppm), 65535 -> +715 (+17.9 ppm), i.e.
# a 32.7 ppm pull range at 0.02 counts per code, monotonic and nearly
# linear, zero crossing near 29500. CENTER_DAC_DEFAULT stays mid-scale
# (the integrator takes up the 3300 codes within a minute; the exact
# crossing drifts with temperature anyway). With that plant gain the
# libre loop gains (124/124, 1/16) would need a 13 minute time constant;
# P x8 and I x2 (131/129) close the loop in about 25 s, settling to
# 0..2 counts with the DAC noise from the PPS jitter below one count.
# Lock is declared at 8 counts (0.2 ppm), well above that jitter.
set vctcxo_lock [ create_bd_cell -type ip -vlnv user.org:user:vctcxo_lock:1.0 vctcxo_lock ]
set_property CONFIG.DEVICE {DAC8531} $vctcxo_lock
set_property CONFIG.CENTER_DAC_DEFAULT {32768} $vctcxo_lock
set_property CONFIG.REF_SEL_DEFAULT {2} $vctcxo_lock
set_property CONFIG.P_SHIFT_DEFAULT {131} $vctcxo_lock
set_property CONFIG.I_SHIFT_DEFAULT {129} $vctcxo_lock
set_property CONFIG.LOCK_THRESH_DEFAULT {8} $vctcxo_lock
ad_connect vctcxo_lock/CLK_40M_DAC_DIN CLK_40M_DAC_DIN
ad_connect vctcxo_lock/CLK_40M_DAC_SCLK CLK_40M_DAC_SCLK
ad_connect vctcxo_lock/CLK_40M_DAC_nSYNC CLK_40M_DAC_nSYNC
ad_connect vctcxo_lock/CLKIN_10MHz CLKIN_10MHz
ad_connect vctcxo_lock/CLK_40MHz_FPGA CLK_40MHz_FPGA
ad_connect vctcxo_lock/PPS_GPS PPS_GPS
ad_connect vctcxo_lock/PPS_IN PPS_IN
ad_connect vctcxo_lock/PPS_LED PPS_LED
ad_connect vctcxo_lock/PPS_LOCKED PPS_LOCKED
ad_connect vctcxo_lock/REF_10M_LOCKED REF_10M_LOCKED
# same base as the other vcxoctrl boards; 0x43C01000-0x43C03000 are the DVB switches
ad_cpu_interconnect 0x43C00000 vctcxo_lock
