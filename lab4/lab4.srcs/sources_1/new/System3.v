`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 08:09:24 PM
// Design Name: 
// Module Name: System3
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



module System3(
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

wire btnUd, btnCd, btnDd, btnLd, btnRd;
wire btnUt, btnCt, btnDt, btnLt, btnRt;

Debounce debounce_U(.q(btnUt), .d(btnU), .clk(clk));
SinglePulser singlePulser_U(.q(btnUd), .d(btnUt), .clk(clk));

Debounce debounce_C(.q(btnCt), .d(btnC), .clk(clk));
SinglePulser singlePulser_C(.q(btnCd), .d(btnCt), .clk(clk));

Debounce debounce_D(.q(btnDt), .d(btnD), .clk(clk));
SinglePulser singlePulser_D(.q(btnDd), .d(btnDt), .clk(clk));

Debounce debounce_L(.q(btnLt), .d(btnL), .clk(clk));
SinglePulser singlePulser_L(.q(btnLd), .d(btnLt), .clk(clk));

Debounce debounce_R(.q(btnRt), .d(btnR), .clk(clk));
SinglePulser singlePulser_R(.q(btnRd), .d(btnRt), .clk(clk));

reg [1:0] mode;
reg [9:0] addr;
always @ (posedge clk) begin
    if(btnUd) mode = 2'b00;
    else if(btnLd) mode = 2'b01;
    else if(btnDd) mode = 2'b10;
    else if(btnRd) mode = 2'b11;
    
    if(btnUd || btnLd || btnDd || btnRd) begin
        addr[9:8] = mode;
        addr[7:4] = swd[3:0];
        addr[3:0] = swd[7:4];
    end
end

wire [15:0] binary;
wire opr = binary[15:12];
ALU_BCD alu(.bcd(binary), .addr(addr));
Segments segments(.seg(seg), .an(an), .hex(binary), .minus(opr==1), .clk(clk));
    
endmodule
