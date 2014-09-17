onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal -expand /main_testbench/test
add wave -noupdate -radix hexadecimal -expand /main_testbench/c3
add wave -noupdate -radix hexadecimal -expand /main_testbench/c4
add wave -noupdate -radix hexadecimal -expand /main_testbench/c5
add wave -noupdate -radix hexadecimal -expand /main_testbench/c2
add wave -noupdate -radix hexadecimal -expand /main_testbench/c1
TreeUpdate [SetDefaultTree]
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
WaveRestoreZoom {0 ps} {691 ps}
