`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2021 02:10:38 PM
// Design Name: 
// Module Name: Memory
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


module Memory #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8
    )(
    output reg [DATA_WIDTH-1:0] out,
    input [DATA_WIDTH-1:0] in,
    input [ADDR_WIDTH-1:0] addr,
    input writeEnable,
    input clk
    );

reg	[DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

always @(posedge clk) begin
    out = mem[addr];
end

always @(posedge clk) begin
    if(writeEnable) begin
        mem[addr] = in;
    end
end

endmodule
