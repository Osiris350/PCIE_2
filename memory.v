module memoria #(
	parameter RAM_DEPTH = 256,
	parameter RAM_WIDTH = 8,
    parameter ADDER_SIZE = 8) 
    (   
    input clk, reset, wr_enb, rd_enb;
	input  [RAM_WIDTH-1:0] data_in;
	input [ADDER_SIZE-1:0] rd_addr, wr_addr;
    output reg [RAM_WIDTH-1:0] data_out;
    );

    reg [RAM_WIDTH-1:0] memory [RAM_DEPTH-1:0];
    integer = i;

    always @(posedge clk)
        begin
            if (~reset)
            begin
                for(i=0; i < RAM_DEPTH; i = i+1)
                    men[i] <= 0;
                data_out <= 0;
            end
            else
            begin
                if (wr_enb)
                    men[wr_addr] <= data_in;
                if (rd_enb)
                    data_out <= mem[rd_addr];
            end
        end
endmodule;