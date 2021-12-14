`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : memory.v
// Title        : Memory
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.
module memory(data,address,wr,clock,mapped_in,mapped_out);
parameter DATA_WIDTH=32;
parameter ADDR_WIDTH=8;

inout	[DATA_WIDTH-1:0]	data;
input	[ADDR_WIDTH-1:0]	address;
input		                wr;
input		                clock;
input   [11:0]              mapped_in;
output  reg [15:0]          mapped_out;

reg	[DATA_WIDTH-1:0]	mem[0:1<<ADDR_WIDTH -1];

reg	[DATA_WIDTH-1:0]	data_out;
// Tri-State buffer
assign data=(wr==0) ? data_out:32'bz;

integer i;
initial
begin
	$readmemb("data.list",mem);
end

always @(address)
begin
	$display("%10d - mem[%h] -  %h\n",$time, address,data_out);	
	data_out = mem[address];
end

always @(posedge clock)
begin : MEM_WRITE
	if (wr) begin
		mem[address]=data;
		$display("%10d - MEM[%h] <- %h",$time, address, data);
	end
	mem[6] = mapped_in[11:8]; // ALU
    mem[5] = mapped_in[7:4]; // B
    mem[4] = mapped_in[3:0]; // A
    mapped_out[15:12] = mem[11]; // digit 3
    mapped_out[11:8] = mem[10];  // digit 2
    mapped_out[7:4] = mem[9];   // digit 1
    mapped_out[3:0] = mem[8];  // digit 0
end

endmodule