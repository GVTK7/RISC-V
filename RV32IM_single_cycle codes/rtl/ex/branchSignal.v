`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 13:54:21
// Design Name: 
// Module Name: branchSignal
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


module branchSignal(
input lsr,gtr,eql, 
input branch_lsr,branch_grtr,branch_eql,
output  reg take_branch);
    
     //brach conditon checking
  
always@(*)begin
case({branch_lsr,branch_grtr,branch_eql})
    3'b100: begin       if(lsr==1'b1)take_branch=1'b1;  else take_branch=1'b0;       end //lesser
    3'b010: begin       if(gtr==1'b1)take_branch=1'b1;  else take_branch=1'b0;       end //greater
    3'b001: begin       if(eql==1'b1)take_branch=1'b1;  else take_branch=1'b0;       end //equal
    3'b111: begin       if(eql!=1'b1)take_branch=1'b1;  else take_branch=1'b0;       end  //not equal
    default:   take_branch=1'b0;
   endcase
   end
endmodule
