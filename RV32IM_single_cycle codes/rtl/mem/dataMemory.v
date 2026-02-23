`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 15:45:01
// Design Name: 
// Module Name: dataMemory
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

//Synchronous read, asynchronous write

module dataMemory #(parameter DATA_MEM_SIZE=145722)(
 input clk,
 
 input b,hf,f,bU,hfU,  //byte data,word data, halfword data
 
 input [31:0]   mem_access_addr,//byte address
 input [31:0]   mem_write_data,
 input     mem_write,
 
 input mem_read,
 output reg [31:0]   mem_read_data
);

parameter col=32;
parameter row_d=DATA_MEM_SIZE;

integer  p;
reg [col - 1:0] memory [row_d - 1:0];
 (* ram_style = "block" *)
 
integer f1;
wire [29:0] ram_addr=mem_access_addr[31:2];
initial
 begin
  $readmemh("rtl/mem_init/data.mem", memory,0,row_d-1);
  for(p=0;p<DATA_MEM_SIZE;p=p+1)
    memory[p]=32'd0;
    
/*  f1 = $fopen("istrct_out.out");
  $fmonitor(f, "time = %d\n", $time, 
  "\tmemory[0] = %d\n", memory[0],   
  "\tmemory[1] = %d\n", memory[1],
  "\tmemory[2] = %d\n", memory[2],
  "\tmemory[3] = %d\n", memory[3],
  "\tmemory[4] = %d\n", memory[4],
  "\tmemory[5] = %d\n", memory[5],
  "\tmemory[6] = %d\n", memory[6],
  "\tmemory[7] = %d\n", memory[7]);
  #5000;
  $fclose(f);
  */
 end
  always @(posedge clk) begin                     //asynchronous write from Data Memory
   //   $monitor("Data at memory[%0d] changed: %h -> %h", memory); 
      if((mem_write==1'b1)*(mem_access_addr<32'd10240))begin
        if(b == 1'b1 )begin
            if((~mem_access_addr[1])&(~mem_access_addr[0]))           //00
            memory[ram_addr][7:0] <= mem_write_data[7:0]; 
            if((~mem_access_addr[1])&(mem_access_addr[0]))           //01
            memory[ram_addr][15:8] <= mem_write_data[7:0];
            if((mem_access_addr[1])&(~mem_access_addr[0]))           //10
            memory[ram_addr][23:16] <= mem_write_data[7:0];
            if((mem_access_addr[1])&(mem_access_addr[0]))           //11
            memory[ram_addr][31:24] <= mem_write_data[7:0];
        end
        else if(( hf==1'b1)&(mem_access_addr+1<32'd10240))begin         //If half word my max address would be 102388
            if(mem_access_addr[1])                           //1 
            memory[ram_addr][31:16] <= mem_write_data[15:0];
            if(~mem_access_addr[1])                           //0 
            memory[ram_addr][15:0] <= mem_write_data[15:0]; 
        end
        //else if ((f==1'b1)&(mem_access_addr+3<32'd10240))      //If full word my max address would be 102386
        else if ((mem_access_addr+3<32'd10240))    
            memory[ram_addr] <= mem_write_data[31:0];
     end
    end
always@(*)begin
  //  if ((mem_read==1'b1)&(mem_write_en==1'b0))begin
if ((mem_read==1'b1))begin
        if( b == 1'b1 )begin
                    if(mem_access_addr[0]&mem_access_addr[1])begin        //11            
			         mem_read_data[31:0] <={{24{memory[ram_addr][31]}},memory[ram_addr][31:24]};
			         end
                    else if(mem_access_addr[1]&(~mem_access_addr[0]))begin         //10     
			         mem_read_data[31:0] <={{24{memory[ram_addr][23]}},memory[ram_addr][23:16]};
			         end
                    else if((~mem_access_addr[1])&mem_access_addr[0])begin            //01            
			         mem_read_data[31:0] <={{24{memory[ram_addr][15]}},memory[ram_addr][15:8]};
			         end
                 //   if((~mem_access_addr[0])&(~mem_access_addr[1]))begin            //00 
			     else    mem_read_data[31:0] <={{24{memory[ram_addr][7]}},memory[ram_addr][7:0]};
			      //  end
	     end
         else if (hf==1'b1)begin
			          if(mem_access_addr[1])                 //1
			              mem_read_data[31:0] <={{16{memory[ram_addr][31]}},memory[ram_addr][31:16]};
			      //if(~mem_access_addr[1])                 //0
			        else      mem_read_data[31:0] <={{16{memory[ram_addr][15]}},memory[ram_addr][15:0]};		
	     end	      
 
			         
			         
          else if( bU == 1'b1 )begin
                    if(mem_access_addr[1]&mem_access_addr[0])begin        //11            
			         mem_read_data[31:0] <={24'd0,memory[ram_addr][31:24]};
			         end
                   else if(mem_access_addr[1]&(~mem_access_addr[0]))begin         //10     
			         mem_read_data[31:0] <={24'd0,memory[ram_addr][23:16]};
			         end
                    else if((~mem_access_addr[1])&mem_access_addr[0])begin            //01            
			         mem_read_data[31:0] <={24'd0,memory[ram_addr][15:8]};
			         end
                 // if((~mem_access_addr[1])&(~mem_access_addr[0]))begin            //00 
			    else     mem_read_data[31:0] <={24'd0,memory[ram_addr][7:0]};
			   //  end 
			end
			   
	        else if (hfU==1'b1)begin
			          if(mem_access_addr[1])                 //1
			              mem_read_data[31:0] <={16'd0,memory[ram_addr][31:16]};
			      //   if(~mem_access_addr[1])                 //0
			        else   mem_read_data[31:0] <={16'd0,memory[ram_addr][15:0]};		
			end
			     //else if (f==1'b1)
			else
			          mem_read_data[31:0] <=memory[ram_addr];
	end
    else
			          mem_read_data[31:0] <=32'd0;
	 
			     
end 			     	      

endmodule
