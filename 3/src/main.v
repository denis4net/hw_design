
module clkdiv(input in, output out);

    parameter CLK_DIVIDER_WIDTH = 32;
    parameter CLK_DIVIDER_VALUE = 50000000;

    reg [CLK_DIVIDER_WIDTH-1:0] _icounter;
    reg _internal_clk;

    assign out = _internal_clk;

    initial begin
        _icounter = {(CLK_DIVIDER_WIDTH){1'b0}};
        _internal_clk = 0;
    end

    always @(posedge in) begin
        _internal_clk =  (_icounter == {CLK_DIVIDER_VALUE} ) ? 1 : 0;
        _icounter = (_icounter == {CLK_DIVIDER_VALUE} ) ? 0 : _icounter + 1;
    end

endmodule



module main(
	input clk,   // connected to pin 152 (50MHz)
	input send,  // connected to 1 push button
	input rst, 	 // connected to 0 push button
	input [7:0] data_in, //connected to dip switches
	output tx,   // connected to led0
	output busy, // connected to led1
	output diagnostic //connected to led2
	);
	
	// Enable LED2 when send button pressed
	wire send_event;

	clkdiv clkdiv0(.in(clk), .out(send_event));

	assign diagnostic = send_event; 


	uart_tx uart_tx0(.uart_busy(busy), .uart_tx(tx), .uart_wr_i(~send | send_event),
		.uart_dat_i(data_in), .sys_clk_i(clk), .sys_rst_i(~rst)); 



endmodule