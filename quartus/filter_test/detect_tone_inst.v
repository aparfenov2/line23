module detect_tone_inst
          (
           clk,
           reset,
           clk_enable,
           adc_in,
           det_out_0,
           det_out_1,
           det_out_2,
           det_out1_0,
           det_out1_1,
           det_out1_2
          );


  input   clk;
  input   reset;
  input   clk_enable;
  input   [11:0] adc_in;  // ufix12
  output  det_out_0;  // boolean
  output  det_out_1;  // boolean
  output  det_out_2;  // boolean
  output  det_out1_0;  // boolean
  output  det_out1_1;  // boolean
  output  det_out1_2;  // boolean



  wire   signed [15:0] thd_lev_0;  // int16
  wire   signed [15:0] thd_lev_1;  // int16
  wire   signed [15:0] thd_lev_2;  // int16
  wire   signed [15:0] thd_lev_3;  // int16
  wire   signed [15:0] thd_lev_4;  // int16
  wire   signed [15:0] thd_lev_5;  // int16
  wire   signed [15:0] bits_thd_0;  // int16
  wire   signed [15:0] bits_thd_1;  // int16
  wire   signed [15:0] bits_thd_2;  // int16
  wire   signed [15:0] bits_thd_3;  // int16
  wire   signed [15:0] bits_thd_4;  // int16
  wire   signed [15:0] bits_thd_5;  // int16
  
 assign thd_lev_0 = (16'sd300);
 assign thd_lev_1 = (16'sd300);
 assign thd_lev_2 = (16'sd250);
 assign thd_lev_3 = (16'sd300);
 assign thd_lev_4 = (16'sd300);
 assign thd_lev_5 = (16'sd300);
 assign bits_thd_0 = (16'sd10);
 assign bits_thd_1 = (16'sd10);
 assign bits_thd_2 = (16'sd10);
 assign bits_thd_3 = (16'sd10);
 assign bits_thd_4 = (16'sd10);
 assign bits_thd_5 = (16'sd10);


// -----------------------------  3475 Hz path -------------------------------------------------

wire signed [15:0] audio_cmd;  // int16
  
  f3475   u_f3475   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(audio_cmd)  // int16
                     );
  
	wire signed [15:0] audio_cmd_abs;  // int16
	abs u_abs_cmd (audio_cmd,audio_cmd_abs);

  detect_threshold_detect_threshold   u_detect_threshold_cmd   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(audio_cmd_abs),  // int16
                                                            .thd(thd_lev_0),  // int16
                                                            .bits_thd(bits_thd_0),  // int16
                                                            .bit_out(det_out_0)
                                                            );

	
// -----------------------------  5110 Hz path -------------------------------------------------

wire signed [15:0] audio_clk;  // int16
  
  f5110   u_f5110   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(audio_clk)  // int16
                     );
  
	wire signed [15:0] audio_clk_abs;  // int16
	abs u_abs_clk (audio_clk,audio_clk_abs);

  detect_threshold_detect_threshold   u_detect_threshold_clk   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(audio_clk_abs),  // int16
                                                            .thd(thd_lev_1),  // int16
                                                            .bits_thd(bits_thd_1),  // int16
                                                            .bit_out(det_out_1)
                                                            );
  
  
// -----------------------------  7395 Hz path -------------------------------------------------

wire signed [15:0] sync_clk;  // int16
  
  f7395   u_f7395   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(sync_clk)  // int16
                     );
  
	wire signed [15:0] sync_clk_abs;  // int16
	abs u_abs_sync (sync_clk,sync_clk_abs);

  detect_threshold_detect_threshold   u_detect_threshold_sync   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(sync_clk_abs),  // int16
                                                            .thd(thd_lev_2),  // int16
                                                            .bits_thd(bits_thd_2),  // int16
                                                            .bit_out(det_out_2)
                                                            );
  

  
  
  
  
// =============================================================================================
// ==================================== GROUP 2 ================================================  
// =============================================================================================


// -----------------------------  4240 Hz path -------------------------------------------------

wire signed [15:0] audio_cmd2;  // int16
  
  f4240   u_f4240   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(audio_cmd2)  // int16
                     );
  
	wire signed [15:0] audio_cmd_abs2;  // int16
	abs u_abs_cmd2 (audio_cmd2,audio_cmd_abs2);

  detect_threshold_detect_threshold   u_detect_threshold_cmd2   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(audio_cmd_abs2),  // int16
                                                            .thd(thd_lev_3),  // int16
                                                            .bits_thd(bits_thd_3),  // int16
                                                            .bit_out(det_out1_0)
                                                            );

	
// -----------------------------  6205 Hz path -------------------------------------------------

wire signed [15:0] audio_clk2;  // int16
  
  f6205   u_f6205   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(audio_clk2)  // int16
                     );
  
	wire signed [15:0] audio_clk_abs2;  // int16
	abs u_abs_clk2 (audio_clk2,audio_clk_abs2);

  detect_threshold_detect_threshold   u_detect_threshold_clk2   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(audio_clk_abs2),  // int16
                                                            .thd(thd_lev_4),  // int16
                                                            .bits_thd(bits_thd_4),  // int16
                                                            .bit_out(det_out1_1)
                                                            );
  
  
// -----------------------------  8900 Hz path -------------------------------------------------

wire signed [15:0] sync_clk2;  // int16
  
  f8900   u_f8900   (.clk(clk),
                     .reset(reset),
                     .enb(clk_enable),
                     .Input_rsvd(adc_in),  // ufix12
                     .Output_rsvd(sync_clk2)  // int16
                     );
  
	wire signed [15:0] sync_clk_abs2;  // int16
	abs u_abs_sync2 (sync_clk2,sync_clk_abs2);

  detect_threshold_detect_threshold   u_detect_threshold_sync2   (.clk(clk),
                                                            .reset(reset),
                                                            .enb(clk_enable),
                                                            .abs_in(sync_clk_abs2),  // int16
                                                            .thd(thd_lev_5),  // int16
                                                            .bits_thd(bits_thd_5),  // int16
                                                            .bit_out(det_out1_2)
                                                            );
  

endmodule  // detect_tone

