`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 08:05:54 PM
// Design Name: 
// Module Name: TestRam
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


module TestRam();
reg clk;
reg we;
reg [7:0] addr;
reg [7:0] in;
wire [7:0] out;

always #5 clk = ~clk;

Ram ram(.out(out), .in(in), .addr(addr), .we(we), .clk(clk));

initial 
begin
    #0
    clk = 0;
    we = 1;
    addr = 0;
    in = 5;
    #5 
    we = 1;in = 10;addr = 1;
    #10
    we = 1;in = 20;addr = 2;
    #15
    we = 0;in = 0;addr = 1;
    #20
    we = 0;in = 0;addr = 2;
    #25
    we = 1;in = 15;addr = 1;
    #30
    we = 0;in = 0;addr = 1;
    #35
    $finish;
end


endmodule
