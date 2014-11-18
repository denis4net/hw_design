onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/uart_dat_i
add wave -noupdate /testbench/uart_busy
add wave -noupdate /testbench/uart_tx
add wave -noupdate /testbench/sys_rst
add wave -noupdate /testbench/uart_wr_i
add wave -noupdate /testbench/sys_clk
add wave -noupdate /testbench/rx
add wave -noupdate /testbench/rx_busy
add wave -noupdate /testbench/rx_reg
add wave -noupdate /testbench/uart0/rx_clk
add wave -noupdate /testbench/uart0/tx_clk
add wave -noupdate /testbench/uart0/rx_baudrate_rst
add wave -noupdate /testbench/uart0/shifter_tx
add wave -noupdate /testbench/uart0/shifter_rx
add wave -noupdate /testbench/generator/clk
add wave -noupdate /testbench/bg_clk
add wave -noupdate /testbench/generator/baudrate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6119 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
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
WaveRestoreZoom {0 ns} {30208 ns}
