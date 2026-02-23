`timescale 1ns/1ps

module tb_ImmGen;

  

 wire [2:0]ImmOp;
  wire [31:0] ImmExtD;

reg [31:0]expected_result;
reg [31:0]instruction;
wire[6:0] opcode=instruction[6:0];
wire [2:0]funct3=instruction[14:12];
wire[6:0] funct7=instruction[31:25];

  wire [24:0] Imm=instruction[31:7];

  // Instantiate the ImmGen module
  ImmGen dut (
    .Imm(Imm),
    .ImmSrcD(ImmOp),
    .ImmExtD(ImmExtD)
  );  
  // Instantiate the ControlUnit module
  ControlUnit dutcntrl (
    .opcode(opcode),
    .funct3(funct3),
    .functn7(funct7),
    .ImmOp(ImmOp)
  );

  // Test procedure
  initial begin
    // Initialize inputs
    //I ytpe
    //addi x30,x0,11
    instruction=32'b00000000101100000000111100010011;
    #10
    expected_result=32'd11;
    #10;
    if (ImmExtD == expected_result)
      $display("I type - Verified");
    else
      $display("I type - Error: Expected %h, Got %h", expected_result, ImmExtD);
    
    
        //S ytpe
    //sb x10,12(x1)
    instruction=32'b00000000101000001000011000100011;
    #10
    expected_result=32'd12;
    #10;
    if (ImmExtD == expected_result)
      $display("S type - Verified");
    else
      $display("S type - Error: Expected %h, Got %h", expected_result, ImmExtD);
    
    
        //B type
    //beq x1,x2,748
    instruction=32'b00101110001000001000011001100011;
    #10
    expected_result=32'd748;
    #10;
    if (ImmExtD == expected_result)
      $display("B type - Verified");
    else
      $display("B type - Error: Expected %h, Got %h", expected_result, ImmExtD);
    
        //L type
    //lui x10,-2
    instruction=32'b11111111111111111110010100110111;
    
    #10;
    expected_result=-32'd8192;
    if (ImmExtD == expected_result)
      $display("L type - Verified");
    else
      $display("L type - Error: Expected %h, Got %h", expected_result, ImmExtD);
    
    
        //J type
    //jal x10, 16
    instruction=32'b00000001000000000000010101101111;
    
    #10;
    expected_result=32'd16;
    if (ImmExtD == expected_result)
      $display("Jal type - Verified");
    else
      $display("Jal type - Error: Expected %h, Got %h", expected_result, ImmExtD);
  
    //jalr x10, -5(x2)
    instruction=32'b11111111101100010000010101100111;
    #10;
    expected_result=-32'd5;
    if (ImmExtD == expected_result)
      $display("Jalr type - Verified");
    else
      $display("Jalr type - Error: Expected %h, Got %h", expected_result, ImmExtD);
    
     
   
    #200 $finish;
  end

endmodule
