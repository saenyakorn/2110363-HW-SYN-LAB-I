`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 11:04:13 AM
// Design Name: 
// Module Name: shiftB
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


module shiftB(q,clock,d);

output [1:0] q;
input clock,d;
reg [1:0] q;

always @(posedge clock)
begin
    q[0]<=d;
    q[1]<=q[0];
end
endmodule
