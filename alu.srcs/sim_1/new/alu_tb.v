`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 12:51:45 PM
// Design Name: 
// Module Name: alu_tb
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

/*
module instruction_fetch(
input clk, rst,
output instruction
    );
    parameter instruction_size = 12;
    parameter program_mem_depth = 1024; //Define the size of the instruction memory
    
    reg[$clog2(program_mem_depth)-1:0] pc; //Define the address space for the instruction memory 
    
    always@(posedge clk) begin //increment the program counter
    if (rst) pc <= 1'b0;
    else pc <= pc + 1'b1;
    end
    
    reg [instruction_size-1:0] pm [program_mem_depth-1:0]; //define the program memory register
    initial $readmemh("test.hex");//read the instructions from the input file
    assign instruction = pm[pc];//get instruction from the file
endmodule
*/
module alu_tb();
reg clk;
reg[instruction_size-1:0] instruction;
wire[data_size-1:0] result;
parameter instruction_size=12;
parameter data_size = 12;
alu A1(clk,instruction,result);

always #50 clk=~clk;
 initial begin
 //rst = 1'b0;
 clk = 1'b0;
 instruction = 12'h100;
 #100
 instruction = 12'h154;
 #100
 instruction = 12'h1A8;
 #100
instruction = 12'h1FC;
 #100
 instruction = 12'hB01;
 #100
instruction = 12'hA48;
 #100
instruction = 12'h784;
 #100
 instruction = 12'hC20;
 end

endmodule
