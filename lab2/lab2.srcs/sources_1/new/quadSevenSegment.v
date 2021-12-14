`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 11:42:39 PM
// Design Name: 
// Module Name: quadSevenSegment
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


module quadSevenSegment(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    input [3:0] num0,
    input [3:0] num1,
    input [3:0] num2,
    input [3:0] num3,
    input clk
    );
assign dp = 0;    

reg [3:0] currHex;
reg [3:0] displayEnable;

wire [6:0] segments;

assign seg = segments;
assign an = displayEnable;

hexToSevenSegment decode(segments, currHex);

reg [1:0] index = 0;
always @ (posedge clk)
begin
    index = index + 1;
    case(index)
        2'b00: begin 
        currHex = num3;
        displayEnable = 4'b0111;
        end
        2'b01: begin
        currHex = num2;
        displayEnable = 4'b1011;
        end
        2'b10: begin
        currHex = num1;
        displayEnable = 4'b1101;
        end
        2'b11: begin
        currHex = num0;
        displayEnable = 4'b1110;
        end
    endcase
end
    
endmodule
