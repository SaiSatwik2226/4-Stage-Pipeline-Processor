`timescale 1ns / 1ps

module Control_Unit(
    input [1:0] opcode,
	 input [2:0] Write_Reg_EX,
	 input [2:0] Write_Reg_WB,
	 input [1:0] opcode_EX,
	 output PC_Select,
	 output sht_imm,
	 output FU_Control,
    output reg [3:0] ALU_Operation,
    output reg RegWrite
    );

always @(opcode) begin
	case(opcode)
		2'b00: ALU_Operation = 4'b0010;
		2'b01: ALU_Operation = 4'b1000;
		2'b11: ALU_Operation = 4'b0010;
		
	endcase
	case(opcode)
		2'b00: RegWrite = 1'b1;
		2'b01: RegWrite = 1'b1;
		2'b11: RegWrite = 1'b0;
	endcase
end

assign FU_Control = (Write_Reg_EX==Write_Reg_WB);
assign PC_Select = (opcode_EX==2'b11);
assign sht_imm = PC_Select;

endmodule
