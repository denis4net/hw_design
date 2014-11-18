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

module clkdiv2(input in, output out); // T = CLK_DIVIDER_VALUE of clk, porosity = 1/2
	wire clk0;
	reg clk1;
	
	clkdiv clkdiv0(.in(clk), .out(clk0));
	
	always @(posedge clk0)
		clk1 <= ~clk1;
		
	assign out = clk1;
endmodule
