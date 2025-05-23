# NSF Includes: FPGA Frogger
A crossy road inspired LED matrix game made with a Basys 3 board and Verilog.

## How to use (simulation)
### Software:
- 8bitworkshop.com

### Implementation:
Download crossy_simulation.v and upload it onto 8bitworkshop.com. You can then see the waveforms corresponding to the rows, user position and game end state.

### Demo Video:
https://github.com/user-attachments/assets/7e3c1582-4c90-49c1-a447-e8cfb49a8bc7

## How to use (hardware)
### Equipment/Hardware:
- Basys board
- 9 LEDs
- 9 470 Ohm resistors

### Software:
- Vivado

### Implementation:
Set up the LEDs in a 3x3 grid and connect them in series to the 470 Ohm resistors. Connect them to the corresponding parts of the Basys board as described in the constraints.xdc file. Then, download the vivado files open them on the software to program the basys board and play the game.

### Demo Video:
https://github.com/user-attachments/assets/9a3a6688-ffe3-4ea0-b9c4-fd7f324db8a0

## Credits & Extras
Made by Jimin Lee and Theresa O'Connor for RPI-HVCC Semiconductor Scholars 2025

- Project Presentation: [NSF Includes Verilog Presentation.pdf](https://github.com/user-attachments/files/20416954/NSF.Includes.Verilog.Presentation.pdf)


