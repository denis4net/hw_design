vlib work
vcom -reportprogress 300 -work work *.vhd
vsim work.testbench_file
do wave_file.do
run 5500 ps