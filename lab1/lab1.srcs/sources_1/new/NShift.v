`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2021 06:58:46 PM
// Design Name: 
// Module Name: NShift
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


module NShift #(parameter MSB=8)(
    input d,
    input clk,
    output reg [MSB-1:0] out
    );
    
    always @(posedge clk)   
        begin 
            out <= {d, out[MSB-1: 1]};
        end
endmodule
