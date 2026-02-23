`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 22:52:47
// Design Name: 
// Module Name: InstructionMemry_withWrite
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


module InstructionMemry_withWrite #(parameter INSTR_SIZE=145722)(
input instrWrEn,
input [31:0]pc_in,
input [7:0]InstrByte,

input clk,
input start,
 input[31:0] pc,            //byte address
 output[31:0] instruction
);
parameter col=32;
parameter row_i=INSTR_SIZE;


 reg [col - 1:0] memory [row_i - 1:0];
 (* ram_style = "block" *)
 wire [29:0]rom_addr = pc[31: 2];
 initial
 begin
//  $readmemb("instructions.mem", memory,0,row_i-1);
$readmemh("rtl/mem_init/program.mem", memory,0,row_i-1);
 end
// assign instruction = start? memory[rom_addr[$clog2(row_i):0]]:32'd0;// we are giving 5 bit address since instr mem size is 32 only  
 assign instruction = start? memory[rom_addr]:32'd0;
 
 always@(posedge clk)begin
 if(instrWrEn==1'b1)begin
 case(pc_in[1:0])
 2'b00: memory[pc_in[31:2]][7:0]=InstrByte;
 2'b01: memory[pc_in[31:2]][15:8]=InstrByte;
 2'b10: memory[pc_in[31:2]][23:16]=InstrByte;
 2'b11: memory[pc_in[31:2]][31:24]=InstrByte;
 endcase 
 end
 end
 
endmodule
