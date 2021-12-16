`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2021 08:43:34 PM
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
reg clk = 0;

UART #(
    .BAUD_RATE(32),
    .CLOCK_RATE(2*32*32)
    ) uart(
    .RsTx(RsTx),
    .RsRx(RsRx),
    .clk(clk)
    );
    
always #5 clk = ~clk;

initial begin
    #0
    clk = 0;
    RsRx = 1;
    #100 RsRx = 0;
    // 13
    #640 RsRx = 1;
    #640 RsRx = 0;
    #640 RsRx = 1;
    #640 RsRx = 1;
    #640 RsRx = 0;
    #640 RsRx = 0;
    #640 RsRx = 0;
    #640 RsRx = 0;
    // BREAK
    #1280 RsRx = 1;
    // 50
    #640 RsRx = 0;
    #640 RsRx = 0;
    #640 RsRx = 1;
    #640 RsRx = 0;
    #640 RsRx = 0;
    #640 RsRx = 1;
    #640 RsRx = 1;
    #640 RsRx = 0;
    #640 RsRx = 0;
    // BREAK
    #640 RsRx = 1;
    $finish;
end
    
endmodule

