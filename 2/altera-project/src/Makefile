MULTISIM=/opt/altera/modelsim_ase/bin


# The top level design name
design=main
# The source file(s), the last is the top
src_files=$(wildcard *.vhd)

# Functional Simulation
simfun: $(src_files)
	rm -rf work
	$(MULTISIM)/vlib work
	$(MULTISIM)/vcom -quiet -93 -work work $(src_files)
	$(MULTISIM)/vsim 'work.$(design)_tb' -t 1ns -do 'wave.do'

# Clean all library directories
clean:
	rm -rf functional work transcript vsim.wlf

.PHONY: simfun clean