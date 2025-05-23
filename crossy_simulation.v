module crossy(clk, reset, btn_left, btn_right, btn_up, row1, row2, row3, row4, row5);
  //inputs - clock & buttons to move user position
  input clk, reset;
  input btn_left;
  input btn_right;
  input btn_up;
  
  //current position
  reg [4:0] pos;
  
  //new row generation  
  int new_row_num = 0;
  reg [4:0] new_row [0:19];
  initial begin
      new_row[0]  = 5'b10001;
      new_row[1]  = 5'b01001;
      new_row[2]  = 5'b10000;
      new_row[3]  = 5'b00000;
      new_row[4]  = 5'b01000;
      new_row[5]  = 5'b01010;
      new_row[6]  = 5'b00101;
      new_row[7]  = 5'b10000;
      new_row[8]  = 5'b01010;
      new_row[9]  = 5'b01000;
      new_row[10] = 5'b01000;
      new_row[11] = 5'b00000;
      new_row[12] = 5'b00011;
      new_row[13] = 5'b10000;
      new_row[14] = 5'b01010;
      new_row[15] = 5'b00110;
      new_row[16] = 5'b00101;
      new_row[17] = 5'b01000;
      new_row[18] = 5'b10000;
      new_row[19] = 5'b00110;
  end

  //button press
  reg [2:0] btn_timer;
  reg btn_active;
  
  //collision variables
  wire collision;
  assign collision = |(pos & row4);
  
  //game end
  reg game_end = 0;
  
  //LED outputs
  output reg [4:0] row1;
  output reg [4:0] row2;
  output reg [4:0] row3;
  output reg [4:0] row4;
  output reg [4:0] row5;
  
  always @(posedge clk) begin
    if (reset) begin
      //clear all rows
      row1 <= 5'b01000;
      row2 <= 5'b00000;
      row3 <= 5'b00000;
      row4 <= 5'b00000;
      row5 <= 5'b00100;
      
      //starting position to 1
      pos <= 5'b00100;
      
      //reset game_end
      game_end <= 0;
    end else begin
      if (!game_end) begin
        //button timer increment
        if (btn_timer > 0) begin
          btn_timer <= btn_timer-1;

          //reset button timer to 0
          if (btn_timer == 1) begin
            btn_active <= 0;
            btn_timer <= 0;
          end
        end

        //only if no other button is active
        if (!btn_active) begin
          // When btn_left is pressed, move user one spot to the left and move the rows one down
          if (btn_left) begin                    
            //move user position to the left
            if (pos == 5'b10000) begin
              pos <= 5'b00001;
            end else begin
              pos <= pos << 1;
            end

            // Check row4 and next position, end game if collision
            if (collision == 1) begin
                game_end <= 1;
            end

            if(!game_end) begin
              //Shift rows down otherwise
              row5 <= row4 | pos; //row5 should light up row4 and pos
              row4 <= row3;
              row3 <= row2;
              row2 <= row1;

              //generate new row to input into row1
              row1 <= new_row[new_row_num];
              if (new_row_num == 19) begin
                new_row_num <= 0;
              end else begin
                new_row_num <= new_row_num+1;
              end

              //reset button timer and set button active
              btn_timer <= 5;
              btn_active <= 1;
            end
          end

          // When btn_right is pressed, move user one spot to the right and move the rows one down
          if (btn_right) begin
            //reset button timer and set button active
            btn_timer <= 5;
            btn_active <= 1;

            //move user position to the right
            if (pos == 5'b00001) begin
              pos <= 5'b10000;
            end else begin
              pos <= pos >> 1;
            end

            // Check row4 and next position, end game if collision
            if (collision == 1) begin
                game_end <= 1;
            end

            if(!game_end) begin
              //Shift rows down otherwise
              row5 <= row4 | pos;
              row4 <= row3;
              row3 <= row2;
              row2 <= row1;

              //generate new row to input into row1
              row1 <= new_row[new_row_num];
              if (new_row_num == 19) begin
                new_row_num <= 0;
              end else begin
                new_row_num <= new_row_num+1;
              end
            end
          end
          
          //when btn_up is pressed, user stays and rows shift down
          if (btn_up) begin
            //reset button timer and set button active
            btn_timer <= 5;
            btn_active <= 1;
            
            // Check row4 and next position, end game if collision
            if (collision == 1) begin
                game_end <= 1;
            end
            
            if(!game_end) begin
              //Shift rows down otherwise
              row5 <= row4 | pos;
              row4 <= row3;
              row3 <= row2;
              row2 <= row1;

              //generate new row to input into row1
              row1 <= new_row[new_row_num];
              if (new_row_num == 19) begin
                new_row_num <= 0;
              end else begin
                new_row_num <= new_row_num+1;
              end
            end
          end
        end
      end
    end
      
  end

endmodule
