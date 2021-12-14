`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 08:40:37 AM
// Design Name: 
// Module Name: fulladder
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


module fulladder(
    output cout,
    output s,
    input a,
    input b,
    input cin
    );
    
reg cout;
reg s;

always @(a or b or cin)
begin 
    {cout, s} = a + b + cin;
end


endmodule
