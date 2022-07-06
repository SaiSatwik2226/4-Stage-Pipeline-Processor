`timescale 1ns / 1ps

module ALU(
    input [7:0] A_in,
	 input [7:0] Imm_Data_EX,
    input [7:0] Sht_Data_EX,
	 input [7:0] PC_EX,
	 input [1:0] opcode_EX,
    input [3:0] ControlLines,
	 input sht_imm,
    output reg [7:0] Result,
    output reg Zero
    );

wire [7:0] A,B;

assign A = (opcode_EX==2'b00)?8'b0:((opcode_EX==2'b11)?PC_EX:A_in);

assign B = (sht_imm)?Sht_Data_EX:Imm_Data_EX;

always @(A or B or ControlLines)
	begin
		case(ControlLines)
			4'b0010: Result = A + B;
			4'b1000: Result = A << B[2:0];	//shift left
		endcase
		
		if (Result == 0)
			Zero = 1;
		else
			Zero = 0;
		
	end
	
endmodule
