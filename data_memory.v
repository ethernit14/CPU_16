module data_memory (
    input clk,
    input we,
    input [7:0] addr,
    input [15:0] wdata,
    output [15:0] rdata
);

    reg [15:0] ram [0:255];

    // Write logic (sequential)
    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= wdata;
        end
    end

    // Read logic (combinational)
    assign rdata = ram[addr];

endmodule
