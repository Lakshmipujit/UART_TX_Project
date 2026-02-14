`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 11:59:45
// Design Name: 
// Module Name: uart_tx
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




module uart_tx #(
    parameter CLK_FREQ  = 100_000_000,  // 100 MHz
    parameter BAUD_RATE = 9600,
    parameter DATA_BITS = 8
)(
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire [DATA_BITS-1:0] tx_data,
    output reg  tx,
    output reg  tx_busy
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    reg [1:0] state;
    reg [31:0] clk_count;
    reg [3:0] bit_index;
    reg [DATA_BITS-1:0] data_reg;

    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1'b1;
            tx_busy   <= 0;
            clk_count <= 0;
            bit_index <= 0;
        end else begin
            case (state)

                IDLE: begin
                    tx <= 1'b1;
                    tx_busy <= 0;
                    clk_count <= 0;
                    bit_index <= 0;

                    if (tx_start) begin
                        tx_busy <= 1;
                        data_reg <= tx_data;
                        state <= START;
                    end
                end

                START: begin
                    tx <= 1'b0;
                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    tx <= data_reg[bit_index];

                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < DATA_BITS-1)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    tx <= 1'b1;
                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule

