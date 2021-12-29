`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 03:18:43 PM
// Design Name: 
// Module Name: System
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


module System(
    output [3:0] an,
    output [6:0] seg,
    output dp,
    input clk
    );
wire [3:0] birthDay_0 = 2;
wire [3:0] birthDay_1 = 2;
wire [3:0] birthMonth_0 = 1;
wire [3:0] birthMonth_1 = 1;
wire [3:0] birthYear_0 = 2;
wire [3:0] birthYear_1 = 0;
wire [3:0] birthYear_2 = 0;
wire [3:0] birthYear_3 = 0;

wire [15:0] birthdate_0 = { birthMonth_0, birthMonth_1, birthDay_0, birthDay_1 };
wire [15:0] birthdate_1 = { birthYear_0, birthYear_1, birthYear_2, birthYear_3 };
    
wire [3:0] dpos_0 = 4'b0101;
wire [3:0] dpos_1 = 4'b0111;

reg [3:0] dpos;
reg [15:0] birthdate;

reg sec_clock = 0;
reg [26:0] counter = 0;
always @ (posedge clk) begin
    if(counter == 10**8) begin 
        counter = 0;
        sec_clock = ~sec_clock;
    end
    else counter = counter + 1;
end

always @ (sec_clock) begin
    case(sec_clock)
        0: begin birthdate = birthdate_0;dpos = dpos_0; end
        1: begin birthdate = birthdate_1;dpos = dpos_1; end
    endcase
end

wire dClk;
ClockDiv #(.POWER(17)) clockDiv (.dClk(dClk), .clk(clk));
Display display(.an(an), .seg(seg), .dp(dp), .hex(birthdate), .dpos(dpos), .clk(dClk));

endmodule
