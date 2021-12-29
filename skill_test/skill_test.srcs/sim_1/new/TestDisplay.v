`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 04:06:18 PM
// Design Name: 
// Module Name: TestDisplay
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


module TestDisplay();

wire [3:0] an;
wire [6:0] seg;
wire dp;
reg [15:0] hex = 16'h1234;
reg [3:0] dpos = 4'b1010;
reg clk = 0;

Display display(.an(an), .seg(seg), .dp(dp), .hex(hex), .dpos(dpos), .clk(clk));

always #2 clk = ~clk;

initial begin
    #0
    clk = 0;
    #1000
    $finish;
end
endmodule

module TestConvertor();

reg clk;
wire [6:0] seg;
reg [3:0] hex = 0;

HexToSevenSegment convertor(.seg(seg), .hex(hex));

always #2 clk = ~clk;
always #2 hex = hex + 1;

initial begin
    #0
    clk = 0;
    #100
    $finish;
end


endmodule
