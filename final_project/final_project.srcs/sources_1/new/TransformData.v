`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2021 05:33:41 PM
// Design Name: 
// Module Name: TransformData
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


module TransformData #(
    parameter NUMBER_BITS = 72,
    parameter QUEUE_SIZE = 4,
    parameter WORD_SIZE = 8
    )(
    output reg [WORD_SIZE-1:0] dataTransmit, 
    output reg enable = 0, 
    output [15:0] led,
    input [7:0] insertData, 
    input received, 
    input sent, 
    input clk
    );
    
    reg [3:0] mode = 0;
    
    function [NUMBER_BITS-1:0] operate;
        input [NUMBER_BITS-1:0] numA;
        input [NUMBER_BITS-1:0] numB;
        input [3:0] mode;
        case(mode)
            0: operate = numB;
            1: operate = numA + numB;
            2: operate = numA - numB;
            3: operate = (numA * numB) / 10**6;
            4: operate = (numA*(10**6)) / numB;
            5: operate = numB; // SQRT
            6: operate = 0;
        endcase
    endfunction
    
    function [3:0] toMode;
        input [WORD_SIZE-1:0] word;
        case(word)
            "+": toMode = 1;
            "-": toMode = 2;
            "*": toMode = 3;
            "/": toMode = 4;
            "s": toMode = 5;
            "c": toMode = 6;
            default: toMode = 7;
        endcase 
    endfunction
    
    wire [WORD_SIZE-1:0] topData;        
    wire [WORD_SIZE-1:0] lastPos;
    wire queueEmpty;
    
    reg [WORD_SIZE-1:0] inputKey = 0;
    reg [WORD_SIZE-1:0] dataIn;
    reg push = 0;
    reg pop = 0;
    
    Queue #(
        .QUEUE_SIZE(QUEUE_SIZE),
        .DATA_SIZE(WORD_SIZE)
        ) queue (
        .out(topData), 
        .lastPos(lastPos),
        .empty(queueEmpty),
        .in(dataIn), 
        .push(push),
        .pop(pop),
        .clk(clk)
        );
    
    always @(posedge clk) begin
        // SET ENABLE TO 0 IF TRANSMITTING
        if(~sent && enable) begin
            enable <= 0;
        end else if(sent && ~enable) begin
            // TRANSMIT DATA
            if(pop) begin
                dataTransmit <= topData;
                enable <= 1;
                pop <= 0;
            // POP DATA IF ABLE TO TRANSMIT
            end else if(~pop && ~queueEmpty) begin
                pop <= 1;
            end
        end
    end
    
    reg [5:0] i = 0;
    reg [5:0] j = 0;
    reg lastReceived;
    reg [3:0] point = 0;
    reg startNewLine = 0;  
    reg [NUMBER_BITS-1:0] storedNumber = 0;    
    reg [NUMBER_BITS-1:0] currentNumber = 0;    
    
    genvar c;
    wire [WORD_SIZE-1:0] digits[0:11];
    wire [NUMBER_BITS-1:0] tempNumber[0:12];
    wire isPositive = storedNumber[NUMBER_BITS-1] == 0 ? 1 : 0;
    assign tempNumber[12] = isPositive ? storedNumber : -storedNumber;
    generate for(c=11; c>=0; c=c-1) begin
        assign digits[c] = (
            tempNumber[c+1] >= 9 * (10**c) ? 57 :
            tempNumber[c+1] >= 8 * (10**c) ? 56 :
            tempNumber[c+1] >= 7 * (10**c) ? 55 :
            tempNumber[c+1] >= 6 * (10**c) ? 54 :
            tempNumber[c+1] >= 5 * (10**c) ? 53 :
            tempNumber[c+1] >= 4 * (10**c) ? 52 :
            tempNumber[c+1] >= 3 * (10**c) ? 51 :
            tempNumber[c+1] >= 2 * (10**c) ? 50 :
            tempNumber[c+1] >= 1 * (10**c) ? 49 : 48);
        assign tempNumber[c] = tempNumber[c+1] - (digits[c]-48)*(10**c);
    end endgenerate
    
    genvar d;
    wire [NUMBER_BITS-1:0] numbers[0:12];
    generate for(d=0; d<=7; d=d+1) begin
        if(d==0) 
            assign numbers[d] = currentNumber * (10**6);
        else 
            assign numbers[d] = currentNumber * (10**(7-d));
    end endgenerate
    
    always @(posedge clk) begin
        // DATA MANIPULATION AFTER RECEIVED DATA
        if(~lastReceived && received) begin
            // ENTER 
            if(insertData == 13) begin 
                inputKey <= insertData; 
                storedNumber = operate(storedNumber, numbers[point], mode);
                // RESET DATA
                startNewLine <= 1;
                currentNumber <= 0;
                point <= 0;
                mode <= 0;
                
            // NUMBER 0-9
            end else if(point < 7 && ((48 <= insertData && insertData <= 57) || (~point && insertData == "."))) begin
                inputKey <= insertData;
                if(insertData == ".") begin 
                    point <= 1;
                end else begin
                    if(point) point <= point + 1;
                    currentNumber <= currentNumber * 10 + (insertData-48);
                end
                startNewLine <= 0;
            // OPERATOR
            end else if(startNewLine && toMode(insertData) != 7) begin
                inputKey <= insertData;
                mode <= toMode(insertData);
                startNewLine <= 0;
                
            // OTHER CASE
            end else begin
                inputKey <= 0;
            end
        end
         
        lastReceived <= received;
        
        // APPEND DATA TO QUEUE (ENTER CASE)
        if(inputKey == 13) begin
            push <= 1;
            if(i == 0) begin
                dataIn <= 10; // NEWLINE
                i <= i+1;
            end else if(i == 1) begin
                dataIn <= 13; // RETURN CARRIAGE
                i <= i+1;
            end else if(i == 2) begin
                dataIn <= isPositive ? "+" : "-";
                i <= i+1;
            end else if((3 <= i && i <= 15) && i!=9) begin
                dataIn <= digits[i>=9 ? 15-i : 14-i];
                i <= i+1;
            end else if(i == 9) begin
                dataIn <= ".";
                i <= i+1;
            end else if(i == 16) begin
                dataIn <= ">";
                i <= i+1;
            end else if(i == 17) begin
                dataIn <= " ";
                i <= i+1;
            end else begin
                push <= 0;
                inputKey <= 0;
                i <= 0;
            end
        // APPEND DATA TO QUEUE (NUMBER CASE)
        end else if((48 <= inputKey && inputKey <= 57) 
                    || toMode(inputKey) != 7 
                    || inputKey == ".") begin
            if(j == 0) begin
                dataIn <= inputKey;
                push <= 1;
                j = j + 1;
            end else begin
                inputKey <= 0;
                push <= 0;
                j <= 0;
            end
        end
    end 
endmodule
