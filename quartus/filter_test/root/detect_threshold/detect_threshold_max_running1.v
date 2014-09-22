// -------------------------------------------------------------
// 
// File Name: hdlsrc\root\detect_threshold\detect_threshold_max_running1.v
// Created: 2014-09-23 01:54:03
// 
// Generated by MATLAB 8.3 and HDL Coder 3.4
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: detect_threshold_max_running1
// Source Path: detect_threshold/max_running1
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module detect_threshold_max_running1
          (
           in0_0,
           in0_1,
           out0
          );


  input   signed [15:0] in0_0;  // int16
  input   signed [15:0] in0_1;  // int16
  output  signed [15:0] out0;  // int16


  wire signed [15:0] in0 [0:1];  // int16 [2]
  wire signed [15:0] max_running1_stage1_val;  // int16


  assign in0[0] = in0_0;
  assign in0[1] = in0_1;

  // ---- Tree max implementation ----
  // ---- Tree max stage 1 ----
  assign max_running1_stage1_val = (in0[0] >= in0[1] ? in0[0] :
              in0[1]);



  assign out0 = max_running1_stage1_val;

endmodule  // detect_threshold_max_running1

