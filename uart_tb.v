module uart_baud_gen_tb;
  reg clk = 0;
  reg reset = 1;
  wire baud_tick;


  baud_rate uut (.clk(clk), .reset(reset), .baud_tick(baud_tick));

  always #5 clk = ~clk;

  initial begin
    $display("starting sim");
    #10 reset = 0;
    #1000 $finish;
  end

  always @(posedge baud_tick) begin
    $display("Baud tick at time %t", $time);
  end
endmodule
