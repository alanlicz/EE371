transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/ram16x8.v}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/FIFO_Control.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/DE1_SoC.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/writePointer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/readPointer.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/hexDisplay.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE\ 371/lab2/lab2_task3 {C:/Users/Alan/Documents/UW/EE 371/lab2/lab2_task3/FIFO.sv}

