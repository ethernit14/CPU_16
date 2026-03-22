`timescale 1ns/1ps
module im_tb;
    reg [7:0] addr;
    wire [15:0] instruction;

    instruction_mem uut(
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        addr = 0; #10;
        $display("addr=%0d instruction=%b", addr, instruction);
        
        addr = 1; #10;
        $display("addr=%0d instruction=%b", addr, instruction);
        
        addr = 2; #10;
        $display("addr=%0d instruction=%b", addr, instruction);
        
        addr = 3; #10;
        $display("addr=%0d instruction=%b", addr, instruction);
        
        $finish;
    end
endmodule