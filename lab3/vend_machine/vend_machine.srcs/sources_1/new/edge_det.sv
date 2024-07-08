`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/03 18:32:49
// Design Name: 
// Module Name: edge_det
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


module edge_det(
    input sys_clk,
    input sys_rst_n,
    input coin5,
    input coin10,
    output coin5_pluse,
    output coin10_pluse
    );
    reg coin5_q1, coin5_q2;
    reg coin10_q1, coin10_q2;
    always_ff @(posedge sys_clk) begin
        if (!sys_rst_n) begin
            coin5_q1 <= 1'b0;
            coin5_q2 <= 1'b0;
            coin10_q1 <= 1'b0;
            coin10_q2 <= 1'b0;
        end
        else begin
            coin5_q1 <= coin5;
            coin5_q2 <= coin5_q1;
            coin10_q1 <= coin10;
            coin10_q2 <= coin10_q1;
        end
    end
    assign coin5_pluse = coin5_q1 & ~coin5_q2;
    assign coin10_pluse = coin10_q1 & ~coin10_q2;
endmodule
