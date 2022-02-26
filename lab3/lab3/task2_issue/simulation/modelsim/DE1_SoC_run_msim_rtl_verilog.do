transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task2 {C:/Users/Alan/Documents/UW/EE371/lab3/task2/line_drawer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task2 {C:/Users/Alan/Documents/UW/EE371/lab3/task2/VGA_framebuffer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task2 {C:/Users/Alan/Documents/UW/EE371/lab3/task2/clock_divider.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task2 {C:/Users/Alan/Documents/UW/EE371/lab3/task2/animate.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab3/task2 {C:/Users/Alan/Documents/UW/EE371/lab3/task2/DE1_SoC.sv}

