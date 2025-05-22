module clock (
    input logic en,
    output logic out
);

always begin
    if (en) begin
        #5 out = 1;
        #5 out = 0;
    end
end

endmodule