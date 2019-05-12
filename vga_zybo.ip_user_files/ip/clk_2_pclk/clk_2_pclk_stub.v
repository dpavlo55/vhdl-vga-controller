// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat May 11 12:08:12 2019
// Host        : YOGA-520 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/VHDL/zybo/vga_zybo/vga_zybo.srcs/sources_1/ip/clk_2_pclk/clk_2_pclk_stub.v
// Design      : clk_2_pclk
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_2_pclk(pclk, reset, locked, clk)
/* synthesis syn_black_box black_box_pad_pin="pclk,reset,locked,clk" */;
  output pclk;
  input reset;
  output locked;
  input clk;
endmodule
