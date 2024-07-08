`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/25 15:50:44
// Design Name: 
// Module Name: rca
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


module rca(
    input [3:0] A, B,
    output [3:0] S,
    output [3:0] Cout
);
    wire [2:0] carry; // Intermediate carry outputs

    // Instantiate 4 full adders for 4-bit ripple carry adder
    fulladder fa0(.A(A[0]), .B(B[0]), .Cin(0), .S(S[0]), .Cout(carry[0]));
    fulladder fa1(.A(A[1]), .B(B[1]), .Cin(carry[0]), .S(S[1]), .Cout(carry[1]));
    fulladder fa2(.A(A[2]), .B(B[2]), .Cin(carry[1]), .S(S[2]), .Cout(carry[2]));
    fulladder fa3(.A(A[3]), .B(B[3]), .Cin(carry[2]), .S(S[3]), .Cout(Cout[3]));

    // Connect carry out of each full adder to the next full adder's Cin
    assign Cout[2:1] = carry[2:1]; // Connect carry outputs
endmodule
