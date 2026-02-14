`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 12:01:12
// Design Name: 
// Module Name: uart_tx_tb
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



module uart_tx_tb;

    parameter CLK_FREQ = 10_000_000;
    parameter BAUD_RATE = 9600;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;

    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    always #50 clk = ~clk;  // 10 MHz clock

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'hA5;

        #200 rst = 0;

        @(posedge clk);
        tx_start = 1;

        @(posedge clk);
        tx_start = 0;

        wait(tx_busy == 0);

        $display("Transmission Completed");
        #1000;
        $finish;
    end

endmodule

