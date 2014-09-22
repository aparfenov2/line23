// -------------------------------------------------------------
// 
// File Name: hdlsrc\root\f4240.v
// Created: 2014-09-23 01:54:05
// 
// Generated by MATLAB 8.3 and HDL Coder 3.4
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: f4240
// Source Path: root/detect_tone/f4240
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module f4240
          (
           clk,
           reset,
           enb,
           Input_rsvd,
           Output_rsvd
          );


  input   clk;
  input   reset;
  input   enb;
  input   [11:0] Input_rsvd;  // ufix12
  output  signed [15:0] Output_rsvd;  // int16


  wire signed [15:0] ConvertIn_out1;  // int16
  wire signed [31:0] s_1_mul_temp;  // sfix32_En20
  wire signed [15:0] s_1_out1;  // int16
  reg signed [15:0] Delay11_out1;  // int16
  reg signed [15:0] Delay21_out1;  // int16
  wire signed [31:0] a_3_1_out1;  // sfix32_En14
  wire signed [15:0] CastState1_out1;  // int16
  wire signed [31:0] a_2_1_out1;  // sfix32_En14
  wire signed [33:0] SumA21_sub_cast;  // sfix34_En14
  wire signed [33:0] SumA21_sub_cast_1;  // sfix34_En14
  wire signed [33:0] SumA21_out1;  // sfix34_En14
  wire signed [34:0] SumA31_sub_cast;  // sfix35_En14
  wire signed [33:0] SumA31_sub_cast_1;  // sfix34_En14
  wire signed [34:0] SumA31_sub_cast_2;  // sfix35_En14
  wire signed [34:0] SumA31_sub_temp;  // sfix35_En14
  wire signed [33:0] SumA31_out1;  // sfix34_En14
  wire signed [31:0] b_2_1_out1;  // sfix32_En14
  wire signed [33:0] SumB21_add_cast;  // sfix34_En14
  wire signed [33:0] SumB21_add_cast_1;  // sfix34_En14
  wire signed [33:0] SumB21_out1;  // sfix34_En14
  wire signed [34:0] SumB31_add_cast;  // sfix35_En14
  wire signed [33:0] SumB31_add_cast_1;  // sfix34_En14
  wire signed [34:0] SumB31_add_cast_2;  // sfix35_En14
  wire signed [34:0] SumB31_add_temp;  // sfix35_En14
  wire signed [33:0] SumB31_out1;  // sfix34_En14
  wire signed [15:0] CastStageIn2_out1;  // int16
  wire signed [31:0] s_2_mul_temp;  // sfix32_En20
  wire signed [15:0] s_2_out1;  // int16
  reg signed [15:0] Delay12_out1;  // int16
  reg signed [15:0] Delay22_out1;  // int16
  wire signed [31:0] a_3_2_out1;  // sfix32_En14
  wire signed [15:0] CastState2_out1;  // int16
  wire signed [31:0] a_2_2_out1;  // sfix32_En14
  wire signed [33:0] SumA22_sub_cast;  // sfix34_En14
  wire signed [33:0] SumA22_sub_cast_1;  // sfix34_En14
  wire signed [33:0] SumA22_out1;  // sfix34_En14
  wire signed [34:0] SumA32_sub_cast;  // sfix35_En14
  wire signed [33:0] SumA32_sub_cast_1;  // sfix34_En14
  wire signed [34:0] SumA32_sub_cast_2;  // sfix35_En14
  wire signed [34:0] SumA32_sub_temp;  // sfix35_En14
  wire signed [33:0] SumA32_out1;  // sfix34_En14
  wire signed [31:0] b_2_2_out1;  // sfix32_En14
  wire signed [33:0] SumB22_add_cast;  // sfix34_En14
  wire signed [33:0] SumB22_add_cast_1;  // sfix34_En14
  wire signed [33:0] SumB22_out1;  // sfix34_En14
  wire signed [34:0] SumB32_add_cast;  // sfix35_En14
  wire signed [33:0] SumB32_add_cast_1;  // sfix34_En14
  wire signed [34:0] SumB32_add_cast_2;  // sfix35_En14
  wire signed [34:0] SumB32_add_temp;  // sfix35_En14
  wire signed [33:0] SumB32_out1;  // sfix34_En14
  wire signed [15:0] ConvertOut_out1;  // int16


  assign ConvertIn_out1 = Input_rsvd;



  assign s_1_mul_temp = 30601 * ConvertIn_out1;
  assign s_1_out1 = ({{4{s_1_mul_temp[31]}}, s_1_mul_temp[31:20]}) + $signed({1'b0, s_1_mul_temp[19] & (s_1_mul_temp[20] | (|s_1_mul_temp[18:0]))});



  always @(posedge clk or posedge reset)
    begin : Delay21_process
      if (reset == 1'b1) begin
        Delay21_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay21_out1 <= Delay11_out1;
        end
      end
    end



  assign a_3_1_out1 = 15866 * Delay21_out1;



  always @(posedge clk or posedge reset)
    begin : Delay11_process
      if (reset == 1'b1) begin
        Delay11_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay11_out1 <= CastState1_out1;
        end
      end
    end



  assign a_2_1_out1 = -26986 * Delay11_out1;



  assign SumA21_sub_cast = {{4{s_1_out1[15]}}, {s_1_out1, 14'b00000000000000}};
  assign SumA21_sub_cast_1 = {{2{a_2_1_out1[31]}}, a_2_1_out1};
  assign SumA21_out1 = SumA21_sub_cast - SumA21_sub_cast_1;



  assign SumA31_sub_cast = {SumA21_out1[33], SumA21_out1};
  assign SumA31_sub_cast_1 = {{2{a_3_1_out1[31]}}, a_3_1_out1};
  assign SumA31_sub_cast_2 = {SumA31_sub_cast_1[33], SumA31_sub_cast_1};
  assign SumA31_sub_temp = SumA31_sub_cast - SumA31_sub_cast_2;
  assign SumA31_out1 = ((SumA31_sub_temp[34] == 1'b0) && (SumA31_sub_temp[33] != 1'b0) ? 34'sh1FFFFFFFF :
              ((SumA31_sub_temp[34] == 1'b1) && (SumA31_sub_temp[33] != 1'b1) ? 34'sh200000000 :
              $signed(SumA31_sub_temp[33:0])));



  assign CastState1_out1 = (((SumA31_out1[33] == 1'b0) && (SumA31_out1[32:29] != 4'b0000)) || ((SumA31_out1[33] == 1'b0) && (SumA31_out1[29:14] == 16'sb0111111111111111)) ? 16'sb0111111111111111 :
              ((SumA31_out1[33] == 1'b1) && (SumA31_out1[32:29] != 4'b1111) ? 16'sb1000000000000000 :
              SumA31_out1[29:14] + $signed({1'b0, SumA31_out1[13] & (SumA31_out1[14] | (|SumA31_out1[12:0]))})));



  assign b_2_1_out1 = 26378 * Delay11_out1;



  assign SumB21_add_cast = {{4{CastState1_out1[15]}}, {CastState1_out1, 14'b00000000000000}};
  assign SumB21_add_cast_1 = {{2{b_2_1_out1[31]}}, b_2_1_out1};
  assign SumB21_out1 = SumB21_add_cast + SumB21_add_cast_1;



  assign SumB31_add_cast = {SumB21_out1[33], SumB21_out1};
  assign SumB31_add_cast_1 = {{4{Delay21_out1[15]}}, {Delay21_out1, 14'b00000000000000}};
  assign SumB31_add_cast_2 = {SumB31_add_cast_1[33], SumB31_add_cast_1};
  assign SumB31_add_temp = SumB31_add_cast + SumB31_add_cast_2;
  assign SumB31_out1 = ((SumB31_add_temp[34] == 1'b0) && (SumB31_add_temp[33] != 1'b0) ? 34'sh1FFFFFFFF :
              ((SumB31_add_temp[34] == 1'b1) && (SumB31_add_temp[33] != 1'b1) ? 34'sh200000000 :
              $signed(SumB31_add_temp[33:0])));



  assign CastStageIn2_out1 = (((SumB31_out1[33] == 1'b0) && (SumB31_out1[32:29] != 4'b0000)) || ((SumB31_out1[33] == 1'b0) && (SumB31_out1[29:14] == 16'sb0111111111111111)) ? 16'sb0111111111111111 :
              ((SumB31_out1[33] == 1'b1) && (SumB31_out1[32:29] != 4'b1111) ? 16'sb1000000000000000 :
              SumB31_out1[29:14] + $signed({1'b0, SumB31_out1[13] & (SumB31_out1[14] | (|SumB31_out1[12:0]))})));



  assign s_2_mul_temp = 30601 * CastStageIn2_out1;
  assign s_2_out1 = ({{4{s_2_mul_temp[31]}}, s_2_mul_temp[31:20]}) + $signed({1'b0, s_2_mul_temp[19] & (s_2_mul_temp[20] | (|s_2_mul_temp[18:0]))});



  always @(posedge clk or posedge reset)
    begin : Delay22_process
      if (reset == 1'b1) begin
        Delay22_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay22_out1 <= Delay12_out1;
        end
      end
    end



  assign a_3_2_out1 = 15906 * Delay22_out1;



  always @(posedge clk or posedge reset)
    begin : Delay12_process
      if (reset == 1'b1) begin
        Delay12_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay12_out1 <= CastState2_out1;
        end
      end
    end



  assign a_2_2_out1 = -27876 * Delay12_out1;



  assign SumA22_sub_cast = {{4{s_2_out1[15]}}, {s_2_out1, 14'b00000000000000}};
  assign SumA22_sub_cast_1 = {{2{a_2_2_out1[31]}}, a_2_2_out1};
  assign SumA22_out1 = SumA22_sub_cast - SumA22_sub_cast_1;



  assign SumA32_sub_cast = {SumA22_out1[33], SumA22_out1};
  assign SumA32_sub_cast_1 = {{2{a_3_2_out1[31]}}, a_3_2_out1};
  assign SumA32_sub_cast_2 = {SumA32_sub_cast_1[33], SumA32_sub_cast_1};
  assign SumA32_sub_temp = SumA32_sub_cast - SumA32_sub_cast_2;
  assign SumA32_out1 = ((SumA32_sub_temp[34] == 1'b0) && (SumA32_sub_temp[33] != 1'b0) ? 34'sh1FFFFFFFF :
              ((SumA32_sub_temp[34] == 1'b1) && (SumA32_sub_temp[33] != 1'b1) ? 34'sh200000000 :
              $signed(SumA32_sub_temp[33:0])));



  assign CastState2_out1 = (((SumA32_out1[33] == 1'b0) && (SumA32_out1[32:29] != 4'b0000)) || ((SumA32_out1[33] == 1'b0) && (SumA32_out1[29:14] == 16'sb0111111111111111)) ? 16'sb0111111111111111 :
              ((SumA32_out1[33] == 1'b1) && (SumA32_out1[32:29] != 4'b1111) ? 16'sb1000000000000000 :
              SumA32_out1[29:14] + $signed({1'b0, SumA32_out1[13] & (SumA32_out1[14] | (|SumA32_out1[12:0]))})));



  assign b_2_2_out1 = -32722 * Delay12_out1;



  assign SumB22_add_cast = {{4{CastState2_out1[15]}}, {CastState2_out1, 14'b00000000000000}};
  assign SumB22_add_cast_1 = {{2{b_2_2_out1[31]}}, b_2_2_out1};
  assign SumB22_out1 = SumB22_add_cast + SumB22_add_cast_1;



  assign SumB32_add_cast = {SumB22_out1[33], SumB22_out1};
  assign SumB32_add_cast_1 = {{4{Delay22_out1[15]}}, {Delay22_out1, 14'b00000000000000}};
  assign SumB32_add_cast_2 = {SumB32_add_cast_1[33], SumB32_add_cast_1};
  assign SumB32_add_temp = SumB32_add_cast + SumB32_add_cast_2;
  assign SumB32_out1 = ((SumB32_add_temp[34] == 1'b0) && (SumB32_add_temp[33] != 1'b0) ? 34'sh1FFFFFFFF :
              ((SumB32_add_temp[34] == 1'b1) && (SumB32_add_temp[33] != 1'b1) ? 34'sh200000000 :
              $signed(SumB32_add_temp[33:0])));



  assign ConvertOut_out1 = (((SumB32_out1[33] == 1'b0) && (SumB32_out1[32:29] != 4'b0000)) || ((SumB32_out1[33] == 1'b0) && (SumB32_out1[29:14] == 16'sb0111111111111111)) ? 16'sb0111111111111111 :
              ((SumB32_out1[33] == 1'b1) && (SumB32_out1[32:29] != 4'b1111) ? 16'sb1000000000000000 :
              SumB32_out1[29:14] + $signed({1'b0, SumB32_out1[13] & (SumB32_out1[14] | (|SumB32_out1[12:0]))})));



  assign Output_rsvd = ConvertOut_out1;

endmodule  // f4240

