`include  "memoria.v"
`include  "memoria_synth.v"
`include "cmos_cells.v"
`include "probador1.v"
`include "probador2.v"

module BancoPrueba;

parameter RAM_WIDTH = 10;
parameter RAM_DEPTH = 8;
parameter ADDR_SIZE = 3;

wire clk,rst,wr_enb,rd_enb;
wire [RAM_WIDTH-1:0] data_in;
wire [ADDR_SIZE-1:0] rd_addr, wr_addr;
wire [RAM_WIDTH-1:0] data_out;


memoria memory(
    //OUTPUTS
    .data_out (data_out),
    //INPUTS
    .data_in (data_in),
    .wr_enb  (wr_enb),
    .rd_enb  (rd_enb),
    .rd_addr (rd_addr),
    .wr_addr (wr_addr),
    .rst    (rst),
    .clk    (clk)
);

probador probador1(
    //OUTPUTS
    .data_in (data_in),
    .wr_enb  (wr_enb),
    .rd_enb  (rd_enb),
    .rd_addr (rd_addr),
    .wr_addr (wr_addr),
    .rst    (rst),
    .clk    (clk),
    //INPUTS
    .data_out (data_out)
);


endmodule