module uart_tx(
  input wire clk,
  input wire reset,
  input wire [7:0] data_in,
  input wire load,
  output reg busy,
  output reg serial_tx
);

  wire baud_tick;
  reg [10:0] padded_value;
  integer i;

  always @(load) begin
    if (load)
      padded_value = {1'b0,data_in, 1'b0,1'b1};
  end

  baud_rate one ( .clk(clk), .reset(reset), .baud_tick(baud_tick));

  always @(posedge baud_tick) begin
      busy = 1'b1;
      serial_tx = padded_value[10];
      padded_value <= {padded_value[9:0], 1'b0 };
  end

endmodule
