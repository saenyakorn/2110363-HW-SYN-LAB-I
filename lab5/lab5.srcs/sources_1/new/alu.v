`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : alu.v
// Title        : ALU.
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.
module alu (S, z, Cout, A, B, Cin, alu_ops);

parameter DATA_WIDTH = 32;

output reg [DATA_WIDTH-1:0] S;
output z;
output reg Cout;
input [DATA_WIDTH-1:0] A;
input [DATA_WIDTH-1:0] B;
input Cin;
input [3:0] alu_ops;

assign z=~|S;

always @(A or B or alu_ops or Cin)
begin
	case (alu_ops)
	4'b0000: begin {Cout,S}=A+B+Cin; end
	4'b0001: begin {Cout,S}=A-B; end
	4'b0010: begin S=A|B; Cout=0; end
	4'b0011: begin S=A & B; Cout=0; end
	4'b0100: begin S=A ^ B; Cout=0; end
	4'b0101: begin S=-A; Cout=0; end
	4'b0110: begin S=~A; Cout=0; end
	4'b0111: begin S=~B; Cout=0; end
	4'b1000: begin S=A>>B; Cout=0; end
	endcase
end

endmodule