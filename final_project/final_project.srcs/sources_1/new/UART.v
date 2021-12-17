`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2021 02:35:49 PM
// Design Name: 
// Module Name: UART
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


module UART #(
    parameter QUEUE_SIZE = 5,
    parameter BAUD_RATE = 9600,
    parameter CLOCK_RATE = 100000000
    )(
    output RsTx,   
    output [15:0] led,
    input RsRx,
    input clk
    );
    
    wire baud;
    BaudrateGenerator # (
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_RATE(CLOCK_RATE)
        )baudrateGen(
        .baud(baud), 
        .clk(clk)
        );
        
    wire [7:0] dataOut;
    wire received;
    UART_RX receiver(
        .dataOut(dataOut), 
        .received(received), 
        .bitIn(RsRx), 
        .clk(baud)
        );
    
    wire sent;
    wire enable;
    wire [7:0] topData;
    
    TransformData # (
        .QUEUE_SIZE(QUEUE_SIZE)
        ) transformer (
        .dataTransmit(topData), 
        .enable(enable), 
        .led(led),
        .insertData(dataOut), 
        .received(received), 
        .sent(sent), 
        .clk(baud)
        );
        
    UART_TX transmitter(
        .bitOut(RsTx),
        .sent(sent),
        .dataTransmit(topData), 
        .enable(enable), 
        .clk(baud)
        );
    
endmodule

module BaudrateGenerator #(
    parameter BAUD_RATE=9600,
    parameter CLOCK_RATE=100000000
    )(
    output reg baud = 0,
    input clk
    );
    
    reg [9:0] counter = 0;
    integer maxCount = CLOCK_RATE / (BAUD_RATE * 32);
    
    always @(posedge clk) begin
        counter = counter + 1;
        if (counter == maxCount) begin 
            counter = 0; 
            baud = ~baud; 
        end 
        // Clock = 10ns
        // ClockFreq = 1/10ns = 100 MHz
        // Baudrate = 9600
        // counter = ClockFreq/Baudrate/32
    end
    
endmodule

module UART_RX(
    output reg received = 1,
    output reg [7:0] dataOut,
    input bitIn,
    input clk
    );
    
    reg lastBit;
    reg receiving = 0;
    reg [7:0] count;
    
    always@(posedge clk) begin
        if (~receiving & lastBit & ~bitIn) begin
            receiving <= 1;
            received <= 0;
            count <= 0;
        end

        lastBit <= bitIn;
        count <= (receiving) ? count+1 : 0;
        
        case (count)
            8'd24:  dataOut[0] <= bitIn;
            8'd40:  dataOut[1] <= bitIn;
            8'd56:  dataOut[2] <= bitIn;
            8'd72:  dataOut[3] <= bitIn;
            8'd88:  dataOut[4] <= bitIn;
            8'd104: dataOut[5] <= bitIn;
            8'd120: dataOut[6] <= bitIn;
            8'd136: dataOut[7] <= bitIn;
            8'd152: begin 
                received <= 1; 
                receiving <= 0; 
            end
        endcase
    end
endmodule

module UART_TX(
    output reg bitOut,
    output reg sent = 1,
    input [7:0] dataTransmit,
    input enable,
    input clk
    );
    
    reg lastEnable;
    reg sending = 0;
    reg [7:0] count;
    reg [7:0] temp;
    
    always@(posedge clk) begin
        if (~sending & ~lastEnable & enable) begin
            temp <= dataTransmit;
            sending <= 1;
            sent <= 0;
            count <= 0;
        end
        
        lastEnable <= enable;
        
        if (sending)    
            count <= count + 1;
        else begin 
            count <= 0; 
            bitOut <= 1;
        end
        
        case (count)
            8'd8: bitOut <= 0;
            8'd24: bitOut <= temp[0];  
            8'd40: bitOut <= temp[1];
            8'd56: bitOut <= temp[2];
            8'd72: bitOut <= temp[3];
            8'd88: bitOut <= temp[4];
            8'd104: bitOut <= temp[5];
            8'd120: bitOut <= temp[6];
            8'd136: bitOut <= temp[7];
            8'd152: begin 
                sent <= 1; 
                sending <= 0; 
            end
        endcase
    end
endmodule

