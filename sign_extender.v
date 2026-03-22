module sign_extender (
	input [7:0] imm,
	output [15:0] extended
);

	assign extended = { {8{imm[7]}}, imm };
	
endmodule