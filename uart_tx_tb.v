`timescale 1ns/1ns
module uart_tx_tb;
  reg clk = 1'b0;
  reg reset = 1'b0;
  reg load = 1'b0;
  reg [7:0] data_in;
  wire serial_tx;
  wire busy;

  always #5 clk = ~clk;

  initial begin
    $dumpfile("uart_tx_tb.vcd");
    $dumpvars(0, uart_tx_tb);
    // $display("starting sim");
    data_in = 0;
    reset = 1;
    load = 0;
    #20 reset = 0;

    #10 data_in = 8'b10101010;
    #10 load = 1;
    #100 load = 0;

    #106300 data_in = 8'b11111111;
    #10 load = 1;
    #100 load = 0;


    #1000000 $finish;
  end

  uart_tx one( clk, reset, data_in, load, busy, serial_tx);

  always @(serial_tx) begin
    $display("serial_tx = %b at time %t",serial_tx, $time);
  end 

endmodule
