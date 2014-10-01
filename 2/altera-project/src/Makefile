MULTISIM=/opt/altera/modelsim_ase/bin
PATH:=$(PATH):$(MULTISIM)

design=main


testbench1:
	vsim -do main.do

testbench2:
	vsim -do file.do

# Clean all library directories
clean:
	rm -rf functional work transcript vsim.wlf

.PHONY: simfun clean
