module clock_psc (
  input logic clk,
  input logic rst,
  input logic [7:0] lim,
  output logic hzX
);

logic [7:0] counter;

always_ff @ (posedge clk or posedge rst) begin
  if (rst) begin
    hzX <= 0;
    counter <= 0;
  end else if (lim == 0) begin
    hzX <= 0;
  end else begin
    counter <= counter + 1;
    if (counter >= lim) begin
      hzX <= !hzX;
      counter <= 0;
    end
  end
end

endmodule