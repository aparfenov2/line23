module frame_receiver (
	rxd,
	rxclk,
	frame_begin,
	
	rst,
	clk,
	go,
	busy,
	frame_complete,
	read_addr,
	read_data
);

	parameter frame_length = 16;

	input [7:0] rxd; // received byte from XRT91L31
	input rxclk; // 77.76 MHz / 19.44 MHz - recovered clock from XRT91L31
	input frame_begin; // input from frame detector in XRT91L31

	input rst; // system reset
	input clk; // clock from reader domain
	input go; // request to read 1 frame
	output busy;
	output frame_complete; // frame read ack
// dont do memory read during busy asserted
	input [7:0] read_addr; // address of read val
	output reg [15:0] read_data; // value at addr

// --------------- domain crossovers -----------------------
	wire go_rxclk;
	wire busy_rxclk;
	wire frame_complete_rxclk;
	
	task_cross_domain task_cross_domain1(
        .rst(rst),
		.clkA(clk), 
		.TaskStart_clkA(go), // input
		.TaskBusy_clkA(busy), // output
		.TaskDone_clkA(frame_complete), // output

		.clkB(rxclk),
		.TaskStart_clkB(go_rxclk), // output
		.TaskBusy_clkB(busy_rxclk), // output
		.TaskDone_clkB(frame_complete_rxclk) // input
	);

	reg [7:0] ram[(frame_length - 1):0];
	
// ------------------------- domain rxclk -----------------------------

	reg frame_start_detected;
	always @ (posedge rxclk or posedge rst) begin
		if (rst) begin
			frame_start_detected <= 1'b0;
		end else if (~busy_rxclk) begin
			frame_start_detected <= 1'b0;
		end else if (busy_rxclk & frame_begin) begin
			frame_start_detected <= 1'b1;
		end
	end
	
// byte counter control	
	reg [7:0] byte_counter;
	wire addr_valid = byte_counter < frame_length;
	
	wire write_enable;
	assign write_enable = busy_rxclk & (frame_begin | frame_start_detected) & addr_valid;
	
	always @ (posedge rxclk or posedge rst) begin
		if (rst) begin
			byte_counter <= 8'h00;
		end else if (go_rxclk) begin
			byte_counter <= 8'h00;
		end else if (write_enable) begin
			byte_counter <= byte_counter + 1;
		end
	end
	
	assign frame_complete_rxclk = busy_rxclk & ~addr_valid;

	
	always @ (posedge rxclk) begin
		if (write_enable) begin
			ram[byte_counter] <= rxd;
		end
	end

// ------------------------- domain clk -----------------------------
	
// memory read	
	always @ (posedge clk or posedge rst) begin
        if (rst) begin
            read_data <= 16'h0000;
        end else if ((read_addr << 1) <= (frame_length - 2)) begin
            read_data[15:8] <= ram[(read_addr << 1) + 0];
            read_data[7:0] <= ram[(read_addr << 1) + 1];
        end else begin
            read_data <= 16'h0000;
        end
	end
	
endmodule
