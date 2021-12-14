`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 08:58:28 PM
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


module TestALU(

    );
reg [1:0] mode;
reg [3:0] A;
reg [3:0] B;   
wire [15:0] binary;
wire [9:0] addr;
assign addr[9:8] = mode;
assign addr[7:4] = A;
assign addr[3:0] = B;

ALU_BCD alu(.bcd(binary), .addr(addr)); 

initial 
begin
    #0
    mode = 2'b00;
    A = 4'b0010;
    B = 4'b0100;
    #5
    $finish;
end
    
endmodule
