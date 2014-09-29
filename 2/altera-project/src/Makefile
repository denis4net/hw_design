MULTISIM=/opt/altera/modelsim_ase/bin
PATH:=$(PATH):$(MULTISIM)

design=main

generate:
	vsim -do main.do
file_test:
	vsim -do file.do

# Clean all library directories
clean:
	rm -rf functional work transcript vsim.wlf

.PHONY: simfun clean
