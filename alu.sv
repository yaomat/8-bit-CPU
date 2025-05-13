module alu #(
    parameter ADD = 2'b00,
    parameter SUB = 2'b01,
    parameter OR = 2'b10,
    parameter AND = 2'b11
)(
    input logic en,
    input logic clk,
    input logic rst,
    input logic [7:0] a, b,
    input logic [1:0] op,
    output logic [7:0] out,
    output logic f_z,
    output logic f_c
);

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            out <= 8'b0;
            f_z <= 1'b0;
            f_c <= 1'b0;
        end else if (en) begin
            case (op)
                AND: {f_c, out} <= a + b;
                SUB: {f_c, out} <= a - b;
                OR: {f_c, out} <= {0, a | b};
                AND: {f_c, out} <= {0, a & b};
            endcase
            
            f_z = (op == SUB) & en ? (a == b) : 1'b0;

        end
    end


endmodule


module ha (
    input logic a,
    input logic b,
    output logic s,
    output logic cout
);

    assign s = a ^ b;
    assign cout = a & b;

endmodule


module fa1 (
    input logic a,
    input logic b,
    input logic cin,
    output logic s,
    output logic cout
);

    logic x, c0, c1;

    ha ha1 (.a(a), .b(b), .s(x), .cout(c0));
    ha ha2 (.a(x), .b(cin), .s(s), .cout(c1));

    assign cout = c0 | c1;

endmodule


module fa4(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic cin,
    output logic [3:0] s,
    output logic cout
);

    logic x, y, z;

    fa1 add1 (.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .cout(x));
    fa1 add1 (.a(a[1]), .b(b[1]), .cin(x), .s(s[1]), .cout(y));
    fa1 add1 (.a(a[2]), .b(b[2]), .cin(y), .s(s[2]), .cout(z));
    fa1 add1 (.a(a[3]), .b(b[3]), .cin(z), .s(s[3]), .cout(cout));

endmodule