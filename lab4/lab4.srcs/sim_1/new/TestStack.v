`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 07:46:31 PM
// Design Name: 
// Module Name: TestStack
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


module TestStack();

reg clk;
reg [1:0] mode;
reg [7:0] in;
wire [7:0] num; 
wire [7:0] out;

always #5 clk = ~clk;

Stack stack(.out(out), .num(num), .in(in), .mode(mode), .clk(clk));

initial 
begin
    #0
    clk = 0;mode = 0;in = 0;
    #5
    mode = 1;in = 10;
    #10
    mode = 1;in = 20;
    #15
    mode = 1;in = 30;
    #20
    mode = 0;in = 0;
    #25
    mode = 2;
    #30
    mode = 2;
    #35
    mode = 1;in = 20;
    #40
    mode = 3;
    #45
    mode = 1;in = 10;
    #50
    mode = 2;in = 20;
    #55
    $finish;
end

endmodule
