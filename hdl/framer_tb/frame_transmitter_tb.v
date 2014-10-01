`timescale 1 ns/ 1 ns
module frame_transmitter_tb();
	wire [7:0] txd;
	reg txclk;

	reg clk;
	reg rst;
	reg go;
	wire busy;
	wire frame_complete;
	reg [7:0] write_addr;
	reg [15:0] write_data;
    reg wren;

	frame_transmitter frame_transmitter_u (
		.txd,
		.txclk(txclk),

		.rst(rst),
		.clk(clk),
		.go(go),
		.busy(busy),
		.frame_complete(frame_complete),
		.write_addr(write_addr),
		.write_data(write_data),
        .wren(wren)
	);
	defparam frame_transmitter_u.frame_length = 4;

	always begin
	// 40 MHz 
	#12  clk =  !clk;
	end

	always begin
	// 77.76 MHz 
	#6  txclk =  !txclk;
	end

// 1a. magic передается ? 0xf6f6f6282828
// 2. данные передаются ?


// domain clk
	initial begin                                                  
		clk = 0;
		rst = 1;
		go = 0;
		write_addr = 8'h0;
        wren = 0;
		$display("Running testbench");

	#10	rst = 0;

// write data
    #24 wren = 1;
        write_addr = 8'h0;
        write_data = 16'h0001;
    #24 write_addr = 8'h1;
        write_data = 16'habcd;
    #24 wren = 0;
        go = 1;
    #24 go = 0;
    #48 if (~busy) $display("busy not set");

	end

// domain txclk
	initial begin
        txclk = 0;
	end

endmodule
