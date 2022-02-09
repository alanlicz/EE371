transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task2 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task2/hexDisplay.sv}

