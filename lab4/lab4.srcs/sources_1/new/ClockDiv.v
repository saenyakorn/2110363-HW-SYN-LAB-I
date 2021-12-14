`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 04:06:54 PM
// Design Name: 
// Module Name: ClockDiv
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


module ClockDiv(
    output reg dClk = 0,
    input clk
    );

parameter POWER = 18;

reg [POWER-1:0] counter = 0;

always @ (posedge clk) begin
    if(counter == 0)dClk <= ~dClk;
    counter <= counter + 1;
end    

endmodule
