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
    output [RESULT_WIDTH-1:0] Q,
    input [DATA_WIDTH-1:0] D
    );
    
    wire [RESULT_WIDTH-1:0] r [0:RESULT_WIDTH];
    wire [RESULT_WIDTH-1:0] q [0:RESULT_WIDTH];
    
    genvar i;
    assign r[RESULT_WIDTH] = 0;
    assign q[RESULT_WIDTH] = 0;
    assign Q = q[0];
    generate for (i=RESULT_WIDTH-1; i>=0; i=i-1) begin
        assign r[i] = r[i+1][RESULT_WIDTH-1] == 0 ? 
            ((r[i+1] << 2) | ((D>>(i+i)) & 3)) - ((q[i+1] << 2) | 1) :
            ((r[i+1] << 2) | ((D>>(i+i)) & 3)) + ((q[i+1] << 2) | 3);
        assign q[i] = r[i][RESULT_WIDTH-1] == 0 ? 
            (q[i+1]<<1) | 1 :
            (q[i+1]<<1) | 0;
    end endgenerate
    
endmodule
