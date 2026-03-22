`timescale 1ns/1ps

module id_tb;
    reg [15:0] instruction;
    wire [3:0] opcode;
    wire [2:0] rd, ra, rb;
    wire [15:0] immediate_ext;
    wire is_r_type, is_i_type, is_j_type;

    instruction_decoder uut(
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .ra(ra),
        .rb(rb),
        .immediate_ext(immediate_ext),
        .is_r_type(is_r_type),
        .is_i_type(is_i_type),
        .is_j_type(is_j_type)
    );

    initial begin
        // test ADD R3, R1, R2
        // opcode=0000 rd=011 ra=001 rb=010 unused=000
        instruction = 16'b0000_011_001_010_000;
        #10;
        $display("ADD: opcode=%b rd=%d ra=%d rb=%d R=%b I=%b J=%b",
                  opcode, rd, ra, rb, is_r_type, is_i_type, is_j_type);

        // test LDI R1, 10
        // opcode=1000 rd=001 ra=000 imm=001010
        instruction = 16'b1000_001_000_001010;
        #10;
        $display("LDI: opcode=%b rd=%d imm=%d R=%b I=%b J=%b",
                  opcode, rd, immediate_ext, is_r_type, is_i_type, is_j_type);

        // test JMP 100
        // opcode=1100 imm=000001100100
        instruction = 16'b1100_000001100100;
        #10;
        $display("JMP: opcode=%b imm=%d R=%b I=%b J=%b",
                  opcode, immediate_ext, is_r_type, is_i_type, is_j_type);

        // test NOP
        instruction = 16'b1111_000_000_000000;
        #10;
        $display("NOP: opcode=%b R=%b I=%b J=%b",
                  opcode, is_r_type, is_i_type, is_j_type);

        $finish;
    end
endmodule