module baud_rate #(
  parameter integer CLK_FREQ = 100_000_000,
  parameter integer BAUD_RATE = 115200
) (
  input wire clk,
  input wire reset,
  output reg baud_tick
);

  localparam integer BAUD_DIVISOR = CLK_FREQ / BAUD_RATE;
  localparam COUNTER_WIDTH = $clog2(BAUD_DIVISOR);
  reg [COUNTER_WIDTH-1:0] counter = 0;

  always @(posedge clk or posedge reset) begin
    // $display(counter);
    if (reset) begin
      counter <= 0;
      baud_tick <= 0;
    end else if (counter == BAUD_DIVISOR -1) begin
      counter <= 0;
      baud_tick <= 1; 
    end else begin
      counter <= counter + 1;
      baud_tick <= 0;
    end

  end

endmodule
