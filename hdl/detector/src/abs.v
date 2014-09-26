module abs(in,out);

	input  signed [15:0] in;
	output signed [15:0] out;

	wire signed [16:0] Abs1_y;  // sfix17
	
  assign Abs1_y = (in < 16'sb0000000000000000 ?  - ({in[15], in}) :
              {in[15], in});
				  
  assign out = Abs1_y[15:0];
endmodule
