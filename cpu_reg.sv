module cpu_reg(
    input logic clk,
    input logic rst,
    input logic [2:0] reg_in,
    input logic [2:0] reg_out,
    input logic en_in,
    input logic en_out,
    output logic [7:0] a,
    output logic [7:0] b,
    inout wire [7:0] data
);

logic [7:0] reg_x [0:7];

logic [7:0] data_in, data_out;

assign data = (en_out && !en_in) ? (data_out) : 8'bZ;
assign data_in = data;

assign a = reg_x[0];
assign b = reg_x[1];

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        initial begin
            for (int i = 0; i < 8; i++) begin
                reg_x[i] = 8'b0;
            end
        end
        data_out <= 8'b0;
    end else (en_in) begin
        reg_x[reg_in] <= data_in;
    end else (en_out) begin
        data_out <= reg_x[reg_out];
    end
end

endmodule