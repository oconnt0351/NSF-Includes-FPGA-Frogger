## Clock input
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## Reset button (BTNC)
set_property PACKAGE_PIN U17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Button inputs
set_property PACKAGE_PIN T18 [get_ports btn_up]
set_property IOSTANDARD LVCMOS33 [get_ports btn_up]

set_property PACKAGE_PIN W19 [get_ports btn_left]
set_property IOSTANDARD LVCMOS33 [get_ports btn_left]

set_property PACKAGE_PIN T17 [get_ports btn_right]
set_property IOSTANDARD LVCMOS33 [get_ports btn_right]

## LED Matrix Outputs (3x3) using PMOD JA
## row1[2:0] - connected to JA1, JA2, JA3
set_property PACKAGE_PIN J1 [get_ports {row1[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row1[2]}]

set_property PACKAGE_PIN L2 [get_ports {row1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row1[1]}]

set_property PACKAGE_PIN J2 [get_ports {row1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row1[0]}]

## row2[2:0] - connected to JA4, JA7, JA8
set_property PACKAGE_PIN G2 [get_ports {row2[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row2[2]}]

set_property PACKAGE_PIN G3 [get_ports {row2[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row2[1]}]

set_property PACKAGE_PIN H2 [get_ports {row2[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row2[0]}]

## row3[2:0] - connected to JA9, JA10, JA11
set_property PACKAGE_PIN K2 [get_ports {row3[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row3[2]}]

set_property PACKAGE_PIN H1 [get_ports {row3[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row3[1]}]

set_property PACKAGE_PIN B16 [get_ports {row3[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row3[0]}]
