`timescale 1ns/1ps

module rf_tb;
    reg clk, reset, write_en;
    reg [2:0] read_addr1, read_addr2, write_addr;
    reg [15:0] write_data;
    wire [15:0] read_data1, read_data2;

    register_file uut(
        .clk(clk),
        .reset(reset),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_en(write_en),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // reset
        reset = 1; write_en = 0;
        read_addr1 = 3'd1;
        read_addr2 = 3'd2;
        write_addr = 3'd0;
        write_data = 16'd0;
        
        // wait a few cycles for initialization
        #20;
        @(posedge clk); #1;
        reset = 0;
        $display("After reset: R1=%d R2=%d", read_data1, read_data2);

        // write 42 to R3
        write_en = 1; write_addr = 3'd3; write_data = 16'd42;
        @(posedge clk); #1;
        write_en = 0;
        read_addr1 = 3'd3;
        #10;
        $display("R3 = %d (expected 42)", read_data1);

        // write 100 to R5
        write_en = 1; write_addr = 3'd5; write_data = 16'd100;
        @(posedge clk); #1;
        write_en = 0;
        read_addr1 = 3'd3;
        read_addr2 = 3'd5;
        #10;
        $display("R3 = %d, R5 = %d (expected 42, 100)", read_data1, read_data2);

        // try writing to R0
        write_en = 1; write_addr = 3'd0; write_data = 16'd999;
        @(posedge clk); #1;
        write_en = 0;
        read_addr1 = 3'd0;
        #10;
        $display("R0 = %d (expected 0)", read_data1);

        $finish;
    end
endmodule