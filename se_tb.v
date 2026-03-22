`timescale 1ns/1ps

module se_tb;
    reg [5:0] imm;
    wire [15:0] extended;

    // instantiate
    sign_extender uut(
        .imm(imm),
        .extended(extended)
    );

    initial begin
        // test positive number
        imm = 6'b001010;  // +10
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test negative number
        imm = 6'b100001;  // negative
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test zero
        imm = 6'b000000; // zero
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test max positive
        imm = 6'b011111;  // +31
        #10;
        $display("imm=%b extended=%b", imm, extended);

        // test max positive
        imm = 6'b100000;  // -32
        #10;
        $display("imm=%b extended=%b", imm, extended);

        $finish;
    end
endmodule
