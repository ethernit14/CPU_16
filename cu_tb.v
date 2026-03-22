`timescale 1ns/1ps

module cu_tb;
    reg [3:0] opcode;
    reg is_r_type, is_i_type, is_j_type;
    reg zero, negative;
    wire [3:0] alu_op;
    wire reg_write_en, mem_write_en;
    wire jump_en, branch_en, use_immediate;

    control_unit uut(
        .opcode(opcode),
        .is_r_type(is_r_type),
        .is_i_type(is_i_type),
        .is_j_type(is_j_type),
        .zero(zero),
        .negative(negative),
        .alu_op(alu_op),
        .reg_write_en(reg_write_en),
        .mem_write_en(mem_write_en),
        .jump_en(jump_en),
        .branch_en(branch_en),
        .use_immediate(use_immediate)
    );

    initial begin
        zero = 0; negative = 0;

        // test ADD
        opcode = 4'b0000; is_r_type = 1; is_i_type = 0; is_j_type = 0;
        #10;
        $display("ADD: alu_op=%b reg_wr=%b mem_wr=%b jump=%b branch=%b imm=%b",
                  alu_op, reg_write_en, mem_write_en, jump_en, branch_en, use_immediate);

        // test LDI
        opcode = 4'b1000; is_r_type = 0; is_i_type = 1; is_j_type = 0;
        #10;
        $display("LDI: alu_op=%b reg_wr=%b mem_wr=%b jump=%b branch=%b imm=%b",
                  alu_op, reg_write_en, mem_write_en, jump_en, branch_en, use_immediate);

        // test ST
        opcode = 4'b1011; is_r_type = 0; is_i_type = 1; is_j_type = 0;
        #10;
        $display("ST:  alu_op=%b reg_wr=%b mem_wr=%b jump=%b branch=%b imm=%b",
                  alu_op, reg_write_en, mem_write_en, jump_en, branch_en, use_immediate);

        // test JMP
        opcode = 4'b1100; is_r_type = 0; is_i_type = 0; is_j_type = 1;
        #10;
        $display("JMP: alu_op=%b reg_wr=%b mem_wr=%b jump=%b branch=%b imm=%b",
                  alu_op, reg_write_en, mem_write_en, jump_en, branch_en, use_immediate);

        // test BEQ — zero=0, should NOT branch
        opcode = 4'b1101; is_r_type = 0; is_i_type = 0; is_j_type = 1;
        zero = 0;
        #10;
        $display("BEQ (zero=0): branch=%b (expected 0)", branch_en);

        // test BEQ — zero=1, should branch
        zero = 1;
        #10;
        $display("BEQ (zero=1): branch=%b (expected 1)", branch_en);

        // test NOP
        opcode = 4'b1111; is_r_type = 0; is_i_type = 0; is_j_type = 0;
        #10;
        $display("NOP: reg_wr=%b mem_wr=%b jump=%b branch=%b",
                  reg_write_en, mem_write_en, jump_en, branch_en);

        $finish;
    end
endmodule