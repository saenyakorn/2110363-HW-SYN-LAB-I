`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 05:11:54 PM
// Design Name: 
// Module Name: testBCD
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


module testBCD();

reg up, down, set0, set9, clk;
wire [3:0] out; 
wire c_out, b_out;

BCD bcd(.out (out), 
        .c_out (c_out),
        .b_out(b_out),
        .up (up),
        .down (down),
        .set0 (set0),
        .set9 (set9),
        .clk (clk)
        );

always 
    #5 clk = ~clk;

initial
begin
$monitor("time %t: {%out}", $time, out);
    #0
    up = 0;
    down = 0;
    set0 = 0;
    set9 = 0;
    clk = 0;
    #5
    up = 1;
    #100
    up = 0;
    down = 1;
    #200
    set0 = 1;
    #220
    set0 = 0;
    set9 = 1;
    #240
$finish;
end

endmodule
