`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2024 18:35:10
// Design Name: 
// Module Name: tb_brchType
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


module tb_brchType();

// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns

// Signals
reg [6:0] opcode;
reg [2:0] funct3;
wire [3:0] branch_Operation;
wire branch_lsr;
wire branch_grtr;
wire branch_eql;

// Instantiate the module
branchType uut (
    .opcode(opcode),
    .funct3(funct3),
    .branch_Operation(branch_Operation),
    .branch_lsr(branch_lsr),
    .branch_grtr(branch_grtr),
    .branch_eql(branch_eql)
);

// Clock generation
reg clk = 0;
always #((CLK_PERIOD / 2)) clk = !clk;

// Test stimulus
initial begin
    opcode = 7'b1100001;
    funct3 = 3'b111;
    // Test case 1: BLT
    #10
    opcode = 7'b1100011;
    funct3 = 3'b100;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 1: BLT");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Test case 2: BLTU
    opcode = 7'b1100011;
    funct3 = 3'b110;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 2: BLTU");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Test case 3: BEQ
    opcode = 7'b1100011;
    funct3 = 3'b000;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 3: BEQ");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Test case 4: BNQ
    opcode = 7'b1100011;
    funct3 = 3'b001;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 4: BNQ");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Test case 5: BGE
    opcode = 7'b1100011;
    funct3 = 3'b101;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 5: BGE");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Test case 6: BGEU
    opcode = 7'b1100011;
    funct3 = 3'b111;
    #20; // Wait for some time for outputs to stabilize
    // Verify outputs
    $display("Test Case 6: BGEU");
    $display("branch_Operation: %b, branch_lsr: %b, branch_grtr: %b, branch_eql: %b", 
                branch_Operation, branch_lsr, branch_grtr, branch_eql);

    // Add more test cases as needed...

    // End simulation
    $finish;
end

endmodule
