`timescale 100 ns / 1 ns

/*
module uart(
   // Outputs
   output uart_busy,   // High means UART is transmitting
   output uart_tx,     // UART transmit wire
   // Inputs
   input uart_wr_i,   // Raise to transmit byte
   input [7:0] uart_dat_i,  // 8-bit data
   input sys_clk_i,   // System clock, 50 MHz
   input sys_rst_i    // System reset
);
*/

module testbench();

  wire [7:0] uart_dat_i;
  wire uart_busy, uart_tx, uart_clk, uart_rst, uart_wr_i;

  initial begin
    uart_clk <= 0;
    uart_rst <= 1;
    uart_wr_i <= 0;
    uart_dat_i <= 8'hFF;

    #10 uart
  end

  uart_tx uart_tx0(.uart_busy(uart_busy), .uart_tx(uart_tx), .uart_wr_i(uart_wr_i),
    .uart_dat_i(uart_dat_i), .sys_clk_i(sys_clk), .sys_rst(sys_rst));

  $dumpfile("clkdiv_tb.vcd");
  $dumpvars(0, uart_tx0);

  $monitor("%b %b %b %b %x %b %b",
      uart_clk, uart_rst, uaart_wr_i, uart_dat_i, uart_busy, uart_tx);
  
  #1 uart_clk = ~uart_clk;
endmodule