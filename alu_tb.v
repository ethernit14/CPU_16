`timescale 1ns/1ps

module alu_tb;
    reg  [15:0] a, b;
    reg  [3:0]  op;
    wire [15:0] result;
    wire zero, carry, negative;

    // instantiate your ALU
    alu uut(.a(a), .b(b), .op(op), 
            .result(result), .zero(zero), 
            .carry(carry), .negative(negative));

    initial begin
        // test ADD
        a = 16'd10; b = 16'd5; op = 4'b0000;
        #10;
        $display("ADD: %d + %d = %d", a, b, result);

        // test SUB
        a = 16'd10; b = 16'd3; op = 4'b0001;
        #10;
        $display("SUB: %d - %d = %d", a, b, result);

        // test AND
        a = 16'hFF00; b = 16'h0FF0; op = 4'b0010;
        #10;
        $display("AND: %h & %h = %h", a, b, result);

        // test zero flag
        a = 16'd5; b = 16'd5; op = 4'b0001;
        #10;
        $display("SUB: %d - %d = %d, zero=%b", a, b, result, zero);

        $finish;
    end
endmodule