module ram (
    input logic clk,
    input logic [3:0] addr,
    input logic wm, // write to memory
    input logic wb, // write to bus
    inout wire [7:0] data
);

    logic [7:0] mem [0:15];

    logic [7:0] data_out;

    assign data = (wb && !wm) ? data_out : 8'bz;
    assign data_in = data;

    always_ff @ (posedge clk) begin
        if (wb) begin
            data_out <= mem[addr];
        end else if (wm) begin
            mem[addr] <= data_in;
        end
    end

endmodule