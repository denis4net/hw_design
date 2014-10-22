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
	

  	BaudRateGenerator sendEveneGenerator(.baudrate(1), .clk(clk), .rst(rst), .baudclk(send_event));	
	assign diagnostic = send_event;

	UART uart0(.tx_busy(tx_busy), .wr_i(send_event), .dat_i(data_in), .rx(rx), .rx_busy(rx_busy), 
		.rx_reg(rx_reg), .clk(clk), .rst(~rst), .clk_speed_sel(baudrate_select)
		);

endmodule