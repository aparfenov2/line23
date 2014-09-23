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




  detect_tone   u_detect_tone   (.clk(clk),
                     .reset(reset),
                     .clk_enable(clk_enable),
                     .adc_in(adc_in),
					 
					 .thd_lev_0(16'sd300),
					 .thd_lev_1(16'sd300),
					 .thd_lev_2(16'sd250),
					 .thd_lev_3(16'sd300),
					 .thd_lev_4(16'sd300),
					 .thd_lev_5(16'sd300),
					 .bits_thd_0(16'sd10),
					 .bits_thd_1(16'sd10),
					 .bits_thd_2(16'sd10),
					 .bits_thd_3(16'sd10),
					 .bits_thd_4(16'sd10),
					 .bits_thd_5(16'sd10),
					 
					 .det_out_0(det_out_0),
					 .det_out_1(det_out_1),
					 .det_out_2(det_out_2),
					 .det_out1_0(det_out1_0),
					 .det_out1_1(det_out1_1),
					 .det_out1_2(det_out1_2)
                     );



endmodule  // detect_tone

