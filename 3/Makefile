SRC=uart_tx_testbench.v
OBJ=$(patsubst %.v, %.o, $(SRC))

all: $(OBJ)

*.v:
	iverilog $< -o $@

clean: $(OBJ)
	rm -rf $(OBJ)

