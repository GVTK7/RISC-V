`timescale 1ns / 1ps

module tb_pccntr;

  // Declare signals for the testbench
  reg clk, rst, take_branch, jal, jalr;
  reg [31:0] immediate, reg_read_data_1;
  wire [31:0] pc_current, pc4, PC_plusImm, PC_Rs1plsImm;

  // Instantiate the pcCntr module
  pcCntr dut (
    .clk(clk),
    .rst(rst),
    .take_branch(take_branch),
    .jal(jal),
    .jalr(jalr),
    .immediate(immediate),
    .reg_read_data_1(reg_read_data_1),
    .pc_current(pc_current),
    .pc4(pc4),
    .PC_plusImm(PC_plusImm),
    .PC_Rs1plsImm(PC_Rs1plsImm)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

reg [31:0]expected_out;
  // Assertions for self-testing
  initial begin
    // Assertion for reset scenario
    rst = 1;
    #10;
    expected_out=32'd0;
    if (pc_current !== expected_out) 
      $display("Test Case 1 failed: pc_current = %d,expected=%d", pc_current,expected_out);
    else
      $display("Test Case 1 passed:pc_current = %d,expected=%d", pc_current,expected_out);

    // Assertion for basic scenario without branching or jumping
    rst = 0; take_branch = 0; jal = 0; jalr = 0;
    immediate = 32'h100; reg_read_data_1 = 32'h200;
    #10;
    expected_out=32'd4;
    if (pc_current !== expected_out) 
      $display("Test Case 2 failed: pc_current = %d,expected=%d", pc_current,expected_out);
    else
      $display("Test Case 2 passed:pc_current = %d,expected=%d", pc_current,expected_out);

    // Assertion for take branch scenario
    rst = 0; take_branch = 1; jal = 0; jalr = 0;
    immediate = 32'd200; reg_read_data_1 = 32'd300;
    #10;
    expected_out=32'd204;
    if (pc_current !== expected_out) 
     
      $display("Test Case 3 failed:pc_current = %d,expected=%d", pc_current,expected_out);
       else
      $display("Test Case 3 passed:pc_current = %d,expected=%d", pc_current,expected_out);

    
    // Assertion for JAL scenario
    rst = 0; take_branch = 0; jal = 1; jalr = 0;
    immediate = 32'd100; reg_read_data_1 = 32'd400;
    #10;
    expected_out=32'd304;
    if (pc_current !== expected_out) 
      $display("Test Case 4 failed:pc_current = %d,expected=%d", pc_current,expected_out);
    else
      $display("Test Case 4 passed:pc_current = %d,expected=%d", pc_current,expected_out);

    // Assertion for JALR scenario
    rst = 0; take_branch = 0; jal = 0; jalr = 1;
    immediate = 32'd50; reg_read_data_1 = 32'd500;
    #10;
    expected_out=32'd550;
    if (pc_current !== expected_out)  
      $display("Test Case 5 failed:pc_current = %d,expected=%d", pc_current,expected_out);
    else
      $display("Test Case 5 passed:pc_current = %d,expected=%d", pc_current,expected_out);

    // Add more assertions for additional test cases

    // Finish the simulation
    $stop;
  end

endmodule
