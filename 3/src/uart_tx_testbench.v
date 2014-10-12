`timescale 100 ns / 1 ns
`include "uart_tx.v"

module testbench;

  reg [7:0] uart_dat_i;
  wire uart_busy, uart_tx;
  reg sys_rst, uart_wr_i, sys_clk;

  initial begin
	$dumpfile("uart_tx_testbench.vcd");
	$dumpvars(0, uart_tx0);

	$monitor("%b %b %b %x %b %b",
      sys_clk, sys_rst, uart_wr_i, uart_dat_i, uart_busy, uart_tx);
  
    sys_clk <= 0;
    sys_rst <= 1;
    uart_dat_i <= 8'hFF;
    uart_wr_i <= 0;
    
    #4 sys_rst <= 0;
    #2 uart_wr_i <= 1;
    #4 uart_wr_i <= 0;
    
    #40 uart_dat_i <= 8'hAA;
    #2 uart_wr_i <= 1;
    #4 uart_wr_i <= 0;
    
    #200 $finish();
  end

  always begin
        #1 sys_clk <= ~sys_clk;
  end
  
  uart_tx #(.BAUD_RATE(1), .SYS_CLK_RATE(2)) uart_tx0(.uart_busy(uart_busy), .uart_tx(uart_tx), .uart_wr_i(uart_wr_i),
    .uart_dat_i(uart_dat_i), .sys_clk_i(sys_clk), .sys_rst_i(sys_rst)); 
endmodule