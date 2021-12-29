`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 03:23:07 PM
// Design Name: 
// Module Name: Display
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


module Display(
    output reg [3:0] an,
    output [6:0] seg,
    output dp,
    input [15:0] hex,
    input [3:0] dpos,
    input clk
    );

reg [3:0] curHex = 0;
reg [1:0] counter = 0;
assign dp = dpos[counter];

HexToSevenSegment convertor(.seg(seg), .hex(curHex));

always @ (posedge clk) begin
    counter = counter + 1;
end
    
always @ (counter) begin
    case(counter)
        2'b00: begin
            an = 4'b0111;
            curHex = hex[15:12];
        end
        2'b01: begin
            an = 4'b1011;
            curHex = hex[11:8];
        end
        2'b10: begin
            an = 4'b1101;
            curHex = hex[7:4];
        end
        2'b11: begin
            an = 4'b1110;
            curHex = hex[3:0];
        end
    endcase
end
    
    
endmodule

module HexToSevenSegment(
    output reg [6:0] seg,
    input [3:0] hex
    );
// 7-segment encoding
//      0
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---
//      3

always @ (hex)
  case (hex)
      4'b0001 : seg = 7'b1111001;   // 1
      4'b0010 : seg = 7'b0100100;   // 2
      4'b0011 : seg = 7'b0110000;   // 3
      4'b0100 : seg = 7'b0011001;   // 4
      4'b0101 : seg = 7'b0010010;   // 5
      4'b0110 : seg = 7'b0000010;   // 6
      4'b0111 : seg = 7'b1111000;   // 7
      4'b1000 : seg = 7'b0000000;   // 8
      4'b1001 : seg = 7'b0010000;   // 9
      4'b1010 : seg = 7'b0001000;   // A
      4'b1011 : seg = 7'b0000011;   // b
      4'b1100 : seg = 7'b1000110;   // C
      4'b1101 : seg = 7'b0100001;   // d
      4'b1110 : seg = 7'b0000110;   // E
      4'b1111 : seg = 7'b0001110;   // F
      default : seg = 7'b1000000;   // 0
  endcase
  
endmodule
