module uart_tx(
  input wire clk,
  input wire reset,
  input wire [7:0] data_in,
  input wire load,
  output reg busy = 0,
  output reg serial_tx = 1
);

  wire baud_tick;
  reg [9:0] shift_reg;
  reg [4:0] bit_counter = 0;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      busy <= 0;
      shift_reg <= 0;
      serial_tx <= 1;
      bit_counter <= 0;
    end else if (load && !busy) begin
      shift_reg <= {1'b1,data_in, 1'b0}; // stop_bit, data, start_bit
      busy <= 1;
      bit_counter <= 1;
    end else if (busy && baud_tick) begin
      serial_tx <= shift_reg[0];
      shift_reg <= {1'b1, shift_reg[10:1]}; // padding with stop_bit
      bit_counter <= bit_counter + 1;

      if (bit_counter == 9) begin
        serial_tx <= 1; // ideal high
        bit_counter <= 0;
        busy <= 0;
      end
    end

  end


  baud_rate one ( .clk(clk), .reset(reset), .baud_tick(baud_tick));

endmodule
