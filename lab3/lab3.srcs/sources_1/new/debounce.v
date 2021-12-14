`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 04:32:26 PM
// Design Name: 
// Module Name: debounce
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


module debounce(
    output out,
    input push,
    input clk
    );

wire out1, out2;
DFF d1(.q (out1), .reset(0), .d (push), .clk (clk));
DFF d2(.q (out2), .reset(0), .d (out1), .clk (clk));

reg outd = 0;
reg [20:0] active = 0;
reg [20:0] counter = 0;
always @ (posedge clk) begin
    if (counter == 0) begin
        if(active >= 1 << 10) outd = 1;
        else outd = 0;
        active = 0;
        counter = 1;
    end else begin
        active = active + push;
        counter = counter + 1;
    end
end

singlePulser sp(.out (out), .in(outd), .clk (clk));

endmodule
