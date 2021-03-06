module BaudRateGenerator(input [28:0] baudrate, input rst, input clk, output baudclk);
  parameter SYS_CLK_RATE = 50000000;

  reg [28:0] d;
  wire [28:0] dInc = d[28] ? (baudrate) : (baudrate - SYS_CLK_RATE);
  
  always @(posedge clk or posedge rst)
  //in case of rst, start couting after T = 1/(baudrate/2)
    d <= (rst) ? ((baudrate - SYS_CLK_RATE) >>> 1 ) : d+dInc;

  assign baudclk = ~d[28] & ~rst; // this is the BAUD_RATE Hz clock
endmodule


module UART(
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
);

  parameter BAUD_RATE = 9600;
  parameter BIT_COUNT = 10;
  parameter SYS_CLK_RATE = 50000000;
  
  //************************************************
  //baudrate selector hw description
  reg [28:0] baud_rate;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      baud_rate <= BAUD_RATE;     
    end
    else begin
      case (clk_speed_sel)
        4'b1000: baud_rate <= 4800;
        4'b0100: baud_rate <= 9600;
        4'b0010: baud_rate <= 57600;
        4'b0001: baud_rate <= 115200;
      endcase
    end
  end

  //************************************************
  // UART transmiter description
  wire tx_clk;
  BaudRateGenerator #(.SYS_CLK_RATE(SYS_CLK_RATE))
    txGenerator(.baudrate(baud_rate), .clk(clk), .rst(rst), .baudclk(tx_clk));

  reg [3:0] bitcount_tx;
  reg [8:0] shifter_tx;
  assign tx_busy = | bitcount_tx[3:1];
  wire sending = | bitcount_tx;

 always @(posedge clk)
  begin
    if (rst) begin
      tx <= 1;
      bitcount_tx <= 0;
      shifter_tx <= 0;
    end
    else begin
      // just got a new byte
      if (wr_i & ~tx_busy)
      begin
        shifter_tx <= { dat_i, 1'h0 };
        bitcount_tx <= (1 + 8 + 1);
      end

      if (sending & tx_clk) begin
        { shifter_tx, tx } <= { 1'h1, shifter_tx };
        bitcount_tx <= bitcount_tx - 1;
      end
    end
  end

  //************************************************
  // UART receiver description
  reg [3:0] bitcount_rx;
  reg [7:0] shifter_rx;
  wire rx_clk;

  BaudRateGenerator #(.SYS_CLK_RATE(SYS_CLK_RATE)) 
    rxGenerator(.baudrate(baud_rate), .clk(clk), .rst(rx_baudrate_rst | rst), .baudclk(rx_clk));

  assign rx_busy = | bitcount_rx;  
  assign rx_baudrate_rst = ~rx_busy;
  wire receiving = bitcount_rx > 1;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst) begin
      bitcount_rx <= 0;
      shifter_rx <= 0;
    end
    else begin
      if (~rx_busy & ~rx) begin //catch first start bit
        shifter_rx <= 0; 
        bitcount_rx <= BIT_COUNT;
      end
      else if (rx_clk & receiving) begin
        shifter_rx <= { rx, shifter_rx[7:1] };  //push start bit and 8 payload bits
        bitcount_rx <= bitcount_rx - 1;         //decrement count of expected bits
      end
      else if (rx_clk & rx_busy)
        bitcount_rx <= 0; //catch last stop bit
    end
  end

  always @(negedge rx_busy or posedge rst)
    rx_reg <= rst ? 0 : shifter_rx;  

endmodule