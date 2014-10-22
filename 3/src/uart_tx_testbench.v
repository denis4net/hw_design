`timescale 100 ns / 1 ns
`include "uart.v"

module testbench;

  reg [7:0] uart_dat_i;
  wire uart_busy, uart_tx;
  reg sys_rst, uart_wr_i, sys_clk;

  reg rx;
  wire rx_busy;
  wire [7:0] rx_reg;

  initial begin
  	$dumpfile("uart_testbench.vcd");
    $dumpvars(0, uart0);

    rx <= 1;
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
    
    #4 rx <= 0;
    #4 rx <= 1;
    #4 rx <= 0;
    #4 rx <= 1;

    #200 $finish();
  end

  always begin
        #1 sys_clk <= ~sys_clk;
  end
  
/*
module uart(
   // Transmiter part
   output tx_busy,   // High means UART is transmitting
   output reg tx,     // UART transmit wire
   input wr_i,   // Raise to transmit byte
   input [7:0] dat_i,  // 8-bit data

   //Receiver part
   input rx,
   output rx_busy,
   output reg [7:0] rx_reg,

   input clk,   // System clock, 50 MHz
   input rst,    // System reset

   input [3:0] clk_speed_sel
);*/

  UART#(.BAUD_RATE(1), .SYS_CLK_RATE(2)) uart0(
      .tx_busy(uart_busy), .tx(uart_tx), .wr_i(uart_wr_i), .dat_i(uart_dat_i), 
      .clk(sys_clk), .rst(sys_rst), 
      .rx(rx), .rx_busy(rx_busy), .rx_reg(rx_reg)
    ); 
endmodule