`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 13:58:05
// Design Name: 
// Module Name: pcCntr
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

//Imcomplete module, needed to modify the pc_current signal


module pcCntr(
input clk,rst,
input take_branch,jal,jalr,
input [31:0]immediate,
input [31:0]reg_read_data_1,
output reg  [31:0] pc_current,
[31:0]pc4,
[31:0]PC_plusImm,
[31:0]PC_Rs1plsImm
    );
 //PC
  
  

                                                                 
 assign pc4 = pc_current + 32'd4;                                                                                                                                                                                 
 assign PC_plusImm = pc_current + immediate;                                             
 assign PC_Rs1plsImm=reg_read_data_1+immediate; 
 
 wire [31:0]pc_next; 
 assign pc_next = ((take_branch==1'b1)|(jal==1'b1)) ? PC_plusImm :     ((jalr==1'b1) ? PC_Rs1plsImm: pc4);
 
 /*
 reg [31:0]pc_next;                                         
 always@(*)begin
  pc_next<=pc4;
  if((take_branch==1'b1)|(jal==1'b1))begin
  pc_next<=PC_plusImm;
   end
  if ((jalr==1'b1))begin   
    pc_next<=PC_Rs1plsImm; 
  end                                                                          

end
*/
 always @(posedge clk or posedge rst)//asynxhronous rst
 begin 
 if(rst==1'b1)
     pc_current <= 32'd0;
    // pc_current <= 32'he4;
 else
   pc_current <= pc_next;
 end

endmodule
