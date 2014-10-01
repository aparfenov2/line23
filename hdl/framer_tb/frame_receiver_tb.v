`timescale 1 ns/ 1 ns
module frame_receiver_tb();
	reg [7:0] rxd;
	reg rxclk;	
	reg frame_begin;
	
	reg clk;
	reg rst;
	reg go;
	wire busy;
	wire frame_complete;
	reg [7:0] read_addr;
	wire [15:0] read_data;
	
	frame_receiver frame_receiver_u (
		.rxd,
		.rxclk(rxclk),
		.frame_begin(frame_begin),
		
		.rst(rst),
		.clk(clk),
		.go(go),
		.busy(busy),
		.frame_complete(frame_complete),
		.read_addr(read_addr),
		.read_data(read_data)
	);
	defparam frame_receiver_u.frame_length = 4;

	always begin
	// 40 MHz 
	#12  clk =  !clk;
	end

	always begin
	// 77.76 MHz 
	#6  rxclk =  !rxclk;
	end

// 1. прием фрейма по сигналу go, ожидания frame_impulse, работа счетчика, 
// 1a. magic принимается ? 0xf6f6f6282828
// 2. чтение принятых байт	


// domain clk    
	initial begin                                                  
		clk = 0;
		rst = 1;
		go = 0;
		read_addr = 8'h0;
		$display("Running testbench");
		
	#10	rst = 0;
    #24 go = 1;
    #24 go = 0;
    #48 if (~busy) $display("busy not set");
    
    @(frame_complete);
// read data
    #24 read_addr = 8'h0;
    #24 if (read_data != 16'h0001) $display("at 0: read_data is wrong");
    #24 read_addr = 8'h1;
    #24 if (read_data != 16'habcd) $display("at 1: read_data is wrong");
	end                                                    

// domain rxclk
	initial begin                                                  
		rxd = 0;
		rxclk = 0;
		frame_begin = 0;
    #60
// send magic    
    #12
    #12
    fork
        begin
        #12 rxd = 8'hf6;
        #12 rxd = 8'hf6;
        #12 rxd = 8'hf6;
        #12 rxd = 8'h28;
        #12 rxd = 8'h28;
        #12 rxd = 8'h28;
    // send data
        #12 rxd = 8'h00;
        #12 rxd = 8'h01;
        
        #12 rxd = 8'hab;
        #12 rxd = 8'hcd;
        end
        begin
        #72
        #12 frame_begin = 1;
        #12 frame_begin = 0;
        end
    join
	end                                                    
    
endmodule
