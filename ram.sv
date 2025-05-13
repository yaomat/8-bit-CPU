module ram (
    input logic clk,
    input logic [7:0] addr,
    input logic wm, // write to memory
    input logic wb, // write to bus
    inout wire [7:0] data
);

    logic [7:0] mem [0:255];

    logic [7:0] data_out;

    assign data_out = (wb && !wm) ? mem[addr] : 8'bz;

    always_ff @ (posedge clk) begin
        if (wb) begin
            data <= data_out;
        end else if (wm) begin
            mem[addr] <= data;
        end
    end

endmodule