// -------------------------------------------------------------
// 
// File Name: hdlsrc\root\detect_threshold\detect_threshold_detect_threshold.v
// Created: 2014-09-23 18:43:42
// 
// Generated by MATLAB 8.3 and HDL Coder 3.4
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: detect_threshold_detect_threshold
// Source Path: detect_threshold
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module detect_threshold_detect_threshold
          (
           clk,
           reset,
           enb,
           abs_in,
           thd,
           bits_thd,
           bit_out
          );


  input   clk;
  input   reset;
  input   enb;
  input   signed [15:0] abs_in;  // int16
  input   signed [15:0] thd;  // int16
  input   signed [15:0] bits_thd;  // int16
  output  bit_out;


  wire [7:0] Bit_Slice_out1;  // uint8
  wire [7:0] sum1b_out1;  // uint8
  wire [7:0] Bit_Slice1_out1;  // uint8
  wire [7:0] sum1b1_out1;  // uint8
  wire [7:0] Bit_Slice2_out1;  // uint8
  wire [7:0] sum1b2_out1;  // uint8
  wire [7:0] Bit_Slice3_out1;  // uint8
  wire [7:0] sum1b3_out1;  // uint8
  wire cmp4_relop1;
  wire [31:0] conv1_out1;  // uint32
  wire [31:0] Sum_out1;  // uint32
  reg [31:0] Unit_Delay_out1;  // uint32
  wire [31:0] Bit_Shift_out1;  // uint32
  wire [7:0] Sum1_add_temp;  // ufix8
  wire [7:0] Sum1_add_temp_1;  // ufix8
  wire [7:0] Sum1_out1;  // uint8
  wire cmp1_relop1;


  assign cmp4_relop1 = (abs_in >= thd ? 1'b1 :
              1'b0);



  assign conv1_out1 = {31'b0, cmp4_relop1};



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_process
      if (reset == 1'b1) begin
        Unit_Delay_out1 <= 32'b00000000000000000000000000000000;
      end
      else begin
        if (enb) begin
          Unit_Delay_out1 <= Sum_out1;
        end
      end
    end



  assign Bit_Shift_out1 = Unit_Delay_out1 <<< 1;



  assign Sum_out1 = conv1_out1 + Bit_Shift_out1;



  assign Bit_Slice_out1 = Sum_out1[7:0];



  bit_sum8_bit_sum8   u_sum1b   (.In1(Bit_Slice_out1),  // uint8
                                 .Out1(sum1b_out1)  // uint8
                                 );

  assign Bit_Slice1_out1 = Sum_out1[15:8];



  bit_sum8_bit_sum8   u_sum1b1   (.In1(Bit_Slice1_out1),  // uint8
                                  .Out1(sum1b1_out1)  // uint8
                                  );

  assign Bit_Slice2_out1 = Sum_out1[23:16];



  bit_sum8_bit_sum8   u_sum1b2   (.In1(Bit_Slice2_out1),  // uint8
                                  .Out1(sum1b2_out1)  // uint8
                                  );

  assign Bit_Slice3_out1 = Sum_out1[31:24];



  bit_sum8_bit_sum8   u_sum1b3   (.In1(Bit_Slice3_out1),  // uint8
                                  .Out1(sum1b3_out1)  // uint8
                                  );

  assign Sum1_add_temp = sum1b_out1 + sum1b1_out1;
  assign Sum1_add_temp_1 = Sum1_add_temp + sum1b2_out1;
  assign Sum1_out1 = Sum1_add_temp_1 + sum1b3_out1;



  assign cmp1_relop1 = ($signed({1'b0, Sum1_out1}) >= bits_thd ? 1'b1 :
              1'b0);



  assign bit_out = cmp1_relop1;


endmodule  // detect_threshold_detect_threshold

