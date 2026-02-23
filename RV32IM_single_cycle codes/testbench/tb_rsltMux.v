`timescale 1ns / 1ps

module tb_rsltMux();
  // Declare signals for the testbench
  reg [31:0] ALU_out, mem_read_data, pc4, PC_plusImm, immediate;
  reg ld, jal, jalr, auipc, lui;
  wire [31:0] reg_write_data;

  // Instantiate the rsltMux module
  rsltMux dut (
    .ALU_out(ALU_out),
    .mem_read_data(mem_read_data),
    .pc4(pc4),
    .PC_plusImm(PC_plusImm),
    .immediate(immediate),
    .ld(ld),
    .jal(jal),
    .jalr(jalr),
    .auipc(auipc),
    .lui(lui),
    .reg_write_data(reg_write_data)
  );

  // Initial values for inputs
  initial begin
    ALU_out = 32'h0;
    mem_read_data = 32'h0;
    pc4 = 32'h0;
    PC_plusImm = 32'h0;
    immediate = 32'h0;
    ld = 0;
    jal = 0;
    jalr = 0;
    auipc = 0;
    lui = 0;
  end

  // Apply stimulus
  initial begin
    // Test Case 1
    ld = 1;
    #10;
    if (reg_write_data !== ALU_out) $display("Test Case 1 failed: reg_write_data = %h", reg_write_data);
    else $display("Test Case 1 passed: reg_write_data = %h", reg_write_data);

    // Test Case 2
    ld = 0; jal = 1;
    #10;
    if (reg_write_data !== pc4) $display("Test Case 2 failed: reg_write_data = %h", reg_write_data);
    else $display("Test Case 2 passed: reg_write_data = %h", reg_write_data);

    // Test Case 3
    jal = 0; auipc = 1;
    #10;
    if (reg_write_data !== PC_plusImm) $display("Test Case 3 failed: reg_write_data = %h", reg_write_data);
    else $display("Test Case 3 passed: reg_write_data = %h", reg_write_data);

    // Test Case 4
    auipc = 0; lui = 1;
    #10;
    if (reg_write_data !== immediate) $display("Test Case 4 failed: reg_write_data = %h", reg_write_data);
    else $display("Test Case 4 passed: reg_write_data = %h", reg_write_data);

    // Add more test cases as needed

    // Finish the simulation
    $stop;
  end

endmodule
