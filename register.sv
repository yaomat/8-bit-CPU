 module register (
    input logic [7:0] in,
    input logic clk,
    input logic rst,
    input logic bw_en, //write to the bus
    input logic br_en, //read from the bus
    output logic [7:0] out 
 );

    logic [7:0] hold;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            out <= 8'b0; 
            hold <= 8'b0;
        end else if (bw_en) begin 
            out <= hold;
        end else if (br_en) begin
            hold <= in;
        end
    end

 endmodule