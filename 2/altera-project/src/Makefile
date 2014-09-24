MULTISIM=/opt/altera/modelsim_ase/bin
PATH:=$PATH:$MULTISIM

# The top level design name
design=main
# The source file(s), the last is the top
src_files=$(wildcard *.vhd)

build:
	vsim "do main.do"
# Clean all library directories
clean:
	rm -rf functional work transcript vsim.wlf

.PHONY: simfun clean