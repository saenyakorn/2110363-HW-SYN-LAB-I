`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 11:26:04 PM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv(
    output reg mClk,
    input clk
    );
   
reg [17:0] cnt;   

initial
begin
    mClk = 0;
end

always @ (posedge clk)
begin
    cnt = cnt + 1;
    if(cnt == 0) 
    begin
        mClk = ~mClk;
    end
end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 11:26:04 PM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv28(
    output reg mClk,
    input clk
    );
   
reg [28:0] cnt;   

initial
begin
    mClk = 0;
end

always @ (posedge clk)
begin
    cnt = cnt + 1;
    if(cnt == 0) 
    begin
        mClk = ~mClk;
    end
end
    
endmodule
