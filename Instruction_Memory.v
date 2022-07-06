`timescale 1ns / 1ps

module Instruction_Memory(
    input [7:0] PC,
    input reset,
    output [7:0] Instruction_Code
    );
	reg [7:0] Mem [5:0];

	//For normal memory read we use the following statement
	assign Instruction_Code = Mem[PC];

	//handling reset condition
	always @(reset)
		begin
		if (reset == 0) //if reset is equal to logic 0
		// Initialize the memory with instruction memory
			begin
			$readmemh("Instruction_Memory.mem",Mem);
			
			end
	end

endmodule
