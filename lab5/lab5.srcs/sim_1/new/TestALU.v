`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2021 08:41:54 PM
// Design Name: 
// Module Name: TestALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestALU();

parameter DATA_WIDTH = 4;

wire[DATA_WIDTH-1:0] S;
wire z;
wire Cout;
reg [DATA_WIDTH-1:0] A = 9;
reg [DATA_WIDTH-1:0] B = 7;
reg Cin = 0;
reg [3:0] alu_ops = 0;

alu #(.DATA_WIDTH(DATA_WIDTH)) 
    ALU (.S(S), .z(z), .Cout(Cout), .A(A), .B(B), .Cin(Cin), .alu_ops(alu_ops));

always #2 Cin = ~Cin;
always #4 alu_ops = alu_ops !== 8 ? alu_ops + 1 : 0;

initial begin
    #0
    #100
    $finish;
end

endmodule
