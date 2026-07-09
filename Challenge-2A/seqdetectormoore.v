`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 01:32:26 AM
// Design Name: 
// Module Name: seqdetectormoore
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


module seqdetectormoore(
    input x,
    input reset_n,
    input clk,
    output y
    );
    
    reg [2:0] cState, aState;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    
    
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
                        aState = s5;
                    else
                        aState = s4;
                end
            s4: begin
                    if(x)
                        aState = s3;
                    else
                        aState = s0;
                end
            s5: begin
                    if(x)
                        aState = s1;
                    else
                        aState = s2;
                end
            default : aState = cState;
        endcase
     end
     
     //Output Logic
     assign y = ((cState == s3)|(cState == s4)|(cState == s5));
    
endmodule
