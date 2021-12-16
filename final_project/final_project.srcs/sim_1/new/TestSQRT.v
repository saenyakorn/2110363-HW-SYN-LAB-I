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

reg [32:0] out = 0;
reg [32:0] in = 0;
SQRT sqrt(.Q(out), .D(in));

initial begin
    #0
    in = 0;
    #5
    in = 144;
    #5
    in = 64;
    $finish;
end

endmodule
