`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 15:20:56
// Design Name: 
// Module Name: tb_rv32im
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


module tb_rv32im();


    // inputs
    reg clk; 
    reg rst; 

    // outputs
    wire [31:0] tb_Result; 

    rv32im #(10000,10000) processor_(
        .clk(clk),
        .rst(rst)
    );

    always begin 
    #10; 
    clk = ~clk; 
    end

    initial begin
    clk  = 0;  
        rst = 1; 
    end

    integer point = 0; 
    initial begin
     #35
    rst=0;
    end
endmodule
