`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 04:52:27 PM
// Design Name: 
// Module Name: Bianary2BCD
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


module Binary2BCD #(
    parameter ROM_WIDTH = 8,
    parameter ROM_ADDRS = 5
    )(
    output [7:0] bcd,
    input [ROM_ADDRS-1:0] addr,
    input clk
    );
    
reg [ROM_WIDTH-1:0] rom[0:(2**ROM_ADDRS)-1];
// NOTE: To infer combinational logic instead of a ROM, use
// (* synthesis, logic_block *)
initial $readmemb("rom.data", rom);
assign bcd = rom[addr];
//always @(posedge clk) $display("rom %b", d);
    
endmodule
