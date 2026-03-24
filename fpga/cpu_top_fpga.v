module cpu_top_fpga(
    input  clk,
    input  reset,
    output [5:0] led
);
    wire [15:0] pc;
    
    cpu_top cpu(
        .clk(clk),
        .reset(~reset),
        .pc(pc)        // ← connect pc
    );

    assign led = ~pc[5:0];
endmodule