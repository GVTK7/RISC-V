`timescale 1ns / 1ps

//tests the RISC-V processor by comparing the test bench result to the
//processor's output. A correct processor outupt, gives a point.
//The testbench must give a total of 20 points to verify the processor.
`timescale 1ns / 1ps

//tests the RISC-V processor by comparing the test bench result to the
//processor's output. A correct processor outupt, gives a point.
//The testbench must give a total of 20 points to verify the processor.

module tb_dataPath( );

    // inputs
    reg clk; 
    reg rst; 

    // outputs
    wire [31:0] tb_Result; 

    DataPath #(8192000,8192000) processor_(
        .clk(clk),
        .rst(rst),
        .ALU_out(tb_Result)
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
/*reg [31:0]expected_result;
    initial
    begin 
       #35;
       rst=0;
    //1 
        #5
        expected_result=32'h00000000;
        if (tb_Result == expected_result) // and
        begin 
            point = point + 1; 
        end
        else 
            $display("and type - Error: Expected %d, Got %d", expected_result,tb_Result);
//2
#15;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//3
#20;
expected_result = 32'h00000002;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//4
#20;
expected_result = 32'h00000004;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//5
#20;
expected_result = 32'h00000005;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//6
#20;
expected_result = 32'h00000007;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//7
#20;
expected_result = 32'h00000008;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//8
#20;
expected_result = 32'h0000000b;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//9
#20;
expected_result = 32'h00000003;
if (tb_Result == expected_result) begin // add
    point = point + 1;
end else begin
    $display("add type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//10
#20;
expected_result = 32'hfffffffe;
if (tb_Result == expected_result) begin // sub
    point = point + 1;
end else begin
    $display("sub type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//11
#20;
expected_result = 32'h00000000;
if (tb_Result == expected_result) begin // add
    point = point + 1;
end else begin
    $display("add type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//12
#20;
expected_result = 32'h00000005;
if (tb_Result == expected_result) begin // or
    point = point + 1;
end else begin
    $display("or type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//13
#20;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // SLT
    point = point + 1;
end else begin
    $display("SLT type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//14
#20;
expected_result = 32'd3;//32'hfffffff4;
if (tb_Result == expected_result) begin // NOR
    point = point + 1;
end else begin
    $display("NOR type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//15
#20;
expected_result = 32'h000004D2;
if (tb_Result == expected_result) begin // andi
    point = point + 1;
end else begin
    $display("andi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//16
#20;
expected_result = 32'hfffff8D7;
if (tb_Result == expected_result) begin // ori
    point = point + 1;
end else begin
    $display("ori type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//17
#20;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // SLT
    point = point + 1;
end else begin
    $display("SLT type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//18
#20;
expected_result =32'd1233;
if (tb_Result == expected_result) begin // xori
    point = point + 1;
end else begin
    $display("nori type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//19
#20;
expected_result = 32'h00000030;
if (tb_Result == expected_result) begin // sw
    point = point + 1;
end else begin
    $display("sw type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//20

#20;
expected_result = 32'h00000030;
if (tb_Result == expected_result) begin // lw
    point = point + 1;
end else begin
    $display("lw type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

     $display("%s%d", "The number of correct test caese is:" , point); 

    end

    initial begin 
    #430;
    $finish; 
    
    end

*/

endmodule


///////////////////---------------------------------------/////////////////////////////////////////







/*
module tb_dataPath( );

    // inputs
    reg clk; 
    reg rst; 

    // outputs
    wire [31:0] tb_Result; 

    DataPath processor_(
        .clk(clk),
        .rst(rst),
        .ALU_out(tb_Result)
    );

    always begin 
    #10; 
    clk = ~clk; 
    end

    initial begin
    clk  = 0; 
    @(posedge clk); 
        rst = 1; 
    @(posedge clk); 
        rst  = 0; 
    end

    integer point = 0; 
reg [31:0]expected_result;
    always @ (*)
    begin 
    //1
        #10; 
        expected_result=32'h00000000;
        if (tb_Result == expected_result) // and
        begin 
            point = point + 1; 
        end
        else 
            $display("and type - Error: Expected %d, Got %d", expected_result,tb_Result);
//2
#20;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//3
#20;
expected_result = 32'h00000002;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//4
#20;
expected_result = 32'h00000004;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//5
#20;
expected_result = 32'h00000005;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//6
#20;
expected_result = 32'h00000007;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//7
#20;
expected_result = 32'h00000008;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

//8
#20;
expected_result = 32'h0000000b;
if (tb_Result == expected_result) begin // addi
    point = point + 1;
end else begin
    $display("addi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//9
#20;
expected_result = 32'h00000003;
if (tb_Result == expected_result) begin // add
    point = point + 1;
end else begin
    $display("add type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//10
#20;
expected_result = 32'hfffffffe;
if (tb_Result == expected_result) begin // sub
    point = point + 1;
end else begin
    $display("sub type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//11
#20;
expected_result = 32'h00000000;
if (tb_Result == expected_result) begin // add
    point = point + 1;
end else begin
    $display("add type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//12
#20;
expected_result = 32'h00000005;
if (tb_Result == expected_result) begin // or
    point = point + 1;
end else begin
    $display("or type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//13
#20;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // SLT
    point = point + 1;
end else begin
    $display("SLT type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//14
#20;
expected_result = 32'd3;//32'hfffffff4;
if (tb_Result == expected_result) begin // NOR
    point = point + 1;
end else begin
    $display("NOR type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//15
#20;
expected_result = 32'h000004D2;
if (tb_Result == expected_result) begin // andi
    point = point + 1;
end else begin
    $display("andi type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//16
#20;
expected_result = 32'hfffff8D7;
if (tb_Result == expected_result) begin // ori
    point = point + 1;
end else begin
    $display("ori type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//17
#20;
expected_result = 32'h00000001;
if (tb_Result == expected_result) begin // SLT
    point = point + 1;
end else begin
    $display("SLT type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//18
#20;
expected_result =32'd1233;
if (tb_Result == expected_result) begin // xori
    point = point + 1;
end else begin
    $display("nori type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//19
#20;
expected_result = 32'h00000030;
if (tb_Result == expected_result) begin // sw
    point = point + 1;
end else begin
    $display("sw type - Error: Expected %d, Got %d", expected_result, tb_Result);
end
//20

#20;
expected_result = 32'h00000030;
if (tb_Result == expected_result) begin // lw
    point = point + 1;
end else begin
    $display("lw type - Error: Expected %d, Got %d", expected_result, tb_Result);
end

     $display("%s%d", "The number of correct test caese is:" , point); 

    end

    initial begin 
    #430;
    $finish; 
    
    end


endmodule
*/