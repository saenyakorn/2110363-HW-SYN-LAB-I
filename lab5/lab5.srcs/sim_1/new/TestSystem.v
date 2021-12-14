`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2021 09:55:47 PM
// Design Name: 
// Module Name: TestSystem
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


module TestSystem();
reg		clock;

wire dp;
wire an;
wire [6:0] seg;
reg [11:0] sw = 12'h1CF;

system system(.dp(dp), .an(an), .seg(seg), .sw(sw), .clk(clock));

initial
begin
    #0
	clock=0;
	#5000;
	$finish;
end

always
begin : CLOCK
	#20
	clock=~clock;
end

endmodule
