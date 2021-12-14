`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 04:45:02 PM
// Design Name: 
// Module Name: Ram
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



module Ram #(
    parameter RAM_WIDTH = 8,
    parameter RAM_ADDR_BITS = 8
    )(
    output reg [RAM_WIDTH-1:0] out,
    input [RAM_WIDTH-1:0] in,
    input [RAM_ADDR_BITS-1:0] addr,
    input we, re,
    input clk
    );

   (* ram_style="distributed" *)
   reg [RAM_WIDTH-1:0] mem [(2**RAM_ADDR_BITS)-1:0];
   
   integer i;
   initial
   for (i = 0; i < (2**RAM_ADDR_BITS); i = i + 1)
     mem[i] = {RAM_WIDTH{1'b0}};
   
   always @(posedge clk) begin 
      if (we) begin 
        mem[addr] = in;
        out = in;
      end
      if (re) out = mem[addr];
   end

endmodule

module Stack #(
    parameter RAM_WIDTH = 8,
    parameter RAM_ADDR_BITS = 8
    )(
    output [RAM_WIDTH-1:0] out,
    output [RAM_ADDR_BITS-1:0] num,
    input [RAM_WIDTH-1:0] in,
    input [1:0] mode,
    input clk
    );

// mode == 0 -> do nothing
// mode == 1 -> push 
// mode == 2 -> pop
// mode == 3 -> clear
wire re = mode == 2;
wire we = (mode == 1) || (mode == 3);

reg [RAM_ADDR_BITS-1:0] curAddr = 0;
//wire [RAM_ADDR_BITS-1:0] addr = mode == 2 ? curAddr: curAddr;

assign num = curAddr;

wire [RAM_WIDTH-1:0] data = mode != 3 ? in : 0;

Ram #(.RAM_WIDTH(RAM_WIDTH), .RAM_ADDR_BITS(RAM_ADDR_BITS)) 
    ram(.out(out), .in(data), .addr(curAddr), .we(we), .re(re), .clk(clk));

always @ (negedge clk) begin
    if(mode == 1) 
        curAddr <= curAddr < (1<<RAM_ADDR_BITS)-1 ? curAddr + 1 : curAddr;
    if(mode == 2) 
        curAddr <= 0 < curAddr ? curAddr - 1: curAddr;
    if(mode == 3)  
        curAddr <= 0;
end

endmodule