

module fpga_main(input clk, input [7:0] data_in,
				 input clr, input load_1, input load_2,
				 input clken, output [7:0] data, output cled);
	
	wire [7:0] in_data;
	wire clk_div;

	wire constant_0, constant_1;

	assign cled = clk_div;

	assign constant_1 = 1;
	assign constant_0 = 0;

	clkdiv #(.CLK_DIVIDER_VALUE(26'd5000000)) div1(.in(clk), .out(clk_div));

	//COUNTER8 counter0(.DATA(in_data), .NCCLR(clr), .NCCKEN(clken), 
	//				 .CCK(clk_div), .NCLOAD(load_2), .RCK(load_1), .QDATA(data));

	//COUNTER8 counter0(.DATA(in_data), .NCCLR(constant_1), .NCCKEN(constant_0), 
	//				 .CCK(clk_div), .NCLOAD(constant_1), .RCK(clk_div), .QDATA(data));
	
	COUNTER counter1(.CCK(clk_div), .DATA(data_in), .NCCKEN(~clken), 
		.NCLOAD(load_2), .NCCLR(clr), .QDATA(data));
endmodule