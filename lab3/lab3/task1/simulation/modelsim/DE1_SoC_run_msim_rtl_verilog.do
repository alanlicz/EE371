transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task1 {C:/Users/Alan/Documents/UW/EE371/lab3/task1/line_drawer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task1 {C:/Users/Alan/Documents/UW/EE371/lab3/task1/VGA_framebuffer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task1 {C:/Users/Alan/Documents/UW/EE371/lab3/task1/DE1_SoC.sv}

