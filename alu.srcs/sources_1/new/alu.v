`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2021 07:45:00 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input clk,
    input[instruction_size-1:0] instruction,
    output[data_size-1:0] result
    );
    parameter instruction_size = 12;
    parameter data_size = 12;
    reg carry;
    reg [data_size-1:0] R0, R1, R2, R3, A, B, temp_res;
   
    initial R0 = 12'b000000000000;
    initial R1 = 12'b000000000000;
    initial R2 = 12'b000000000000;
    initial R3 = 12'b000000000000;
    initial A = 12'b000000000000;
    initial B = 12'b000000000000;
    initial temp_res = 12'b000000000000;
    assign result = temp_res;
    always@(posedge clk) begin
    
/*Assign register based on the source and destination adddresses*/
    //Assign A - cannot use "assign" to copy one reg to another
if(instruction[5:4] == 2'b00) begin
     A = R0;
    end
    else if (instruction[5:4] == 2'b01) begin
     A = R1;
    end
    else if (instruction[5:4] == 2'b10) begin
     A = R2;
    end
    else if (instruction[5:4] == 2'b11) begin
     A = R3;
    end
    
    //Assign B
if(instruction[3:2] == 2'b00) begin
     B = R0;
    end
    else if (instruction[3:2] == 2'b01) begin
     B = R1;
    end
    else if (instruction[3:2] == 2'b10) begin
     B = R2;
    end
    else if (instruction[3:2] == 2'b11) begin
     B = R3;
    end 
       

$display("Before case");
case(instruction[11:8])

            4'b0000:
                temp_res = A | B;
            4'b0001:
                temp_res = A ^ B;
            4'b0010:
                temp_res = A & B;
            4'b0011:
                temp_res = ~A;
            4'b0100:
                temp_res = A << 1;
            4'b0101:
                temp_res = A >> 1;
            4'b0110:
                temp_res = A >>> 1;
            4'b0111:
                {carry,temp_res} = A + B;
            4'b1000:
                {carry,temp_res} = A + B + carry;
            4'b1001:
                temp_res = A - B;
            4'b1010:
                {temp_res[11:6],temp_res[5:0]} = {6'b000000,instruction[5:0]};
            4'b1011:
                {temp_res[11:6],temp_res[5:0]} = {instruction[5:0],6'b000000};
            4'b1100:
                temp_res = A;
          /*4'b1101:
                temp_res = A & B;*/
        endcase 

    //Assign to destination address
    if((instruction[7:6] == 2'b00) && (instruction[11:8] != 4'b1100)) begin
     R0 = temp_res;
    end
    else if ((instruction[7:6] == 2'b01) && (instruction[11:8] != 4'b1100)) begin
     R1 = temp_res;
    end
    else if ((instruction[7:6] == 2'b10) && (instruction[11:8] != 4'b1100)) begin
     R2 = temp_res;
    end
    else if ((instruction[7:6] == 2'b11) && (instruction[11:8] != 4'b1100)) begin
    R3 = temp_res;
    end 
    end
endmodule