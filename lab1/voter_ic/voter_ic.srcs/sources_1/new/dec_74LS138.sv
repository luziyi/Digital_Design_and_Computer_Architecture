`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 16:12:37
// Design Name: 
// Module Name: dec_74LS138
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


module dec_74LS138(
    input G,
    input G_2A,
    input G_2B,
    input [2:0] D,
    output [7:0] Y
    );
    reg [7:0] y;
    always @* begin
        if (G && ~G_2A && ~G_2B)
            case (D)
                3'b000: y = 8'b11111110;
                3'b001: y = 8'b11111101;
                3'b010: y = 8'b11111011;
                3'b011: y = 8'b11110111;
                3'b100: y = 8'b11101111;
                3'b101: y = 8'b11011111;
                3'b110: y = 8'b10111111;
                3'b111: y = 8'b01111111;
            endcase
    end
    assign Y = y;
endmodule

