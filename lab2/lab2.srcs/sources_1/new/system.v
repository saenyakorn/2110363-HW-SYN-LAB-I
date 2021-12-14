`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 11:40:26 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    input clk
    );

wire [3:0] num0;
wire [3:0] num1;
wire [3:0] num2;
wire [3:0] num3;

assign num0 = 4;
assign num1 = 3;
assign num2 = 2;
assign num3 = 1;

wire mClk;
clockDiv div(mClk, clk);

quadSevenSegment q7segment(.seg (seg), 
                           .dp (dp), 
                           .an (an), 
                           .num0 (num0), 
                           .num1 (num1), 
                           .num2 (num2), 
                           .num3 (num3), 
                           .clk (mClk));
    
endmodule
