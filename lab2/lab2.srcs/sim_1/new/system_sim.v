`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 06:42:16 PM
// Design Name: 
// Module Name: system_sim
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


module system_sim();

wire [6:0] seg;
wire dp;
wire [3:0] an;

reg [3:0] num0;
reg [3:0] num1;
reg [3:0] num2;
reg [3:0] num3;

reg clk;

quadSevenSegment q7segment(.seg (seg),
                           .dp (dp), 
                           .an (an), 
                           .num0 (num0), 
                           .num1 (num1), 
                           .num2 (num2), 
                           .num3 (num3), 
                           .clk (clk)
                           );

always 
    # 5 clk = ~clk;

initial
begin
    $monitor();
    #0
    num0 = 4;
    num1 = 3;
    num2 = 2;
    num3 = 1;
    clk = 0;
    #100
    $finish;
end


endmodule
