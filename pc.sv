module pc (
    input logic clk,
    input logic rst,
    input logic en_cnt,
    input logic en_out,
    input logic en_jmp,
    inout wire [3:0] data,
);

logic [3:0] count;
logic [3:0] data_in, data_out;

assign data = (en_out && !en_jmp) ? (data_out) : 8'bZ;
assign data_in = data;

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        count <= 3'b0;
        data_out <= 3'b0;
    end else if (en_cnt) begin
        count <= count + 1;
    end else if (en_jmp) begin
        count <= data_in;
    end else if (en_out) begin
        data_out <= count;
    end

end

endmodule