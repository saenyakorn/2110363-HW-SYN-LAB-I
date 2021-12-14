`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 11:09:14 AM
// Design Name: 
// Module Name: testShift
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


module testShift();
reg clock, da, db;
wire [1:0]qa; 
wire [1:0]qb;

always
    #10 clock=~clock;

shiftA a(qa, clock, da);
shiftB b(qb, clock, db);

initial 
begin
    $monitor("time %t\nA: {%b} <- {%d %d} \nB: {%b} <- {%d %d}", $time, qa, clock, da, qb, clock, db);
    #0 
    da = 0;
    db = 0;
    clock = 1;
    #300
    $finish;
end
always #7 da=~da;
always #7 db=~db;
    
endmodule
