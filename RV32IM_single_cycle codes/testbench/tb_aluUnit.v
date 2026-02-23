`timescale 1ns / 1ps

module tb_aluUnit;

  // Declare signals for the testbench
  reg [3:0] sel_in;
  reg  [31:0] in_1, in_2;
   wire  signed[31:0] op_1, op_2;
//  reg clk, rst;
  wire [31:0] result_out;
  wire gtr, lsr, eql;
  reg [31:0]expected_result;

  // Instantiate the aluUnit module
  aluUnit dut (
    .sel_in(sel_in),
    .in_1(in_1),
    .in_2(in_2),
    .result_out(result_out),
    .gtr(gtr),
    .lsr(lsr),
    .eql(eql)
  );


  assign op_1=$signed(in_1);
 assign  op_2=$signed(in_2);
  // Clock generation
  initial begin

  //  clk = 0;
 //   rst = 1; // Reset is active low
 //   forever #10 clk = ~clk;
  end

  // Self-testable initial block
  initial begin



    // Test case 5: AND operation
    sel_in = 4'b0111;
    in_1 = 8;
    in_2 = 6;
    expected_result=(in_1 & in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: AND operation failed. Expected: %h, Got: %h", (in_1 & in_2), result_out);
    else
      $display("Success: AND operation passed. Expected: %h, Got: %h", (in_1 & in_2), result_out);

    // Test case 6: OR operation
    sel_in = 4'b0110;
    in_1 = 8;
    in_2 = 6;
    expected_result=(in_1 | in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: OR operation failed. Expected: %h, Got: %h", (in_1 | in_2), result_out);
    else
      $display("Success: OR operation passed. Expected: %h, Got: %h", (in_1 | in_2), result_out);

    // Test case 7: XOR operation
    sel_in = 4'b0100;
    in_1 = 8;
    in_2 = 6;
    expected_result=(in_1 ^ in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: XOR operation failed. Expected: %h, Got: %h", (in_1 ^ in_2), result_out);
    else
      $display("Success: XOR operation passed. Expected: %h, Got: %h", (in_1 ^ in_2), result_out);

    // Test case 8: SLL operation
    sel_in = 4'b0001;
    in_1 = 4;
    in_2 = 2;
    expected_result=(in_1 << in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: SLL operation failed. Expected: %h, Got: %h", (in_1 << in_2), result_out);
    else
      $display("Success: SLL operation passed. Expected: %h, Got: %h", (in_1 << in_2), result_out);

    // Test case 9: SRL operation
    sel_in = 4'b0101;
    in_1 = 16;
    in_2 = 2;
    expected_result= (in_1 >> in_2);
    #20;
    if (result_out !==expected_result)
      $display("Error: SRL operation failed. Expected: %h, Got: %h", (in_1 >> in_2), result_out);
    else
      $display("Success: SRL operation passed. Expected: %h, Got: %h", (in_1 >> in_2), result_out);

    // Test case 10: SRA operation
    sel_in = 4'b1101;
    in_1 = -8;
    in_2 = 2;
    expected_result=(in_1 >>> in_2);
    #20;
    if (result_out !== expected_result)
      $display("Error: SRA operation failed. Expected: %h, Got: %h", (in_1 >>> in_2), result_out);
    else
      $display("Success: SRA operation passed. Expected: %h, Got: %h", (in_1 >>> in_2), result_out);
    // Test case 1: ADD operation
    sel_in = 4'b0000;
    in_1 = -10;
    in_2 = 20;
     expected_result=(in_1 + in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: ADD operation failed. Expected: %d, Got: %d", (in_1 + in_2), result_out);
    else
      $display("Success: ADD operation passed. Expected: %d, Got: %d", (in_1 + in_2), result_out);

    #20
    // Test case 2: SUB operation
    sel_in = 4'b1000;
    in_1 = 30;
    in_2 = -15;
     expected_result=(in_1 - in_2);
    #20;
    if (result_out !==expected_result )
      $display("Error: SUB operation failed. Expected: %d, Got: %d", (in_1 - in_2), result_out);
    else
      $display("Success: SUB operation passed. Expected: %d, Got: %d", (in_1 - in_2), result_out);
    #20    

   #20 
    // Test case 4: SLTU operation
    sel_in = 4'b0011;
    in_1 = 15;
    in_2 = 10;
    expected_result=$unsigned(in_1 < in_2);
    #40;
       
    if (result_out !== expected_result)
      $display("Error: SLTU operation failed. Expected: %h, Got: %h", (in_1 < in_2), result_out);
    else
      $display("Success: SLTU operation passed. Expected: %h, Got: %h", (in_1 < in_2), result_out);


    #20
    // Test case 3: SLT operation
    sel_in = 4'b0010;
    in_1 = 5;
    in_2 = -10;
    expected_result=(in_1 <in_2);
    #20;
    if (result_out !== expected_result)
      $display("Error: SLT operation failed. Expected: %h, Got: %h", (in_1 < in_2), result_out);
    else
      $display("Success: SLT operation passed. Expected: %h, Got: %h", (in_1 < in_2), result_out);
   

    // Display verification message
    $display("All tests passed successfully!");

    // Finish the simulation
    $stop;
  end

endmodule
