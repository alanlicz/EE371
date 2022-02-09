transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab3 {C:/Users/Alan/Documents/UW/EE 371/lab3/line_drawer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab3 {C:/Users/Alan/Documents/UW/EE 371/lab3/VGA_framebuffer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab3 {C:/Users/Alan/Documents/UW/EE 371/lab3/DE1_SoC.sv}

