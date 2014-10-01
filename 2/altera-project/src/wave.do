onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/CCK
add wave -noupdate -radix unsigned /testbench/TEST_DATA
add wave -noupdate -label reg -radix unsigned /testbench/COUNTER80/COLLECTOR0/collector_bus
add wave -noupdate /testbench/NRCO
add wave -noupdate /testbench/RCK
add wave -noupdate /testbench/NCLOAD
add wave -noupdate /testbench/NCCKEN
add wave -noupdate /testbench/COUNTER80/CELL0/t_NS
add wave -noupdate /testbench/COUNTER80/CELL0/t_NR
add wave -noupdate /testbench/COUNTER80/CELL1/t_NS
add wave -noupdate /testbench/COUNTER80/CELL1/t_NR
add wave -noupdate /testbench/COUNTER80/CELL2/t_NS
add wave -noupdate /testbench/COUNTER80/CELL2/t_NR
add wave -noupdate /testbench/COUNTER80/CELL3/t_NS
add wave -noupdate /testbench/COUNTER80/CELL3/t_NR
add wave -noupdate -radix unsigned /testbench/COUNTER80/CARRY
add wave -noupdate -radix unsigned /testbench/COUNTER80/COLLECTOR_IN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5331 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 401
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {4966 ps} {5431 ps}
