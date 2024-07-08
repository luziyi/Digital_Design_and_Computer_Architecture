`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/03 18:33:03
// Design Name: 
// Module Name: vend_fsm
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


module vend_fsm(
    input                      sys_clk,
    input                      sys_rst_n,
    input                      coin5,
    input                      coin10,
    output           [4 : 0]   price,
    output           [4 : 0]   change,
    output                     open
    );

    reg r_open;
    reg [4:0]r_price;
    reg [4:0]r_change;
    // State
    logic [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    logic [2:0] state;
    logic [2:0] next_state;

    // State Register
    always_ff @(posedge sys_clk) begin
        if (!sys_rst_n) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end

    // State Transition
    always_comb begin
        case(state)
            S0: begin
                if (coin5) begin
                    next_state = S1;
                end
                else if (coin10) begin
                    next_state = S2;
                end
                else next_state = S0;
            end
            S1: begin
                if(coin5) begin
                    next_state = S2;
                end
                else if(coin10) begin
                    next_state = S3;
                end
                else next_state = S1;
            end
            S2: begin 
                if(coin5) begin
                    next_state = S3;
                end
                else if(coin10) begin
                    next_state = S4;
                end
                else next_state = S2;
            end
            S3: begin
                next_state = S3;
            end
            S4: begin
                next_state = S4;
            end
        endcase 
    end


    // Output
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) begin
            r_open <= 1'b0;
            r_price <= 5'd0;
            r_change <= 5'd0;
        end
        else begin
        case(next_state)
            S0: begin
                r_open <= 1'b0;
                r_price <= 5'd0;
                r_change <= 5'd0;
            end
            S1: begin
                r_open <= 1'b0;
                r_price <= 5'd5;
                r_change <= 5'd0;
            end
            S2: begin
                r_open <= 1'b0;
                r_price <= 5'd10;
                r_change <= 5'd0;
            end
            S3: begin
                r_open <= 1'b1;
                r_price <= 5'd15;
                r_change <= 5'd0;
            end
            S4: begin
                r_open <= 1'b1;
                r_price <= 5'd20;
                r_change <= 5'd5;
            end
        endcase
        end
    end

    assign open = r_open;
    assign price = r_price;
    assign change = r_change;

endmodule
