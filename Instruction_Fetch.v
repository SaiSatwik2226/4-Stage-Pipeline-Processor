`timescale 1ns / 1ps

module Instruction_Fetch(
    input clk,
    input reset,
	 input PC_Select,
	 input [7:0] Result_EX,
    output [7:0] Instruction_Code,
	 output [7:0] PC_out,
	 output reg reset_IFID,
	 output reg reset_IDEX,
	 output reg reset_EXWB
    );
	 reg [7:0] PC;
	Instruction_Memory mem(PC, reset, Instruction_Code);
	assign PC_out = PC;
	always @(posedge clk, negedge reset)
		begin
		if (reset == 1'b0)
			begin 
			PC <= 0;
			reset_IFID = 1;
			reset_IDEX = 1;
			reset_EXWB = 1;
			end
		else
			begin
			if(PC_Select==1'b1)
				begin 
				PC = Result_EX;
				reset_IFID = 0;
				reset_IDEX = 0;
				end
			PC <= PC + 1'b1;			
			end
		end
		always @(negedge clk)
		begin
			reset_IFID = 1;
			reset_IDEX = 1;
			reset_EXWB = 1;
			end
endmodule
