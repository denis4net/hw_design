`timescale 100 ns / 1 ns
`include "uart.v"

module testbench;

  reg [7:0] uart_dat_i;
  wire uart_busy, uart_tx;
  reg sys_rst, uart_wr_i, sys_clk;

  wire rx_busy;
  wire [7:0] rx_reg;

  wire bg_clk;

  wire rx = uart_tx;

  initial begin
  	$dumpfile("uart_testbench.vcd");
    $dumpvars(0, uart0);

    sys_clk <= 0;
    sys_rst <= 0;
    uart_dat_i <= 8'b10101111;
    uart_wr_i <= 0;

    #1 sys_rst <= 1;
    #4 sys_rst <= 0;
    #2 uart_wr_i <= 1;
    #4 uart_wr_i <= 0;
    
    #200 uart_dat_i <= 8'hAA;
    #2 uart_wr_i <= 1;
    #4 uart_wr_i <= 0;
    
    #400 $stop();
  end

  always begin
        #1 sys_clk <= ~sys_clk;
  end
  
  UART#(.BAUD_RATE(1), .SYS_CLK_RATE(10)) uart0(
      .tx_busy(uart_busy), .tx(uart_tx), .wr_i(uart_wr_i), .dat_i(uart_dat_i), 
      .clk(sys_clk), .rst(sys_rst), 
      .rx(rx), .rx_busy(rx_busy), .rx_reg(rx_reg)
    ); 

  BaudRateGenerator#(.SYS_CLK_RATE(5)) generator(.baudrate(1), .clk(sys_clk), .rst(sys_rst), .baudclk(bg_clk)); 
endmodule