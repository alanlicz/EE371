transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter {C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter/bitCounter.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter {C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter/seg7.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter {C:/Users/Alan/Documents/UW/EE371/lab4/bit_counter/DE1_SoC.sv}

