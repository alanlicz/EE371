transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/search {C:/Users/Alan/Documents/UW/EE371/lab4/search/ram32x8.v}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/search {C:/Users/Alan/Documents/UW/EE371/lab4/search/binary_search_control.sv}
vlog -sv -work work +incdir+C:/Users/Alan/Documents/UW/EE371/lab4/search {C:/Users/Alan/Documents/UW/EE371/lab4/search/binary_search.sv}

