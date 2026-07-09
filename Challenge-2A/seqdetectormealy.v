`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 01:18:33 AM
// Design Name: 
// Module Name: seqdetector
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


module seqdetectormealy(
    input x,
    input reset_n,
    input clk,
    output y
    );
    
    reg [1:0] cState, aState;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    
    //State Register
    always @(posedge clk, negedge reset_n) 
     begin
        if(~reset_n)
            cState <= s0;
        else
            cState <= aState;
     end
     
     //Case Logic
     always @(*)
     begin
        case(cState)
            s0: begin
                    if(x)
                        aState = s1;
                    else
                        aState = s0;
                end
            s1: begin
                    if(x)
                        aState = s1;
                    else
                        aState = s2;
                end
            s2: begin
                    if(x)
                        aState = s3;
                    else
                        aState = s0;
                end
            s3: begin
                    if(x)
                        aState = s1;
                    else
                        aState = s2;
                end
            default : aState = cState;
        endcase
     end
     
     //Output Logic
     assign y = (cState == s3) | ((cState == s2) & x);
     
endmodule
