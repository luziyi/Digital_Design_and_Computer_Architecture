`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/23 22:00:32
// Design Name: 
// Module Name: voter5
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


module voter5(
    input [4:0] I,
    output  pass
);
reg reg_pass;
always @(*) begin
    // Count the number of ones in the input
    integer count = 0;
    for (int i = 0; i < 5; i = i + 1) begin
        if (I[i] == 1) begin
            count = count + 1;
        end
    end
    
    // Output high if majority of inputs are high
    if (count >= 3) begin
        reg_pass = 1;
    end else begin
        reg_pass = 0;
    end
end

assign pass=reg_pass;
endmodule
