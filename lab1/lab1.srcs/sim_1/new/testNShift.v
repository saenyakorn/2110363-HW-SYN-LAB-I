`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2021 07:07:17 PM
// Design Name: 
// Module Name: testNShift
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


module testNShift();
    parameter MSB = 8;
    
    reg d;
    reg clk;
    wire [MSB-1: 0] out;
    
    NShift #(MSB) s0 (.d (d), .clk (clk), .out (out));
    
    always #10 clk = ~clk;
    always #7 d = ~d;
    
    initial 
    begin
        #0
        d = 0;
        clk = 0;
    end
endmodule
