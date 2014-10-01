vlib work
vcom -reportprogress 300 -work work adder.vhd main_tb2.vhd buses.vhd main.vhd
vsim work.main_testbench
do wave.do
run 100 ns