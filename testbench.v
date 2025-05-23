`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2025 02:35:43 PM
// Design Name: 
// Module Name: testbench
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

module crossy_tb;

  reg clk = 0;
  reg reset;
  reg btn_left, btn_right, btn_up;
  wire [2:0] row1, row2, row3;

  // Instantiate your design
  crossy_top uut (
    .clk(clk),
    .reset(reset),
    .btn_left(btn_left),
    .btn_right(btn_right),
    .btn_up(btn_up),
    .row1(row1),
    .row2(row2),
    .row3(row3)
  );

  // Clock generation

  always #5 clk = ~clk; // 100 MHz clock

  initial begin
    // Display output when it changes
    $monitor("Time: %0t | pos = %b | row3 = %b", $time, uut.pos, row3);
    reset = 1;
    btn_left = 0;
    btn_right = 0;
    btn_up = 0;
    
    #20;
    reset = 0;
    
    // Simulate button presses
    #10 btn_left = 1;
    #10 btn_left = 0;

    #20 btn_up = 1;
    #10 btn_up = 0;

    #20 btn_right = 1;
    #10 btn_right = 0;

    #100;
    $finish;
  end

endmodule