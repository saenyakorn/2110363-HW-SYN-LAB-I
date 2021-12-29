`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 04:06:05 PM
// Design Name: 
// Module Name: TestClockDiv
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


module TestClockDiv();
wire dClk;
reg clk;

ClockDiv #(.POWER(4)) clockDiv (.dClk(dClk), .clk(clk));

always #2 clk = ~clk;

initial begin
    #0
    clk = 0;
    #1000
    $finish;
end

endmodule
