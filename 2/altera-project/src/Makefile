MULTISIM=/opt/altera/modelsim_ase/bin
PATH:=$(PATH):$(MULTISIM)

design=main


test0:
	vsim -do main.do

test1:
	vsim -do file.do

# Clean all library directories
clean:
	rm -rf functional work transcript vsim.wlf

.PHONY: simfun clean
