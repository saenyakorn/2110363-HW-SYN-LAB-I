`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 08:41:48 PM
// Design Name: 
// Module Name: ALU_BCD
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


module ALU_BCD #(
    parameter ROM_WIDTH = 16,
    parameter ROM_ADDRS = 10
    )(
    output [ROM_WIDTH-1:0] bcd,
    input [ROM_ADDRS-1:0] addr
    );

reg [ROM_WIDTH-1:0] rom[0:(2**ROM_ADDRS)-1];
// NOTE: To infer combinational logic instead of a ROM, use
// (* synthesis, logic_block *)
initial $readmemb("rom_alu.data", rom);
assign bcd = rom[addr];
//always @(posedge clk) $display("rom %b", d);
endmodule
