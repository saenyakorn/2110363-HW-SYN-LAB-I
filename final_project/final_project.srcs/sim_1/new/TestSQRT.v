`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2021 02:16:25 AM
// Design Name: 
// Module Name: TestSQRT
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


module TestSQRT();

wire [31:0] out;
reg [63:0] in = 0;
SQRT #(.DATA_WIDTH(64)) sqrt(.Q(out), .D(in));

initial begin
    #0
    in = 16;
    #10
    in = 25;
    #10
    in = 81;
    #10
    in = 100;
    #10 
    in = 144;
    #10
    in = 14400;
    $finish;
end

endmodule
