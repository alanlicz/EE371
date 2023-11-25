onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/xPointer
add wave -noupdate -radix unsigned /line_drawer_testbench/x
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/yPointer
add wave -noupdate -radix unsigned /line_drawer_testbench/y
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/error
add wave -noupdate -radix unsigned /line_drawer_testbench/dut/e2
add wave -noupdate /line_drawer_testbench/reset
add wave -noupdate /line_drawer_testbench/clk
add wave -noupdate -radix decimal -childformat {{{/line_drawer_testbench/dut/deltaY[15]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[14]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[13]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[12]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[11]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[10]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[9]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[8]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[7]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[6]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[5]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[4]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[3]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[2]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[1]} -radix decimal} {{/line_drawer_testbench/dut/deltaY[0]} -radix decimal}} -subitemconfig {{/line_drawer_testbench/dut/deltaY[15]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[14]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[13]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[12]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[11]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[10]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[9]} {-radix decimal} {/line_drawer_testbench/dut/deltaY[8]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[7]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[6]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[5]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[4]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[3]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[2]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[1]} {-height 15 -radix decimal} {/line_drawer_testbench/dut/deltaY[0]} {-height 15 -radix decimal}} /line_drawer_testbench/dut/deltaY
add wave -noupdate -radix decimal -childformat {{{/line_drawer_testbench/dut/deltaX[15]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[14]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[13]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[12]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[11]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[10]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[9]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[8]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[7]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[6]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[5]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[4]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[3]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[2]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[1]} -radix decimal} {{/line_drawer_testbench/dut/deltaX[0]} -radix decimal}} -subitemconfig {{/line_drawer_testbench/dut/deltaX[15]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[14]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[13]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[12]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[11]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[10]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[9]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[8]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[7]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[6]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[5]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[4]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[3]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[2]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[1]} {-radix decimal} {/line_drawer_testbench/dut/deltaX[0]} {-radix decimal}} /line_drawer_testbench/dut/deltaX
add wave -noupdate -radix symbolic /line_drawer_testbench/dut/sy
add wave -noupdate -radix symbolic /line_drawer_testbench/dut/sx
add wave -noupdate -radix decimal /line_drawer_testbench/x0
add wave -noupdate -radix decimal /line_drawer_testbench/x1
add wave -noupdate -radix decimal /line_drawer_testbench/y0
add wave -noupdate -radix decimal /line_drawer_testbench/y1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {222 ps} 0}
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
WaveRestoreZoom {0 ps} {3288 ps}
