`timescale 1ns/1ps

module cpu_tb;
    reg clk, reset;

    cpu_top cpu(
        .clk(clk),
        .reset(reset)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // reset
        reset = 1;
        #20;
        reset = 0;

        // run for 20 cycles    
        #300;
        $finish;
    end

    // monitor what's happening every cycle
    initial begin
        $monitor("t=%0t pc=%0d instr=%b alu=%0d we=%0d R1=%0d R2=%0d R3=%0d R4=%0d mem0=%0d",
            $time,
            cpu.pc,
            cpu.instruction,
            cpu.alu_result,
            cpu.mem_write_en,
            cpu.rf_inst.registers[1],
            cpu.rf_inst.registers[2],
            cpu.rf_inst.registers[3],
            cpu.rf_inst.registers[4],
            cpu.dm_inst.ram[0] 
        );
    end

endmodule