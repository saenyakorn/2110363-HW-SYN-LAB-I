`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 04:34:07 PM
// Design Name: 
// Module Name: singlePulser
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

// 0 is down, 1 is up
module singlePulser(
    output reg out = 0,
    input in,
    input clk
    );
    
reg hold = 0;   

always @ (posedge clk)
begin
    if(in == 1) begin
        if(hold == 0) begin
            out = 1;
            hold = 1;
        end else out = 0;
    end else begin 
        hold = 0;
        out = 0;
    end
end

endmodule
