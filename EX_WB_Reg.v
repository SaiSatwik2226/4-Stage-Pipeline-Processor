`timescale 1ns / 1ps

module EX_WB_Reg(
    input clk,
    input reset,
	 input [7:0] PC_EX,
    input RegWrite_EX,
    input [7:0] Result_EX,
    input [2:0] Write_Reg_EX,
	 output reg [7:0] PC_WB,
    output reg RegWrite_WB,
    output reg [7:0] Result_WB,
    output reg [2:0] Write_Reg_WB
    );

	always @(posedge clk, negedge reset) begin
		if (reset == 1'b0) begin
			RegWrite_WB = 1'b0;
			Result_WB = 8'b0;
			Write_Reg_WB = 3'b0;
			PC_WB = 8'b0;
		end
			
		else begin
			RegWrite_WB = RegWrite_EX;
			Result_WB = Result_EX;
			Write_Reg_WB = Write_Reg_EX;
			PC_WB = PC_EX;
		end

	end

endmodule
