`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 09:59:15 AM
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop(q, clock, nreset, d);

output q;
input clock,nreset,d;
reg q;

always @(clock)
begin
    if (nreset==1)
        q=d;
    else
        q=0;
end
endmodule
