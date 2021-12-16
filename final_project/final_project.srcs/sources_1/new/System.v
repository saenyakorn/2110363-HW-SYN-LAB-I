`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2021 02:31:56 PM
// Design Name: 
// Module Name: System
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


module System(
    output RsTx,
    output [15:0] led,
    input RsRx,
    input clk
    );
    
    UART uart(.RsTx(RsTx), .led(led), .RsRx(RsRx), .clk(clk));
endmodule
