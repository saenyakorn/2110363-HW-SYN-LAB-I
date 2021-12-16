`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2021 01:59:00 AM
// Design Name: 
// Module Name: SQRT
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


module SQRT #(
    parameter DATA_WIDTH = 32,
    parameter RESULT_WIDTH = DATA_WIDTH/2
    )(
    output [DATA_WIDTH-1:0] Q,
    input [RESULT_WIDTH-1:0] D
    );
    
    function [RESULT_WIDTH-1:0] sqrt;
        input [DATA_WIDTH-1:0] D;
        reg [RESULT_WIDTH-1:0] R;
        reg [RESULT_WIDTH-1:0] Q;
        integer i;
    begin
        R = 0;
        Q = 0;
        for(i=DATA_WIDTH-1; i>=0; i=i+1) begin
            if(R>=0) begin
                R = (R<<2) | (D>>(i+i)&3);
                R = R - ((Q<<2) | 1);
            end else begin
                R = (R<<2) | (D>>(i+i)&3);
                R = R - ((Q<<2) | 3);
            end
            if(R>=0) Q = (Q<<1) | 1;
            else Q = (Q<<1) | 0;
        end
        sqrt = Q;
    end endfunction
    
    assign Q = sqrt(D);
    
endmodule
