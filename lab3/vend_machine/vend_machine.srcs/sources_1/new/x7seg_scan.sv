`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/03 18:33:20
// Design Name: 
// Module Name: x7seg_scan
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


module x7seg_scan(
    input                      sys_clk,
    input                      sys_rst_n,
    input                      clk_flag,
    input           [7 : 0]    dis_price,
    input           [7 : 0]    dis_change,
    output logic    [3 : 0]    x7seg_data,
    output logic    [3 : 0]    an
    );
    localparam STUBNUM = 4;
    localparam  AN0  = 4'b0001,
                AN1  = 4'b0010,
                AN2  = 4'b0100,
                AN3  = 4'b1000;
                
    logic [1 : 0] r_cnt;
    always_ff @(posedge sys_clk) begin
        if (!sys_rst_n) r_cnt <= 2'b0;
        else if (clk_flag) begin
            if (r_cnt == STUBNUM - 1) r_cnt <= 2'b0;
            else r_cnt <= r_cnt + 1;
        end
        else r_cnt <= r_cnt;
    end
    always_ff @(posedge sys_clk) begin
        if (!sys_rst_n) an <= 4'b1111;
        else begin
            case (r_cnt)
                2'b00 : an <= AN0;
                2'b01 : an <= AN1;
                2'b10 : an <= AN2;
                2'b11 : an <= AN3;
            endcase
        end
    end
    always_ff @(posedge sys_clk) begin
        if (!sys_rst_n) x7seg_data <= 4'b0000;
        else begin
            case (r_cnt)
                2'b00 : x7seg_data <= dis_price[3 : 0];
                2'b01 : x7seg_data <= dis_price[7 : 4];
                2'b10 : x7seg_data <= dis_change[3 : 0];
                2'b11 : x7seg_data <= dis_change[7 : 4];
            endcase
        end
    end
endmodule