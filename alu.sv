module alu #(
    parameter ADD = 3'b000,
    parameter SUB = 3'b001,
    parameter OR  = 3'b010,
    parameter AND = 3'b011,
    parameter XOR = 3'b100,
    parameter NOT = 3'b101,
    parameter INC = 3'b110,
    parameter DEC = 3'b111,
)(
    input logic en,
    input logic clk,
    input logic rst,
    input logic [7:0] a, b,
    input logic [2:0] op,
    output logic [7:0] out,
    output logic f_z,
    output logic f_c
);

    logic [7:0] buffer;

    assign out = buffer;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            buffer <= 8'b0;
            f_z <= 1'b0;
            f_c <= 1'b0;
        end else if (en) begin
            case (op)
                AND: {f_c, buffer} <= a + b;
                SUB: {f_c, buffer} <= a - b;
                OR:  {f_c, buffer} <= {0, a | b};
                AND: {f_c, buffer} <= {0, a & b};
                XOR: {f_c, buffer} <= {0, a ^ b};
                NOT: {f_c, buffer} <= {0, ~a};
                INC: {f_c, buffer} <= a + 1;
                DEC: {f_c, buffer} <= a - 1;
            endcase
            f_z <= &(~buffer);
        end
    end


endmodule