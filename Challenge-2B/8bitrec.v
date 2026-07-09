`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 06:32:59 PM
// Design Name: 
// Module Name: 8bitrec
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
//////////////////////////////////////////////////////////////////////////////////


module bitrec(
    input clk,
    input reset_n,
    input x,
    output reg  done, parity_err, frame_err,
    output reg [7:0] data_out
);

    // FSM states
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;

    reg [1:0] state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;
    reg parity;

    always @(posedge clk) 
    begin
        if (!reset_n) 
        begin
            state      <= s0;
            bit_count  <= 3'd0;
            shift_reg  <= 8'd0;
            parity     <= 1'b0;
            parity_err <= 1'b0;
            data_out   <= 8'd0;
            frame_err  <= 1'b0;
            done       <= 1'b0;
        end
        
        else
        begin
            
        done       <= 1'b0;
        parity_err <= 1'b0;
        frame_err  <= 1'b0;

        case (state)
            s0: begin 
                if (x == 1'b0) 
                    begin       
                    state   <= s1;
                    bit_count <= 3'd0;
                    end
                end

            s1: begin
                shift_reg <= {x, shift_reg[7:1]};  
                if (bit_count == 3'd7)
                    state <= s2;
                else
                    bit_count <= bit_count + 3'd1;
            end

            s2: begin
                parity <= x;
                state  <= s3;
            end

            s3: begin
                state <= s0;
                done  <= 1'b1;   

                if (x != 1'b1)
                    frame_err <= 1'b1;

                if (parity != (^shift_reg))   
                    parity_err <= 1'b1;

                if ((x != 1'b1) || (parity != (^shift_reg)))
                    data_out <= 8'd0;
                else
                    data_out <= shift_reg;
            end

            default: state <= s0;
        endcase
        end
    end

endmodule
