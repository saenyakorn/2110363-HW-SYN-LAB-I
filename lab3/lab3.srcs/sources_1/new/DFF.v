`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 07:30:08 PM
// Design Name: 
// Module Name: DFF
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


module DFF(
    output reg q = 0,
    input reset,
    input d,
    input clk
    );
always @(posedge clk)
begin
if (reset==0)
    q = d;
else
    q = 0;
end

endmodule
