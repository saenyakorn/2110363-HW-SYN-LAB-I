`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 04:47:03 PM
// Design Name: 
// Module Name: System
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


module System(
    output wire [10:0] led,
    output wire [3:0] vgaRed, 
    output wire [3:0] vgaGreen, 
    output wire [3:0] vgaBlue,
    output wire Hsync, Vsync,
    output wire RsTx,
    input wire RsRx,
    input wire [11:0] sw,
    input btnC, btnU, btnL, clk
    );
    
wire btnUt, btnUd;
Debounce debounce_U(.q(btnUt), .d(btnU), .clk(clk));
SinglePulser singlePulser_U(.q(btnUd), .d(btnUt), .clk(clk));

wire btnCt, btnCd;
Debounce debounce_C(.q(btnCt), .d(btnC), .clk(clk));
SinglePulser singlePulser_C(.q(btnCd), .d(btnCt), .clk(clk));

wire btnLt, btnLd;
Debounce debounce_L(.q(btnLt), .d(btnL), .clk(clk));
SinglePulser singlePulser_L(.q(btnLd), .d(btnLt), .clk(clk));
   
VGATest vga(
    .clk(clk), 
    .sw(sw),
    .push({btnLd, btnUd}),
    .hsync(Hsync),
    .vsync(Vsync),
    .rgb({vgaRed, vgaGreen, vgaBlue})
);
    
uart uart(clk,RsRx,RsTx);

endmodule
