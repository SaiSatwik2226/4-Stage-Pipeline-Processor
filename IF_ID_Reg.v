`timescale 1ns / 1ps

module IF_ID_Reg(
    input clk,
    input reset,
    input [7:0] Instruction_Code_IF,
	 input [7:0] PC_IF,
    output reg [7:0] Instruction_Code_ID,
	 output reg [7:0] PC_ID
    );

	always @(posedge clk, negedge reset) begin
		if (reset == 1'b0)
			begin 
			Instruction_Code_ID = 8'b0;
			PC_ID = 8'b0;
			end
		else
			begin
			Instruction_Code_ID = Instruction_Code_IF;
			PC_ID = PC_IF;
			end

	end

endmodule
