module busgate4(input [3:0] in, input enabled, output [3:0] out);
	assign out = in & enabled;
endmodule

module busmux4x4(input [15:0] in_bus, input [3:0] sel, output [3:0] out_bus);
	wire [3:0] t_out [0:3];
	busgate4 cell0(in_bus[3:0], sel[0], t_out[0]);
	busgate4 cell1(in_bus[7:4], sel[1], t_out[1]);
	busgate4 cell2(in_bus[11:8], sel[2], t_out[2]);
	busgate4 cell3(in_bus[15:12], sel[3], t_out[3]);
	assign out_bus = t_out[0] | t_out[1] | t_out[2] | t_out[3];
endmodule
