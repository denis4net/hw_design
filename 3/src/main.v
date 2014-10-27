module clkdiv3(input in, output out); // T = CLK_DIVIDER_VALUE of clk, porosity = 1/2
	wire clk0;
	reg clk1;
	
	BaudRateGenerator sendEveneGenerator(.baudrate(1), .clk(in), .baudclk(clk0));	
	
	always @(posedge clk0)
		clk1 <= ~clk1;
		
	assign out = clk1;
endmodule

module main(
	input clk,   // connected to pin 152 (50MHz)
	input rst, 	 // connected to 0 push button
	input [3:0] baudrate_select,
	input [7:0] data_in, //connected to dip switches
	output tx,   // connected to led0
	output rx,
	output tx_busy,
	output rx_busy, // connected to led1
	output [7:0] rx_reg, 
	output diagnostic
);

	wire send_event;
	BaudRateGenerator sendEveneGenerator(.baudrate(1), .clk(clk), .baudclk(send_event));	
	
	clkdiv3 c0(.in(clk), .out(diagnostic));
			
	UART uart0(.tx_busy(tx_busy), .tx(tx), .wr_i(send_event), .dat_i(data_in), 
		.rx(rx), .rx_busy(rx_busy), .rx_reg(rx_reg),
		.clk(clk), .rst(~rst), .clk_speed_sel(~baudrate_select)
		);
endmodule