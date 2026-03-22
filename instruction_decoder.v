module instruction_decoder (
    input [15:0] instruction,
    output [3:0] opcode,
    output [2:0] rd,
    output [2:0] ra,
    output [2:0] rb,
    output [15:0] immediate_ext,
    output reg is_r_type,
    output reg is_i_type,
    output reg is_j_type
);

    // Extract opcode and register fields
    assign opcode = instruction[15:12];
    assign rd = instruction[11:9];
    assign ra = instruction[8:6];
    assign rb = instruction[5:3];
    
    // 6-bit immediate for I-type (sign-extended to 16-bit)
    wire [5:0] imm_6 = instruction[5:0];
    wire [15:0] imm_6_ext = {{10{imm_6[5]}}, imm_6};
    
    // 12-bit immediate for J-type (sign-extended to 16-bit)
    wire [11:0] imm_12 = instruction[11:0];
    wire [15:0] imm_12_ext = {{4{imm_12[11]}}, imm_12};
    
    // Select appropriate immediate based on instruction type
    assign immediate_ext = is_i_type ? imm_6_ext : imm_12_ext;
    
    // Decode instruction type based on opcode
    always @(*) begin
        case(opcode)
            // R-type instructions (opcodes 0000-0111)
            4'b0000: begin  // ADD
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0001: begin  // SUB
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0010: begin  // AND
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0011: begin  // OR
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0100: begin  // XOR
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0101: begin  // SHL
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0110: begin  // SHR
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            4'b0111: begin  // SLT
                is_r_type = 1;
                is_i_type = 0;
                is_j_type = 0;
            end
            
            // I-type instructions (opcodes 1000-1011)
            4'b1000: begin  // LDI
                is_r_type = 0;
                is_i_type = 1;
                is_j_type = 0;
            end
            4'b1001: begin  // ADDI
                is_r_type = 0;
                is_i_type = 1;
                is_j_type = 0;
            end
            4'b1010: begin  // LD
                is_r_type = 0;
                is_i_type = 1;
                is_j_type = 0;
            end
            4'b1011: begin  // ST
                is_r_type = 0;
                is_i_type = 1;
                is_j_type = 0;
            end
            
            // J-type instructions (opcodes 1100-1110)
            4'b1100: begin  // JMP
                is_r_type = 0;
                is_i_type = 0;
                is_j_type = 1;
            end
            4'b1101: begin  // BEQ
                is_r_type = 0;
                is_i_type = 0;
                is_j_type = 1;
            end
            4'b1110: begin  // BLT
                is_r_type = 0;
                is_i_type = 0;
                is_j_type = 1;
            end
            
            // NOP and others
            default: begin
                is_r_type = 0;
                is_i_type = 0;
                is_j_type = 0;
            end
        endcase
    end

endmodule
