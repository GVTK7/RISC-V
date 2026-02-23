`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 13:06:22
// Design Name: 
// Module Name: rv32im
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


module rv32im #(parameter DATA_MEM_SIZE= 10000,INSTR_SIZE= 10000)(
 input clk,
 input rst
 ,output [1:0]dataPathOut
// ,output[31:0]ALU_out
);

//M extesnipon scontrol signals
wire [1:0]sn;
wire Mul_en,Div_en;
wire[1:0] M_sel;
wire MI_sel;

//wire dataPathOut;
 wire [31:0] instruction;

 wire[31:0] reg_write_data;
 
 wire [31:0] reg_read_data_1;

 wire [31:0] reg_read_data_2;
 wire [31:0]read_data2;
 wire [31:0] ALU_out;

 wire [12:0] jump_shift;
 wire [31:0] mem_read_data;

 
 wire lsr,gtr,eql;
 
 wire jal,jalr,lui,auipc;
 wire branch_lsr,branch_grtr,branch_eql;
 
 wire b,hf,f,bU,hfU;//byte, half word ,fullword
 wire [3:0]alu_op;//alu operations control
 
 wire [2:0]ImmOp;   //immetiate format decoding signal
 wire [31:0]immediate;

wire [6:0]opcode;
 assign opcode = instruction[6:0];
 wire [2:0]funct3;
 assign funct3=instruction[14:12];
  wire [6:0]funct7;
 assign funct7=instruction[31:25];
 wire [4:0] reg_read_addr_1;
 //assign reg_read_addr_1=instruction[19:15];
  wire [4:0] reg_read_addr_2;
 //assign reg_read_addr_2=instruction[24:20] ;
  wire [4:0] reg_write_dest;
 // assign reg_write_dest=instruction[11:7];
  
   assign reg_write_dest = instruction[11:7];
 assign reg_read_addr_1 = instruction[19:15];
 assign reg_read_addr_2 = instruction[24:20];
 
 //brach conditon checking
 wire take_branch;  
  branchSignal brhchdut (
    .lsr(lsr),
    .gtr(gtr),
    .eql(eql),
    .branch_lsr(branch_lsr),
    .branch_grtr(branch_grtr),
    .branch_eql(branch_eql),
    .take_branch(take_branch)
  );
  
    
    //PC
   wire [31:0] pc4,PC_plusImm,PC_Rs1plsImm;  
    wire  [31:0] pc_current;
      pcCntr pccntr_instance (
    .clk(clk),
    .rst(rst),
    .take_branch(take_branch),
    .jal(jal),
    .jalr(jalr),
    .immediate(immediate),
    .reg_read_data_1(reg_read_data_1),
    .pc_current(pc_current),
    .pc4(pc4),
    .PC_plusImm(PC_plusImm),
    .PC_Rs1plsImm(PC_Rs1plsImm)
  );

 // instruction memory
// InstructionMemory#(INSTR_SIZE) instrctionmeminstance(.start(!rst),.pc(pc_current),.instruction(instruction));
InstructionMemry_withWrite #(INSTR_SIZE) InstructionMemory_inst_wth_wr (
 //   .instrWrEn(instrWrEn),     // Input: Enable signal for writing to instruction memory
 //   .pc_in(pc_in),             // Input: Program counter input for writing
 //   .InstrByte(InstrByte),     // Input: Instruction byte input for writing

 //   .clk(clk),                 // Input: Clock signal
    .start(!rst),             // Input: Start signal for initiating read operation
    .pc(pc_current),                   // Input: Program counter for reading
    .instruction(instruction)  // Output: Instruction output
);

//Immediate
 
wire [24:0]immData=instruction[31:7];
 ImmGen  imgen(immData,ImmOp,immediate);

 //GPRs

GPRs reg_file
 (
  .clk(clk),
  .rst(rst),
  .we_i(reg_write),
  .waddr_i(reg_write_dest),
  .wdata_i(reg_write_data),
  .raddr1_i(reg_read_addr_1),
  .rdata1_o(reg_read_data_1),
  .raddr2_i(reg_read_addr_2),
  .rdata2_o(reg_read_data_2)
 );
 
  // ALU
  wire [31:0]rv32i_ALU_out;
 assign read_data2 = (selRs2Imm==1'b1) ? immediate : reg_read_data_2;
 alu_rv32im alu_rv32im_instanc (
    // RV32I ALU ports
    .sel_in (alu_op),   // 4-bit input port
    .in_1 (reg_read_data_1),       // 32-bit input port
    .in_2 (read_data2),       // 32-bit input port
    .result_out (ALU_out), // 32-bit output port
    .lsr (lsr),         // 1-bit output port
    .gtr (gtr),         // 1-bit output port
    .eql (eql),         // 1-bit output port
    // M extension control signals
    .sn (sn),           // 2-bit input port
    .Mul_en (Mul_en),   // 1-bit input port
    .Div_en (Div_en),   // 1-bit input port
    .M_sel (M_sel),     // 2-bit input port
    .MI_sel (MI_sel)    // 1-bit input port
);
  
 
 /// Data memory
  dataMemory#(DATA_MEM_SIZE) DataMemory
   (
    .clk(clk),
    .b(b),
    .hf(hf),
    .f(f),
    .bU(bU),
    .hfU(hfU),
    .mem_access_addr(ALU_out),
    .mem_write_data(reg_read_data_2),
    .mem_write_en(mem_write),
    .mem_read(mem_read),
    .mem_read_data(mem_read_data)
   );
 
  // write backing mux
   rsltMux writing_back_mux (
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

/* 

 always@(*)begin
 reg_write_data=ALU_out;
if(ld==1'b1)
    reg_write_data= mem_read_data;
if((jal|jalr)==1'b1)        //store the PC+4 value in the rd 
    reg_write_data= pc4;
if(auipc==1'b1)     // store the PC+imme
    reg_write_data=PC_plusImm ;
if(lui==1'b1)
    reg_write_data= immediate;  
 end    
 */
 
 
 // output to control unit

 

  ControlUnit cntrolunit (
    .opcode(opcode),
      .funct3(funct3),
    .funct7(funct7),
    
    .alu_op(alu_op),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .selRs2Imm(selRs2Imm),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .ld(ld),
    
    .ImmOp(ImmOp),
    .jal(jal),
    .jalr(jalr),
    .lui(lui),
    .auipc(auipc)
   ,.branch_lsr(branch_lsr),.branch_grtr(branch_grtr),.branch_eql(branch_eql)
  ,.byte(b), .half_word(hf), .full_word(f), .byteU(bU), .half_wordU(hfU)
  ,.sn(sn),
.Mul_en(Mul_en), .Div_en(Div_en),
.M_sel(M_sel),
.MI_sel(MI_sel)
  );


assign dataPathOut[0]=reg_write_data[0];
assign dataPathOut[1]=reg_write_data[31];
endmodule