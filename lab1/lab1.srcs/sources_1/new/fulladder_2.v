`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 09:17:06 AM
// Design Name: 
// Module Name: fulladder_2
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


module fulladder_2(cout, s, a, b, cin);

output cout;
output s;
input a;
input b;
input cin;
assign {cout,s} = a + b + cin;

endmodule
