`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 21:56:04
// Design Name: 
// Module Name: tb_GPRs
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

module tb_GPRs;

  // Declare signals for the testbench
  reg clk, rst, we_i;
  reg [4:0] waddr_i, raddr1_i, raddr2_i;
  reg [31:0] wdata_i;
  wire [31:0] rdata1_o, rdata2_o;

  // Instantiate the GPRs module
  GPRs dut (
    .clk(clk),
    .rst(rst),
    .we_i(we_i),
    .waddr_i(waddr_i),
    .wdata_i(wdata_i),
    .raddr1_i(raddr1_i),
    .rdata1_o(rdata1_o),
    .raddr2_i(raddr2_i),
    .rdata2_o(rdata2_o)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initial block to apply stimulus
  initial begin
    // Initialize inputs
    rst = 1; // Reset is active low
    we_i = 0;
    waddr_i = 0;
    wdata_i = 0;
    raddr1_i = 0;
    raddr2_i = 0;

    // Test case 1: Write to register 1
    #10;
    we_i = 1;
    waddr_i = 1;
    wdata_i = 32'hABCDEF01;
    #10;
    we_i = 0;

    // Test case 2: Read from register 1
    rst = 0;
    raddr1_i = 1;
    #10;
    if (rdata1_o !== 32'hABCDEF01)
      $display("Error: Read from register 1. Expected: %h, Got: %h", 32'hABCDEF01, rdata1_o);

    // Test case 3: Write to register 2
    #10;
    we_i = 1;
    waddr_i = 2;
    wdata_i = 32'h12345678;
    #10;
    we_i = 0;

    // Test case 4: Read from register 2
    raddr2_i = 2;
    #10;
    if (rdata2_o !== 32'h12345678)
      $display("Error: Read from register 2. Expected: %h, Got: %h", 32'h12345678, rdata2_o);

    // Display verification message
    $display("Verification passed successfully!");

    // Finish the simulation
    $stop;
  end

endmodule
