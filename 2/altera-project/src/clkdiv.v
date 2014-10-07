`include "constants.v"

`ifndef _clkdiv
`define _clkdiv

module clkdiv(input in, output out);

    parameter CLK_DIVIDER_WIDTH = `CLK_DIVIDER_WIDTH;
    parameter CLK_DIVIDER_VALUE = `CLK_DIVIDER_VALUE;

    reg [CLK_DIVIDER_WIDTH-1:0] _icounter;
    reg _internal_clk;

    assign out = _internal_clk;


    initial begin
        _icounter = {(CLK_DIVIDER_WIDTH){1'b0}};
        _internal_clk = 0;
    end

    always @(posedge in) begin
        _internal_clk =  (_icounter == {CLK_DIVIDER_VALUE} ) ? ~_internal_clk : _internal_clk;
        _icounter = (_icounter == {CLK_DIVIDER_VALUE} ) ? 0 : _icounter + 1;
    end

endmodule


module COUNTER(  input [7:0] DATA, input NCCLR, input NCCKEN, input CCK,
                    input NCLOAD, input RCK, output [7:0] QDATA);

    parameter CLK_DIVIDER_WIDTH = 8;

    reg [CLK_DIVIDER_WIDTH-1:0] _icounter;

    assign QDATA = _icounter;

    initial begin
        _icounter = {(CLK_DIVIDER_WIDTH){1'b0}};
    end

    always @(posedge CCK) begin
        if (~NCCKEN) begin
            if (~NCCLR) begin
                _icounter = 8'h0;
            end
            else if (~NCLOAD) begin
                _icounter = DATA;
            end
            else begin
                _icounter =  _icounter + 1;
            end
        end
    end

endmodule


`endif