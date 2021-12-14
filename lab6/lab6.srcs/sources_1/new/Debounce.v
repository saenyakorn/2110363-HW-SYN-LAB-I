`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 04:21:24 PM
// Design Name: 
// Module Name: Debounce
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



module Debounce #(
    parameter POWER = 21
    )(
    output q,
    input d,
    input clk
    );

reg out = 0;
reg [POWER-1:0] active = 0;
reg [POWER-1:0] counter = 0;

always @ (posedge clk) begin
    if (counter == 0) begin
        out <= active >= (1 << (POWER/2)) ? 1 : 0;
        active <= 0;
        counter <= 1;
    end else begin
        active <= active + d;
        counter <= counter + 1;
    end
end

assign q = out;

// SinglePulser singlePulser(q, out, clk);
    
endmodule

module SinglePulser(
    output reg q = 0,
    input d,
    input clk
    );

reg prev = 0;
always @ (posedge clk) begin 
    prev <= d;
    q <= d && ~prev;
end

endmodule
