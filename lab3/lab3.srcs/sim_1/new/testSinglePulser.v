`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 04:39:46 PM
// Design Name: 
// Module Name: testSinglePulser
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


module testSinglePulser();
    
reg in, clk;
wire out;

singlePulser s1(out, in, clk);

always #10 clk = ~clk;
    
initial 
begin

$monitor("time %t: {%b} <- {%b}", $time, out, in );
    #0
        in = 1;
        clk = 0;  
    #30
        in = 0;
    #40
        in = 1;
    #50
        in = 0;
    #60
$finish;
end

endmodule
