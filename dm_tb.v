`timescale 1ns/1ps

module dm_tb;
    reg clk, we;
    reg [7:0] addr;
    reg [15:0] wdata;
    wire [15:0] rdata;

    data_memory uut(
        .clk(clk),
        .we(we),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // write 42 to address 10
        we = 1; addr = 8'd10; wdata = 16'd42;
        @(posedge clk); #1;
        we = 0;
        #10;
        $display("addr=10: %d (expected 42)", rdata);

        // write 100 to address 20
        we = 1; addr = 8'd20; wdata = 16'd100;
        @(posedge clk); #1;
        we = 0;

        // read address 10
        addr = 8'd10; #10;
        $display("addr=10: %d (expected 42)", rdata);

        // read address 20
        addr = 8'd20; #10;
        $display("addr=20: %d (expected 100)", rdata);

        $finish;
    end
endmodule