`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 04:01:33 PM
// Design Name: 
// Module Name: segments
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


module Segments(
    output [6:0] seg,
    output reg [3:0] an,
    input [15:0] hex,
    input minus,
    input clk
    );
    
wire dClk;
ClockDiv clockDiv(dClk, clk);
    
reg [1:0] pos;
always @ (posedge dClk) pos <= pos + 1;

reg [3:0] curHex;
HexToSegment(.seg(seg), .hex(curHex), .minus((pos==0)&&minus)); 
    
always @ (pos) begin
    case(pos)
    2'b00: begin 
        an <= 4'b0111;
        curHex <= hex[15:12];
    end 2'b01: begin 
        an <= 4'b1011;
        curHex <= hex[11:8];
    end 2'b10: begin
        an <= 4'b1101;
        curHex <= hex[7:4]; 
    end 2'b11: begin 
        an <= 4'b1110;
        curHex <= hex[3:0];
    end endcase
end
    
endmodule

module HexToSegment(
    output reg [6:0] seg,
    input wire [3:0] hex,
    input minus
    );
    
// 7-segment encoding
//      0
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---
//      3

   always @(hex) begin
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
      if(minus) seg = 7'b0111111;
   end
					
endmodule
