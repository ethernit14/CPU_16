module instruction_mem (
    input [7:0] addr,
    output [15:0] instruction
);

    reg [15:0] rom [0:255];
    
    assign instruction = rom[addr];

    initial begin
        rom[0] = 16'b1000001000001010;
        rom[1] = 16'b1000010000000101;
        rom[2] = 16'b0000011001010000;
        rom[3] = 16'b1111000000000000;
    end

endmodule
