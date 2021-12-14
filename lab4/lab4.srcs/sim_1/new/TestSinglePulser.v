`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 07:13:11 PM
// Design Name: 
// Module Name: TestSinglePulser
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


module TestSinglePulser();
reg clk, d;
wire q;

always #2 clk = ~clk;
always #2 d = 1;

SinglePulser singlePulser(.q(q), .d(d), .clk(clk));

initial begin
    $monitor();
    #0
    clk = 0;
    d = 0;
    #400
    $finish;
end

endmodule
