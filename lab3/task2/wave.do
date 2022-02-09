onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/xPointer
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/yPointer
add wave -noupdate -radix unsigned /line_drawer_testbench/x
add wave -noupdate -radix unsigned /line_drawer_testbench/y
add wave -noupdate /line_drawer_testbench/reset
add wave -noupdate /line_drawer_testbench/clk
add wave -noupdate /line_drawer_testbench/dut/deltaY
add wave -noupdate /line_drawer_testbench/dut/deltaX
add wave -noupdate -radix symbolic /line_drawer_testbench/dut/sy
add wave -noupdate -radix symbolic /line_drawer_testbench/dut/sx
add wave -noupdate /line_drawer_testbench/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1032 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5330 ps}
