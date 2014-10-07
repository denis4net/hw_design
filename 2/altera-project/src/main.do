vlib work
vcom -reportprogress 300 -work work *.vhd
vsim work.testbench
do wave.do
run -all