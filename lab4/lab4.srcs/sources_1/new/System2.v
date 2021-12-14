`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 04:37:25 PM
// Design Name: 
// Module Name: System2
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


module System2(
    output [3:0] an,
    output [6:0] seg,
    input [7:0] sw,
    input btnU, btnR, btnD, btnL, btnC,
    input clk
    );
    
genvar i;
wire [4:0] swd;
generate for(i=0; i<5; i = i+1) begin
    Debounce debounce(.q(swd[i]), .d(sw[i]), .clk(clk));
end endgenerate

wire btnUd, btnCd, btnDd;
wire btnUt, btnCt, btnDt;

Debounce debounce_U(.q(btnUt), .d(btnU), .clk(clk));
SinglePulser singlePulser_U(.q(btnUd), .d(btnUt), .clk(clk));

Debounce debounce_C(.q(btnCt), .d(btnC), .clk(clk));
SinglePulser singlePulser_C(.q(btnCd), .d(btnCt), .clk(clk));

Debounce debounce_D(.q(btnDt), .d(btnD), .clk(clk));
SinglePulser singlePulser_D(.q(btnDd), .d(btnDt), .clk(clk));

reg [1:0] mode = 0;
wire [4:0] count;
wire [4:0] out;
Stack #(.RAM_WIDTH(5), .RAM_ADDR_BITS(5)) 
    stack (.out(out), .num(count), .in(swd), .mode(mode), .clk(clk));

always @ (posedge clk) begin
    if(btnUd) mode <= 1;
    else if(btnCd) mode <= 2;
    else if (btnDd) mode <= 3;
    else mode <= 0;
end

wire [15:0] binary;
Binary2BCD b2bcd_L(.bcd(binary[15:8]), .addr(out), .clk(clk));
Binary2BCD b2bcd_R(.bcd(binary[7:0]), .addr(count), .clk(clk));

Segments segments(.seg(seg), .an(an), .hex(binary), .clk(clk));
    
endmodule
