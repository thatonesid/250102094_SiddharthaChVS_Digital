`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 01:11:30 AM
// Design Name: 
// Module Name: bonus_challenge
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

module bonus(
    input clk,
    input reset_n,     
    input x,
    output reg  done,
    output reg  parity_err,
    output reg  frame_err,
    output reg [7:0] result
);

    
    reg [7:0] A, B;

    // FSM states
    localparam s0  = 0;
    localparam s1  = 1;
    localparam s2  = 2;
    localparam s3  = 3;
    localparam s4  = 4;

    reg [2:0] state;
    reg [2:0] bit_count;
    reg [1:0] command_reg;
    reg [7:0] data_reg;
    reg parity;


    wire frame_error_now, parity_error_now;
    assign frame_error_now  = (x != 1'b1);                 
    assign parity_error_now = (parity != (^data_reg));  

    always @(posedge clk) 
    begin
        if (!reset_n) 
        begin
            state       <= s0;
            bit_count   <= 3'd0;
            command_reg <= 2'd0;
            data_reg    <= 8'd0;
            parity      <= 1'b0;
            A           <= 8'd0;
            B           <= 8'd0;
            done        <= 1'b0;
            parity_err  <= 1'b0;
            frame_err   <= 1'b0;
            result      <= 8'd0;
        end 
        
        else 
        begin
            
            done       <= 1'b0;
            parity_err <= 1'b0;
            frame_err  <= 1'b0;

            case (state)
                s0: begin
                    if (x == 1'b0) begin          
                        state   <= s1;
                        bit_count <= 3'd0;
                    end
                end

                s1: begin
                    command_reg <= {x, command_reg[1]};    
                    if (bit_count == 3'd1) begin
                        state   <= s2;
                        bit_count <= 3'd0;
                    end else begin
                        bit_count <= bit_count + 3'd1;
                    end
                end

                s2: begin
                    data_reg <= {x, data_reg[7:1]}; 
                    if (bit_count == 3'd7) begin
                        state <= s3;
                        bit_count <= 0;
                    end else begin
                        bit_count <= bit_count + 3'd1;
                    end
                end

                s3: begin
                    parity <= x;
                    state      <= s4;
                end

                s4: begin
                    state <= s0;
                    done  <= 1'b1;                 

                    frame_err  <= frame_error_now;
                    parity_err <= parity_error_now;

                    if (!frame_error_now && !parity_error_now) begin
                        case (command_reg)
                            2'b00: begin            
                                A      <= data_reg;
                                result <= data_reg;
                            end
                            2'b01: begin             
                                B      <= data_reg;
                                result <= data_reg;
                            end
                            2'b10: begin             
                                result <= A + B;       
                            end
                            2'b11: begin            
                                A      <= 8'd0;
                                B      <= 8'd0;
                                result <= 8'd0;
                            end
                        endcase
                    end else begin
                        result <= 8'd0;              
                    end
                end

                default: state <= s0;
            endcase
        end
    end

endmodule
