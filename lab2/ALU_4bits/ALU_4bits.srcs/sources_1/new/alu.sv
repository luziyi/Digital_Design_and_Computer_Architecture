`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/25 15:53:36
// Design Name: 
// Module Name: alu
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


module alu(
    input [3:0] A,
    input [3:0] B,
    input [3:0] aluop,
    output [3:0] alures0,
    output [3:0] alures1,
    output logic ov,
    output logic zero
);
    reg [3:0] r_alures0;
    reg [3:0] r_alures1;
    
    assign alures0 = r_alures0;
    assign alures1 = r_alures1;
    wire [3:0] S;
    wire [3:0] Cout;
    
    reg [3:0]a,b;
    assign a=A;
    rca rca0(.A(a), .B(b), .S(S), .Cout(Cout));

    localparam	AND   =	4'b0000;
	localparam	OR    =	4'b0001;
	localparam	XOR   =	4'b0010;
	localparam	NAND  =	4'b0011;
	localparam	NOT   =	4'b0100;
	localparam	SLL   =	4'b0101;
	localparam	SRL   =	4'b0110;
	localparam	SRA   =	4'b0111;
	localparam	MULU  =	4'b1000;
	localparam	MUL   =	4'b1001;
	localparam	ADD   =	4'b1010;
    localparam	ADDU  =	4'b1011;
    localparam	SUB   =	4'b1100;
    localparam	SUBU  =	4'b1101;
    localparam	SLT   =	4'b1110;
    localparam	SLTU  =	4'b1111;
    
    always @(*) begin

        if(aluop==SUBU ||aluop==SUB)
            b=~B+1;
        else
            b=B;
    end


    logic [3:0] A_mux,B_mux;
    logic [7:0] Prod_tmp;
    logic [7:0] Prod;
    assign A_mux = (A[3])?(~A+1):A;
    assign B_mux = (B[3])?(~B+1):B;
    assign Prod_tmp = A_mux * B_mux;
    assign Prod = (A[3]^B[3])?(~Prod_tmp+1):(Prod_tmp);


    // Logic for setting zero and overflow flags
    // Select operation based on aluop
    always_comb begin
        ov= 1'b0;
        case(aluop)
            AND: begin
                r_alures0 = A & B;
                r_alures1 = 4'b0000;
            end
            OR: begin
                r_alures0 = A | B;
                r_alures1 = 4'b0000;
            end
            XOR: begin
                r_alures0 = A ^ B;
                r_alures1 = 4'b0000;
            end
            NAND: begin
                r_alures0 = ~(A & B);
                r_alures1 = 4'b0000;
            end
            NOT: begin
                r_alures0 = ~A;
                r_alures1 = 4'b0000;
            end
            SLL: begin
                r_alures0 = A << B[1:0];
                r_alures1 = 4'b0000;
            end
            SRL: begin
                r_alures0 = A >> B[1:0];
                r_alures1 = 4'b0000;
            end
            SRA: begin
                r_alures0 = $signed(A) >>> B[1:0];
                r_alures1 = 4'b0000;
            end
            MULU: {r_alures1,r_alures0} = A * B;
            MUL:  {r_alures1,r_alures0} = Prod;
            ADD: begin 
                r_alures0 = S;
                r_alures1 = 4'b0000;
                ov =  A[3] == B[3] && A[3] != S[3];
            end
            ADDU: begin r_alures0 = S; r_alures1 = 4'b0000; end
            SUB: begin
                r_alures0 = S;
                ov = A[3] == ~B[3] &&  A[3] != S[3];
            end
            SUBU: r_alures0 = S;
            SLT: r_alures0 = A[3]?(B[3]?(A<B?1:0):1):(B[3]?0:(A<B?1:0));
            SLTU: r_alures0 = (A < B) ? 1 : 0;


            // Add cases for other operations based on the table provided
            default: begin r_alures1 = 4'b0000; r_alures0 = A; end // Default case, can be modified
        endcase
    end
    assign zero = (r_alures1 == 4'b0000);
    
endmodule
