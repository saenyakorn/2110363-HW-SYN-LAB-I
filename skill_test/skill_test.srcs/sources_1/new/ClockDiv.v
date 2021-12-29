`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 03:23:36 PM
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


module ClockDiv #(
    parameter POWER = 19
    )(
    output reg dClk = 0,
    input clk
    );
    
 reg [POWER-1:0] counter = 0;

always @ (posedge clk) begin
    if(counter == 1 << POWER - 1) dClk = ~dClk;
    counter = counter + 1;
end
    
endmodule
