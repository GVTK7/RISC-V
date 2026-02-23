`timescale 1ns/1ps

module tb_dataMemory;

  // Inputs
  reg clk = 0;
  reg b, hf, f, bU, hfU; // Control signals for byte, half-word, word, byteU, and half-wordU
  reg [31:0] mem_access_addr;
  reg [31:0] mem_write_data;
  reg mem_write_en;
  reg mem_read;
  reg [31:0] expected_result; // For verification

  // Outputs
  wire [31:0] mem_read_data;

  // Instantiate the dataMemory module
  dataMemory dut (
    .clk(clk),
    .b(b),
    .hf(hf),
    .f(f),
    .bU(bU),
    .hfU(hfU),
    .mem_access_addr(mem_access_addr),
    .mem_write_data(mem_write_data),
    .mem_write_en(mem_write_en),
    .mem_read(mem_read),
    .mem_read_data(mem_read_data)
  );

  // Clock generation
  always #5 clk = ~clk;
  // Test procedure
  initial begin
    // Initialize inputs
    b = 0;
    hf = 0;
    f = 0;
    bU = 0;
    hfU = 0;
    mem_access_addr = 0;
    mem_write_data = 0;
    mem_write_en = 0;
    mem_read = 0;
    expected_result = 0;


    // Test Scenario 1: Write and Read Byte
    #20
    //b = 1;
    mem_access_addr = 32'h0000_0000;
    mem_write_data = 32'hABCDEFAB;
    mem_write_en = 1;
    #10
    b=1;
    mem_read = 1;
    mem_write_en = 0;
    expected_result ={{25{mem_write_data[7]}},mem_write_data[6:0]}; 
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 1 - Verified");
    else
      $display("Test Scenario 1 - Error: Expected %h, Got %h", expected_result, mem_read_data);
 //----tst 12
 #10
    mem_access_addr = 32'h0000_0001;
    mem_read = 1;
    mem_write_en = 0;
    //mem_write_data = 32'hABCDEFAB;
    expected_result ={{25{mem_write_data[15]}},mem_write_data[14:8]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 12 - Verified");
    else
      $display("Test Scenario 12 - Error: Expected %h, Got %h", expected_result, mem_read_data);
 //------tst 13
 #10
    mem_access_addr = 32'h0000_0002;
    mem_read = 1;
    mem_write_en = 0;
    //mem_write_data = 32'hABCDEFAB;
    expected_result ={{25{mem_write_data[23]}},mem_write_data[22:16]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 13 - Verified");
    else
      $display("Test Scenario 13 - Error: Expected %h, Got %h", expected_result, mem_read_data);    
 //------tst14
 #10
    mem_access_addr = 32'h0000_0003;
    mem_read = 1;
    mem_write_en = 0;
    expected_result ={{25{mem_write_data[31]}},mem_write_data[30:24]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 14 - Verified");
    else
      $display("Test Scenario 14 - Error: Expected %h, Got %h", expected_result, mem_read_data);
    #10
    
    
// Test Scenario 2: Write  Half-Word----------------
    hfU = 0;
    bU = 0;
    hf = 1;
    b = 0;
    mem_access_addr = 32'h0000_0006; // Assuming half-word alignment
    mem_write_data = 32'h12345678;
    mem_write_en = 1;
    #10
    hf=0;
    mem_write_en = 0;
    mem_read = 1;
    expected_result = 32'h56780000;
    
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 20 - Verified");
    else
      $display("Test Scenario 20 - Error: Expected %h, Got %h", expected_result, mem_read_data);

    // Test Scenario 2: Read Half-Word----------------
    hfU = 0;
    bU = 0;
    //hf = 1;
    b = 0;
    mem_access_addr = 32'h0000_0004; // Assuming half-word alignment
    mem_write_data = 32'h12345678;
    mem_write_en = 1;
    #10
    hf=1;
    mem_write_en = 0;
    mem_read = 1;
    expected_result = 32'h00005678;
    
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 2 - Verified");
    else
      $display("Test Scenario 2 - Error: Expected %h, Got %h", expected_result, mem_read_data);
 #10
    mem_access_addr = 32'h0000_006;
    mem_read = 1;
    mem_write_en = 0;
    expected_result = 32'h00001234;
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 21 - Verified");
    else
      $display("Test Scenario 21 - Error: Expected %h, Got %h", expected_result, mem_read_data);
    #10
    
    
    
    // Test Scenario 3: Write and Read Word
    f = 1;
    hf = 0;
    mem_access_addr = 32'h0000_0008; // Assuming word alignment
    mem_write_data = 32'hABCDEF01;
    mem_write_en = 1;
    #10
    mem_write_en = 0;
    mem_read = 1;
    expected_result = 32'hABCDEF01;

    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 3 - Verified");
    else
      $display("Test Scenario 3 - Error: Expected %h, Got %h", expected_result, mem_read_data);

    
    
    #10
    // Test Scenario 4: Write and Read Unsigned Half-Word and Byte
    hfU = 1;
    bU = 0;
    hf = 0;
    b = 0;
    mem_access_addr = 32'h0000_000C; // C=1100// Assuming half-word alignment
    mem_write_data = 32'h789ABCDE;
    mem_write_en = 1;
    #10
    mem_write_en = 0;
    mem_read = 1;
    expected_result = 32'h0000BCDE;

    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 4 - Verified");
    else
      $display("Test Scenario 4 - Error: Expected %h, Got %h", expected_result, mem_read_data);
  #10
    mem_access_addr = 32'h0000_000E;
    mem_read = 1;
    mem_write_en = 0;
     //mem_write_data = 32'h789ABCDE;
    expected_result = 32'h0000789A;
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 41 - Verified");
    else
      $display("Test Scenario 41 - Error: Expected %h, Got %h", expected_result, mem_read_data);  
    #10
    
    
    
    // Test Scenario 4: Write and Read Unsigned Half-Word and Byte
    hfU = 0;
    bU = 1;
    hf = 0;
    b = 0;
    mem_access_addr = 32'h0000_0010; // Assuming half-word alignment
    mem_write_data = 32'h789ABCDE;
    mem_write_en = 1;
    #10
    mem_write_en = 0;
    mem_read = 1;
    expected_result ={24'd0,mem_write_data[7:0]};
    
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 5 - Verified");
    else
      $display("Test Scenario 5 - Error: Expected %h, Got %h", expected_result, mem_read_data);
      
      
#10
    mem_access_addr = 32'h0000_0011;
    mem_read = 1;
    mem_write_en = 0;
    expected_result ={24'd0,mem_write_data[15:8]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 52 - Verified");
    else
      $display("Test Scenario 52 - Error: Expected %h, Got %h", expected_result, mem_read_data);
 #10
    mem_access_addr = 32'h0000_0012;
    mem_read = 1;
    mem_write_en = 0;
    expected_result ={24'd0,mem_write_data[23:16]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 53 - Verified");
    else
      $display("Test Scenario 53 - Error: Expected %h, Got %h", expected_result, mem_read_data);    
 #10
    mem_access_addr = 32'h0000_0013;
    mem_read = 1;
    mem_write_en = 0;
    expected_result ={24'd0,mem_write_data[31:24]};
    #5
    // Check the result
    if (mem_read_data == expected_result)
      $display("Test Scenario 54 - Verified");
    else
      $display("Test Scenario 54 - Error: Expected %h, Got %h", expected_result, mem_read_data);
    
    #5000 $finish;
  end


endmodule
