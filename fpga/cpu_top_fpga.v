module cpu_top_fpga(
    input  clk,
    input  reset,
    output [5:0] led
);
    wire [15:0] pc;
    
    cpu_top cpu(
        .clk(clk),
        .reset(~reset)  // button is active low
    );
    
    // Show PC on LEDs
    assign led = ~cpu.pc[5:0];  // active low
endmodule