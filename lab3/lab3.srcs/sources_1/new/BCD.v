`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 05:00:57 PM
// Design Name: 
// Module Name: BCD
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


module BCD(
    output reg [3:0] out = 0,
    output c_out,
    output b_out,
    input up,
    input down,
    input set0,
    input set9,
    input clk
    );
    
assign b_out = out == 0 ? 1:0;
assign c_out = out == 9 ? 1:0;
    
always @ (posedge clk) 
begin
    if(set0 == 1) out <= 0;
    else if(set9 == 1) out <= 9;
    else if(up == 1) begin
        if(out == 9) begin
            out <= 0;
        end else begin
            out <= out + 1;          
        end
    end else if(down == 1) begin
        if(out == 0) begin
            out <= 9;
        end else begin
            out <= out - 1;         
        end
    end else out <= out;
end
    
endmodule
