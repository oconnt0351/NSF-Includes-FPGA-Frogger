`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RPI
// Engineer: Jimin Lee and Theresa O'Connor
// 
// Create Date: 05/22/2025 01:14:01 PM
// Design Name: Crossy
// Module Name: crossy_top
// Project Name: NSF Includes Crossy
// Target Devices: Basys 3 FPGA Board
// Tool Versions: 
// Description: 3x3 LED Matrix street crossing game
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module crossy_top(
  input clk,
  input reset,
  input btn_left,
  input btn_right,
  input btn_up,
  output reg [2:0] row1,
  output reg [2:0] row2,
  output reg [2:0] row3
);

  // Current position
  reg [2:0] pos;
  reg [2:0] next_pos;
  reg move;
  reg game_end = 0; // Game end flag

  // New row generation
  reg [2:0] new_row [15:0];
  integer new_row_num = 0;
  
  // Button debouncing/edge check
  reg btn_up_prev;
  reg btn_left_prev;
  reg btn_right_prev;
  wire btn_up_rising = btn_up & ~btn_up_prev;
  wire btn_left_rising = btn_left & ~btn_left_prev;
  wire btn_right_rising = btn_right & ~btn_right_prev;

  initial begin
    pos = 3'b010;
    row1 = 3'b010;
    row2 = 3'b000;
    row3 = pos;
    game_end <= 0;
    new_row_num <= 0;
    move = 0;
    next_pos = 3'b000;
    
    // New row generation hardcoded
    new_row[0] = 3'b100;
    new_row[1] = 3'b010;
    new_row[2] = 3'b010;
    new_row[3] = 3'b001;
    new_row[4] = 3'b010;
    new_row[5] = 3'b001;
    new_row[6] = 3'b100;
    new_row[7] = 3'b100;
    new_row[8] = 3'b110;
    new_row[9] = 3'b011;
    new_row[10] = 3'b001;
    new_row[11] = 3'b101;
    new_row[12] = 3'b110;
    new_row[13] = 3'b001;
    new_row[14] = 3'b101;
    new_row[15] = 3'b110;
  end


  always @(posedge clk) begin
    // Update previous button states
    btn_left_prev <= btn_left;
    btn_right_prev <= btn_right;
    btn_up_prev <= btn_up;
    if (reset) begin
      pos <= 3'b010;
      
      // Reset all rows
      row1 <= 3'b010;
      row2 <= 3'b000;
      row3 <= pos;
      
      // Reset edge detection
      btn_left_prev <= 0;
      btn_right_prev <= 0;
      btn_up_prev <= 0;
      
      // Reset all other variables
      game_end <= 0;
      new_row_num <= 0;
      move = 0;
      next_pos = 3'b000;
    end
    else if (!game_end) begin
      move = 0;
      next_pos = 3'b000; // Clear with each clock

      // Handle left movement
      if (btn_left_rising) begin
        next_pos = (pos == 3'b100) ? 3'b001 : (pos << 1);
        move = 1;
      end
      // Handle right movement
      else if (btn_right_rising) begin
        next_pos = (pos == 3'b001) ? 3'b100 : (pos >> 1);
        move = 1;
      end
      // Handle upwards movement
      else if (btn_up_rising) begin
        next_pos = pos;
        move = 1;
      end
      
      // If a move has been made
      if (move) begin
        move = 0; // Reset

        // Check for collision
        if (|(next_pos & row2)) begin
          game_end <= 1;
          
          // Turn on all LEDs to indicate game over
          row1 <= 3'b111;
          row2 <= 3'b111;
          row3 <= 3'b111;
        end else begin
          pos = next_pos;
          
          // Update rows
          row3 = pos;
          row2 = row1;
          row1 = new_row[new_row_num];
          new_row_num = (new_row_num == 15) ? 0 : new_row_num + 1;
        end // Collision check
      end // If move = 1
    end // !game end
  end // always
endmodule

