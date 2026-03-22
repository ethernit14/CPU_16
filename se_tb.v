`timescale 1ns/1ps

module se_tb;
    reg [7:0] imm;
    wire [15:0] extended;

    // instantiate
    sign_extender uut(
        .imm(imm),
        .extended(extended)
    );

    initial begin
        // test positive number
        imm = 8'b00001010;  // +10
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test negative number
        imm = 8'b10000001;  // -127
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test zero
        imm = 8'b00000000;
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test max positive
        imm = 8'b01111111;  // +127
        #10;
        $display("imm=%b extended=%b", imm, extended);

        $finish;
    end
endmodule