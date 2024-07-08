`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/25 15:51:53
// Design Name: 
// Module Name: fulladder
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


module fulladder(
    input A, B, Cin,
    output S, Cout
);
    assign S = A ^ B ^ Cin; // XOR gate for sum
    assign Cout = (A & B) | (B & Cin) | (A & Cin); // OR gate for carry
endmodule
