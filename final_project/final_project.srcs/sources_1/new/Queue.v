`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2021 02:25:43 PM
// Design Name: 
// Module Name: Queue
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


module Queue #(
    parameter QUEUE_SIZE = 4,
    parameter DATA_SIZE = 8
    )(
    output [DATA_SIZE-1:0] out,
    output reg [DATA_SIZE-1:0] lastPos,
    output empty,
    input [DATA_SIZE-1:0] in,
    input push,
    input pop,
    input clk
    );

reg [DATA_SIZE-1:0] currentPos = 0;

reg	[DATA_SIZE-1:0] mem [0:(1<<QUEUE_SIZE)-1];

assign out = pop ? mem[currentPos+1] : {(DATA_SIZE){1'bz}};

assign empty = currentPos == lastPos;

always @(posedge clk) begin
    if(pop) begin
        currentPos = currentPos + 1;
    end
end

always @(posedge clk) begin
    if(push) begin
        mem[lastPos+1] = in;
        lastPos = lastPos + 1;
    end
end

endmodule