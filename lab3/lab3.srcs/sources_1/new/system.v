`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 07:00:45 PM
// Design Name: 
// Module Name: system
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


module system(
    output [3:0] an,
    output [6:0] seg,
    output dp,
    input [7:0] sw,
    input btnU,
    input btnC,
    input clk
    );

wire [15:0] hex;
wire [3:0] b_out;
wire [3:0] c_out;
wire [3:0] up;
wire [3:0] down;
wire set0;
wire set9;
wire [7:0] swd;
wire [3:0] new_up;
wire [3:0] new_down;

debounce db_set0(.out (set0), .push (btnC), .clk (clk));
debounce db_set9(.out (set9), .push (btnU), .clk (clk));

assign no_down = b_out[3] && b_out[2] && b_out[1] && b_out[0];
assign no_up = c_out[3] && c_out[2] && c_out[1] && c_out[0];

assign new_up[0] = 0;
assign new_up[1] = (c_out[0] && swd[1]);
assign new_up[2] = (c_out[1] && swd[3]) || (c_out[1] && c_out[0] && swd[1]);
assign new_up[3] = (c_out[2] && swd[5]) || (c_out[2] && c_out[1] && swd[3]) || (c_out[2] && c_out[1] && c_out[0] && swd[1]);

assign new_down[0] = 0;
assign new_down[1] = (b_out[0] && swd[0]);
assign new_down[2] = (b_out[1] && swd[2]) || (b_out[1] && b_out[0] && swd[0]);
assign new_down[3] = (b_out[2] && swd[4]) || (b_out[2] && b_out[1] && swd[2]) || (b_out[2] && b_out[1] && b_out[0] && swd[0]);

wire to0, to9;
assign to0 = (swd[6] && b_out[3]) || 
(swd[4] && b_out[3] && b_out[2]) || 
(swd[2] && b_out[3] && b_out[2] && b_out[1]) || 
(swd[0] && b_out[3] && b_out[2] && b_out[1] && b_out[0]);

assign to9 = (swd[7] && c_out[3]) || 
(swd[5] && c_out[3] && c_out[2]) || 
(swd[3] && c_out[3] && c_out[2] && c_out[1]) || 
(swd[1] && c_out[3] && c_out[2] && c_out[1] && c_out[0]);

genvar i;
generate for(i=0; i<4; i = i+1) begin
    debounce db_up  (.out (swd[2*i+1])  , .push (sw[2*i+1])  , .clk (clk));
    debounce db_down(.out (swd[2*i]), .push (sw[2*i]), .clk (clk));
    BCD bcd(.out (hex[4*i+3:4*i]), 
            .b_out (b_out[i]),
            .c_out (c_out[i]),
            .up ((swd[2*i+1] || new_up[i]) && ~no_up),
            .down ((swd[2*i] || new_down[i]) && ~no_down),
            .set0 (set0 || to0),
            .set9 (set9 || to9),
            .clk (clk)
            );
end endgenerate

wire mClk;
clockDiv(mClk, clk);

quadSevenSegment(
    .seg (seg),
    .dp (dp),
    .an (an),
    .num0 (hex[3:0]),
    .num1 (hex[7:4]),
    .num2 (hex[11:8]),
    .num3 (hex[15:12]),
    .clk (mClk)
    );
    
endmodule
