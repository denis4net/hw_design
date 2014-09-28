onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /testbench/TEST_DATA
add wave -noupdate /testbench/NCCKEN
add wave -noupdate /testbench/CCK
add wave -noupdate /testbench/NCLOAD
add wave -noupdate /testbench/RCK
add wave -noupdate /testbench/NCCLR
add wave -noupdate /testbench/NRCO
add wave -noupdate -label REG -radix unsigned /testbench/COUNTER80/COLLECTOR0/collector_bus
add wave -noupdate -label D1_Q /testbench/COUNTER80/CELL0/d_q
add wave -noupdate -label D2_Q /testbench/COUNTER80/CELL1/d_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5098 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {4535 ps} {5446 ps}
