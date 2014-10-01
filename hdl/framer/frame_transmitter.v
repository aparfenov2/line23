module frame_transmitter (
	txd,
	txclk,
	
	go,
    busy,
	frame_complete,	
	rst,
	clk,
	write_addr,
	write_data,
	wren
);

    parameter frame_length = 16;

	output reg [7:0] txd; // out byte to XRT91L31
	input txclk; // 77.76 MHz / 19.44 MHz from XRT91L31

	input go; // begin frame transmission
    output busy;
	output frame_complete; // end frame transmission flag === idle
	input rst; // system reset
	input clk; // clock from reader domain

	// no memory writes allowed during active frame transission phase
	input [7:0] write_addr; // address of val to write at
	input [15:0] write_data; // value at addr
	input wren; // write memory enable

// --------------- domain crossovers -----------------------
	wire go_txclk;
	wire busy_txclk;
	wire frame_complete_txclk;
	
	task_cross_domain task_cross_domain1(
        .rst(rst),
		.clkA(clk), 
		.TaskStart_clkA(go), // input
		.TaskBusy_clkA(busy), // output
		.TaskDone_clkA(frame_complete), // output

		.clkB(txclk),
		.TaskStart_clkB(go_txclk), // output
		.TaskBusy_clkB(busy_txclk), // output
		.TaskDone_clkB(frame_complete_txclk) // input
	);
    
	reg [7:0] ram[(frame_length-1):0];

// ------------------------- domain txclk ---------------------------
    reg [7:0] state;
    reg [7:0] byte_offset;
    
`define ST_IDLE 8'h00
`define ST_MAGIC 8'h01
`define ST_DATA 8'h02
`define MAGIC_LENGTH 6

    wire [7:0] magic_data[(`MAGIC_LENGTH-1):0];
    assign magic_data[5] = 8'hf6;
    assign magic_data[4] = 8'hf6;
    assign magic_data[3] = 8'hf6;
    assign magic_data[2] = 8'h28;
    assign magic_data[1] = 8'h28;
    assign magic_data[0] = 8'h28;
    
    assign frame_complete_txclk = (state == `ST_DATA & byte_offset >= frame_length);

    always @ (posedge txclk or posedge rst) begin
        if (rst) begin
            state <= `ST_IDLE;
            byte_offset <= 8'h00;
            txd <= 8'h00;
        end else if (state == `ST_IDLE) begin
            if (go_txclk) begin
                state <= `ST_MAGIC;
                byte_offset <= `MAGIC_LENGTH - 2;
                txd <= magic_data[`MAGIC_LENGTH - 1];
            end
        end else if (state == `ST_MAGIC) begin
            if (byte_offset == 0) begin
                state <= `ST_DATA;
                byte_offset <= 8'h00;
                txd <= magic_data[byte_offset];
            end else begin
                txd <= magic_data[byte_offset];
                byte_offset <= byte_offset - 1;
            end
        end else if (state == `ST_DATA) begin
            if (byte_offset >= frame_length) begin
                state <= `ST_IDLE;
                txd <= 8'h00;
            end else begin
                txd <= ram[byte_offset];
                byte_offset <= byte_offset + 1;
            end
        end
    end

// ------------------------- domain clk -----------------------------

// memory write
	always @ (posedge clk or posedge rst) begin
        if (wren & ~busy & (write_addr << 1) <= (frame_length-2)) begin
             ram[(write_addr << 1) + 0] <= write_data[15:8];
             ram[(write_addr << 1) + 1] <= write_data[7:0];
        end
	end
    
endmodule
