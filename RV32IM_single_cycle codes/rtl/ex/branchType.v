`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2024 18:21:04
// Design Name: 
// Module Name: branchType
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


module branchType(opcode,funct3,branch_Operation,
                                branch_lsr,
                                branch_grtr,
                                branch_eql);
input [6:0]opcode;
input [2:0]funct3;
output reg  [3:0]branch_Operation;
output reg branch_lsr;
output reg        branch_grtr;
output reg        branch_eql;
  

always @(*) begin
  if(opcode==7'b1100011)begin
         // if it is a branch only
            case (funct3)
                3'b110: begin // BLTU
                    branch_Operation = 4'b0011; // sltU
                    branch_lsr = 1'b1;
                    branch_grtr = 1'b0;
                    branch_eql = 1'b0;
                end
                3'b100: begin // BLT
                    branch_Operation = 4'b0010; // slt
                    branch_lsr = 1'b1;
                    branch_grtr = 1'b0;
                    branch_eql = 1'b0;
                end
                3'b000: begin // BEQ
                    branch_Operation = 4'b0100; // xor
                    branch_lsr = 1'b0;
                    branch_grtr = 1'b0;
                    branch_eql = 1'b1;
                end
                3'b001: begin // BNQ
                    branch_Operation = 4'b0100; // xor
                    branch_lsr = 1'b1;
                    branch_grtr = 1'b1;
                    branch_eql = 1'b1;
                end
                3'b101: begin // BGE
                    branch_Operation = 4'b0010; // slt
                    branch_lsr = 1'b0;
                    branch_grtr = 1'b1;
                    branch_eql = 1'b0;
                end
                3'b111: begin // BGEU
                    branch_Operation = 4'b0011; // sltu
                    branch_lsr = 1'b0;
                    branch_grtr = 1'b1;
                    branch_eql = 1'b0;
                end
                default: begin
                    branch_Operation = 4'b1111; // even if it passed to ALU op, it can't generate any operation
                    branch_lsr = 1'b0;
                    branch_grtr = 1'b0;
                    branch_eql = 1'b0;
                end
            endcase
        end
else begin
            branch_Operation = 4'b1111; // even if it passed to ALU op, it can't generate any operation
            branch_lsr = 1'b0;
            branch_grtr = 1'b0;
            branch_eql = 1'b0;
end

end


/*
always@(*)begin
if(opcode==7'b1100011)begin //if it is an brach only

    if((funct3==3'b110))//BLTU
    begin
        branch_Operation=4'b0011  ;   //sltU 
        branch_lsr=1'b1;
        branch_grtr=1'b0;
        branch_eql=1'b0;
    end
     if((funct3==3'b100))//BLT
    begin
        branch_Operation=4'b0010 ;    //slt 
        branch_lsr=1'b1;
        branch_grtr=1'b0;
        branch_eql=1'b0;
    end
    if((funct3==3'b000))//BEQ
    begin
        branch_Operation=4'b0100   ;  //xor
        branch_lsr=1'b0;
        branch_grtr=1'b0;
        branch_eql=1'b1;
    end
    if((funct3==3'b001))//BNQ
    begin
        branch_Operation=4'b0100    ; //xor
        branch_lsr=1'b1;
        branch_grtr=1'b1;
        branch_eql=1'b1;
    end
    if((funct3==3'b101))//BGE
    begin
        branch_Operation=4'b0010     ;//slt 
        branch_lsr=1'b0;
        branch_grtr=1'b1;
        branch_eql=1'b0;
    end

     if((funct3==3'b111))//BGEU
    begin
        branch_Operation=4'b0011     ;//sltu
        branch_lsr=1'b0;
        branch_grtr=1'b1;
        branch_eql=1'b0;
    end
    
    else begin
        branch_Operation=4'b1111; // even it passed to alu op , it can tgenerate any operation
        branch_lsr=1'b0;
        branch_grtr=1'b0;
        branch_eql=1'b0;
    end 
  end
else begin
    branch_Operation=4'b1111; // even it passed to alu op , it can tgenerate any operation
    branch_lsr=1'b0;
    branch_grtr=1'b0;
    branch_eql=1'b0;
end


end
*/
endmodule
