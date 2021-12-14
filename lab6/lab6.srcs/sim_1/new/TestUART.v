`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 09:10:28 PM
// Design Name: 
// Module Name: TestUART
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


module TestUART();

wire RsTx;
reg RsRx = 1;
wire [10:0] led;
reg clk = 0;

UART uart(
    .RsTx(RsTx),
    .RsRx(RsRx),
    .led(led),
    .clk(clk)
    );
    
always #5 clk = ~clk;


initial begin
    #0
    clk = 0;
    RsRx = 1;
    #20 RsRx = 0;
    #30 RsRx = 1;
    #40 RsRx = 1;
    #50 RsRx = 0;
    #60 RsRx = 1;
    #70 RsRx = 0;
    #80 RsRx = 1;
    #90 RsRx = 1;
    #100 RsRx = 0;
    #110 RsRx = 1;
    #300 RsRx = 0;
    #310 RsRx = 1;
    $finish;
end
    
endmodule
