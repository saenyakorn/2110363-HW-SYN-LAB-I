`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 08:37:29 PM
// Design Name: 
// Module Name: testDebounce
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


module testDebounce();

reg clk, push;
wire out;

always #2 clk = ~clk;
always #2 push = 1;

debounce db(.out (out), .clk (clk), .push (push));

initial begin
    $monitor();
    #0
    clk = 0;
    push = 0;
    #400
    $finish;
end



endmodule
