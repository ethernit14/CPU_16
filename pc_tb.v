`timescale 1ns/1ps

module pc_tb;
    reg clk, reset, jump;
    reg [15:0] jump_addr;
    wire [15:0] pc;

    program_counter uut(
        .clk(clk),
        .reset(reset),
        .jump(jump),
        .jump_addr(jump_addr),
        .pc(pc)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; jump = 0; jump_addr = 0;
        #20;
        $display("After reset: pc = %d", pc);

        reset = 0;
        #50;
        $display("After 5 cycles: pc = %d", pc);

        jump = 1; jump_addr = 16'd100;
        #10;
        $display("After jump: pc = %d", pc);

        jump = 0;
        #20;
        $display("After 2 more cycles: pc = %d", pc);

        $finish;
    end
endmodule