module uart_tx(
   // Outputs
   output uart_busy,   // High means UART is transmitting
   output reg uart_tx,     // UART transmit wire
   // Inputs
   input uart_wr_i,   // Raise to transmit byte
   input [7:0] uart_dat_i,  // 8-bit data
   input sys_clk_i,   // System clock, 50 MHz
   input sys_rst_i    // System reset
);

  parameter BAUD_RATE = 9600;
  parameter SYS_CLK_RATE = 50000000;

  reg [3:0] bitcount;
  reg [8:0] shifter;

  assign uart_busy = | bitcount[3:1];
  wire sending = | bitcount;

  // sys_clk_i is 50MHz.  We want a 9600Hz clock

  reg [28:0] d;
  wire [28:0] dInc = d[28] ? (BAUD_RATE) : (BAUD_RATE - SYS_CLK_RATE);
  wire [28:0] dNxt = d + dInc;
  
  always @(posedge sys_clk_i)
  begin
    if (sys_rst_i) begin
      d = 29'h0;
    end
    else 
      d = dNxt;
  end
  
  wire ser_clk = ~d[28]; // this is the BAUD_RATE Hz clock

  always @(posedge sys_clk_i)
  begin
    if (sys_rst_i) begin
      uart_tx <= 1;
      bitcount <= 0;
      shifter <= 0;
    end
    else begin
      // just got a new byte
      if (uart_wr_i & ~uart_busy) begin
        shifter <= { uart_dat_i[7:0], 1'h0 };
        bitcount <= (1 + 8 + 1);
      end

      if (sending & ser_clk) begin
        { shifter, uart_tx } <= { 1'h1, shifter };
        bitcount <= bitcount - 1;
      end
    end
  end

endmodule