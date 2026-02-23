`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 21:57:28
// Design Name: 
// Module Name: tb_ControlUnit
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

module tb_ControlUnit;

  // Declare signals for the testbench

  reg clk;
reg [31:0]instruction;
wire[6:0] opcode=instruction[6:0];
wire [2:0]funct3=instruction[14:12];
wire[6:0] funct7=instruction[31:25];

wire branch_lsr,branch_grtr,branch_eql;
  // Instantiate the ControlUnit module
  ControlUnit dut (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),

    .branch_lsr(branch_lsr),
    .branch_grtr(branch_grtr),
    .branch_eql(branch_eql)
 
  );

  // Clock generation
  initial begin
//branch eql 
#10
instruction=32'b00000000001000001000010101100011;
//branch neql 
#10
instruction=32'b00000000001000001001010101100011;

#10
instruction=32'hfcf74ee3;          	//blt	a4,a5,104

#10

    $stop;
  end

endmodule
