

module fpga_main(input clk, input [7:0] data_in,
				 input clr, input load_1, input load_2,
				 input clken, output [7:0] data, output cled);
	
	wire [7:0] in_data;
	wire clk_div;

	wire constant_0, constant_1;

	assign cled = clk_div;

	assign constant_1 = 1;
	assign constant_0 = 0;

	clkdiv #(.CLK_DIVIDER_VALUE(29'd5000000)) div1(.in(clk), .out(clk_div));

	COUNTER8 counter0(.DATA(data_in), .NCCLR(clr), .NCCKEN(~clken), 
					 .CCK(clk_div), .NCLOAD(load_2), .RCK(clk_div), .QDATA(data));

endmodule