`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 12:52:28
// Design Name: 
// Module Name: tb_Datapath_with_Uart
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



`timescale 1ns / 1ps

module tb_Datapath_with_Uart();

    // Inputs
    reg clk = 0;            // Clock signal
    reg rst = 1;            // Reset signal
    reg tx_rst = 1;         // UART reset signal
    reg transmit;// = 0;       // UART transmission signal

    // Outputs
    wire TX_out;            // UART serial output pin

   wire [3:0]add;
    // Instantiate the Datapath with UART module
    DataPath_with_Uart tb_dthpth_uart(
        .clk(clk),
        .rst(rst),
        .tx_rst(tx_rst),
        .transmit(transmit),
        .TX_out(TX_out),
        .add(add)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial block for reset
    initial begin
        // Reset sequence
        transmit=0;
             #10 rst = 1; tx_rst=1; 
        #10 rst = 0;
         tx_rst=0;
   
 //   #2000000 transmit = 1;
        // Activate UART transmission after some time
       // #100 transmit = 1;
    end

    // Monitor for observing TX_out
    initial begin
        $monitor("Time = %0t, TX_out = %b", $time, TX_out);
    end

    // Stop simulation after certain time
  //  initial #200 $finish;

endmodule
