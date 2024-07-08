`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/27 21:38:13
// Design Name: 
// Module Name: ALU_4bits_tb
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


module ALU_4bits_tb(

    );
    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] aluop;
    wire [3:0] alures0;
    wire [3:0] alures1;
    wire zero;
    wire ov;
    
    alu alu0(
        .A(A),
        .B(B),
        .aluop(aluop),
        .alures0(alures0),
        .alures1(alures1),
        .ov(ov),
        .zero(zero)
    );
    
    initial begin
        A = 4'b1100;
        B = 4'b1010;
        aluop = 4'b0000;
        #10;
        A = 4'b1100;
        B = 4'b1010;
        aluop = 4'b0001;
        #10;
        A = 4'b1100;
        B = 4'b1010;
        aluop = 4'b0010;
        #10;
        A = 4'b1100;
        B = 4'b1010;
        aluop = 4'b0011;
        #10;
        A = 4'b1010;
        B = 4'b0000;
        aluop = 4'b0100;
        #10;
        A = 4'b1011;
        B = 4'b1010;
        aluop = 4'b0101;
        #10;
        A = 4'b1100;
        B = 4'b0110;
        aluop = 4'b0110;
        #10;
        A = 4'b1100;
        B = 4'b1010;
        aluop = 4'b0111;
        #10;
        A = 4'b0100;
        B = 4'b1010;
        aluop = 4'b0111;
        #10;
        A = 4'b1111;
        B = 4'b1111;
        aluop = 4'b1000;
        #10;
        A = 4'b1000;
        B = 4'b0111;
        aluop = 4'b1001;
        #10;
        A = 4'b1110;
        B = 4'b1010;
        aluop = 4'b1010; //负数溢出
        #10;
        A = 4'b0110;
        B = 4'b0010;
        aluop = 4'b1010; //正数溢出
        #10;
        A = 4'b1011;
        B = 4'b1111;
        aluop = 4'b1011;
        #10;
        A = 4'b1110;
        B = 4'b0110;
        aluop = 4'b1100;//负溢出判断
        #10;
        A = 4'b0110;
        B = 4'b1110;
        aluop = 4'b1100;//正溢出判断
        #10;
        A = 4'b0101;
        B = 4'b1100;
        aluop = 4'b1101;
        #10;
        A = 4'b1110;
        B = 4'b0110;
        aluop = 4'b1110;
        #10;
        A = 4'b1011;
        B = 4'b1111;
        aluop = 4'b1111;
        #10;
        $stop;
    end

    
    
endmodule
