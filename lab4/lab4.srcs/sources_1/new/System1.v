`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 05:24:29 PM
// Design Name: 
// Module Name: System1
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


module System1(
    output [3:0] an,
    output [6:0] seg,
    input [7:0] sw,
    input btnU, btnR, btnD, btnL, btnC,
    input clk
    );

genvar i;
wire [7:0] swd;
generate for(i=0; i<8; i = i+1) begin
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
wire [7:0] count;
wire [7:0] out;
Stack stack(.out(out), .num(count), .in(swd), .mode(mode), .clk(clk));

always @ (posedge clk) begin
    if(btnUd) mode <= 1;
    else if(btnCd) mode <= 2;
    else if (btnDd) mode <= 3;
    else mode <= 0;
end

wire [15:0] binary;
assign binary[15:8] = out;
assign binary[7:0] = count;

Segments segments(.seg(seg), .an(an), .hex(binary), .clk(clk));
    
endmodule
