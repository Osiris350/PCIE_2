module memoria(
	clk,
	rst,
	wr_enb,
	wr_addr,
	data_in,
	rd_enb,
	rd_addr,
	data_out
	);

	parameter RAM_WIDTH = 10;
	parameter RAM_DEPTH = 8;
	parameter ADDR_SIZE = 3;

	input clk,rst,wr_enb,rd_enb;
	input [RAM_WIDTH-1:0] data_in;
	input [ADDR_SIZE-1:0] rd_addr, wr_addr;
	output reg [RAM_WIDTH-1:0] data_out;

	reg [RAM_WIDTH-1:0]mem[RAM_DEPTH-1:0];
	integer i;

	always @(posedge clk)begin
		if (~rst)begin
			for (i=0; i<RAM_DEPTH; i=i+1)
				mem[i] <= 0;
		end
		else begin
			if (wr_enb) begin
				mem[wr_addr] <= data_in;
			end else begin
				mem[wr_addr] <= 0;
			end/*
			if (rd_enb)begin
				data_out <= mem[rd_addr];
			end else begin
				data_out <= 0;
			end*/
		end
	end

	always @(*)begin
		if (rst == 0) begin 
			data_out <= 0;
		end else begin
			if (rd_enb)begin
				data_out <= mem[rd_addr];
			end else begin
				data_out <= 0;
			end
		end
	end
endmodule
