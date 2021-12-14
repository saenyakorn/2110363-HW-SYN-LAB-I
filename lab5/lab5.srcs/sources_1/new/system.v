`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2021 09:19:34 PM
// Design Name: 
// Module Name: system
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


module system(
    output dp,
    output [3:0] an,
    output [6:0] seg,
    input [11:0] sw,
    input clk
    );
wire 	[31:0]	p_address;
wire 	[31:0]	p_data;
wire	[31:0]	d_address;
wire		mem_wr;
wire	[31:0]	d_data;
reg		nreset = 0;

reg [1:0] cnt = 0;
always @ (posedge clk) begin
    if(cnt==3) nreset = 1;
    cnt = cnt + 1;
end

genvar i;
wire [11:0] swd;
generate for(i=0; i<12; i = i+1) begin
    Debounce debounce(.q(swd[i]), .d(sw[i]), .clk(clk));
end endgenerate

wire [11:0] mapped_in = swd; 
wire [15:0] mapped_out;

wire dClk;
wire [3:0] dpos = 4'b0000;
ClockDiv #(.POWER(17)) clockDiv (.dClk(dClk), .clk(clk));
Display display(.an(an), .seg(seg), .dp(dp), .hex(mapped_out), .dpos(dpos), .clk(dClk));

nanocpu	CPU(p_address,p_data,d_address,d_data,mem_wr,clk,nreset);
rom 	PROGMEM(p_data, p_address[28:2]);
memory 	DATAMEM(d_data, d_address[28:2], mem_wr,clk, mapped_in, mapped_out);

endmodule
