module control#(
    parameter ADD = 3'b000,
    parameter SUB = 3'b001,
    parameter OR  = 3'b010,
    parameter AND = 3'b011,
    parameter XOR = 3'b100,
    parameter NOT = 3'b101,
    parameter INC = 3'b110,
    parameter DEC = 3'b111,

    parameter ALU = 2'b11,
    parameter JMP = 3'b011,
    parameter MOV = 2'b10,
    parameter SWAP = 2'b00,
    parameter LD_WR = 3'b010,

    parameter STATE_PC_OUT = 4'b0000,
    parameter STATE_RAM_OUT = 4'b0001,
    parameter STATE_FETCH_INSTR = 4'b0010,
    parameter STATE_DECODE = 4'b0011



)(
    input logic clk, rst,
    input logic f_z, f_c
    output logic pc_en_cnt, pc_en_jmp, pc_en_out,
    output logic alu_en,
    output logic [2:0] alu_op,
    output logic reg_en_in, reg_en_out,
    output logic [2:0] reg_sel_in, reg_sel_out, reg_sel_b,
    output logic mar_en_r, mar_en_w,
    output logic ram_wm, ram_wb,
    inout wire [7:0] data
);

    logic [7:0] load;
    logic [7:0] instr;
    logic [3:0] state = STATE_PC_OUT; //may need to change size
    logic [3:0] nextstate = STATE_PC_OUT;



    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            state <= STATE_PC_OUT;
            load <= 8'b0;
            instr <= 8'b0;
        end else begin
            state <= nextstate;
            if (state == STATE_FETCH_INSTR) begin
                instr <= data;
            end



        end

    end

    always_comb begin
        nextstate = state;
        pc_en_cnt = 1'b0;
        pc_en_jmp = 1'b0;
        pc_en_out = 1'b0;
        alu_en = 1'b0;
        alu_op = 3'b0;
        reg_en_in = 1'b0;
        reg_en_out = 1'b0;
        reg_sel_in = 3'b0;
        reg_sel_out = 3'b0;
        reg_sel_b = 3'b0;
        mar_en_r = 1'b0;
        mar_en_w = 1'b0;
        ram_wm = 1'b0;
        ram_wb = 1'b0;

        case (state)
            STATE_PC_OUT: begin
                pc_en_out = 1;
                mar_en_r = 1;
                nextstate = STATE_RAM_OUT;
            end
            STATE_RAM_OUT: begin
                mar_en_w = 1;
                ram_wb = 1;
                nextstate = STATE_FETCH_INSTR;
            end
            STATE_FETCH_INSTR: begin
                nextstate = STATE_DECODE;
            end


        endcase



    end

endmodule