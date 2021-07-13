`include "write_logic.v"
`include "read_logic.v"
`include "control_logic.v"
`include "memory.v"

module fifo 
#(
    parameter MEM_SIZE = 8,     //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 10,    //Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
)
(
    output reg [WORD_SIZE-1:0] fifo_data_out,
    output error,
    output almost_empty,
    output almost_full,
    output fifo_full,
    output fifo_empty,
    input fifo_wr,
    input fifo_rd,
    input [WORD_SIZE-1:0] fifo_data_in,
    input [PTR_L-1:0] full_threshold,
    input [PTR_L-1:0] empty_threshold,
    input clk,
    input reset_L);

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [WORD_SIZE-1:0]	data_out_MM;		// From memoria of memory.v
wire			pop;			// From read_log of read_logic.v
wire			push;			// From write_log of write_logic.v
wire [PTR_L-1:0]	rd_ptr;			// From read_log of read_logic.v
wire [PTR_L-1:0]	wr_ptr;			// From write_log of write_logic.v
// End of automatics

write_logic #(.MEM_SIZE (MEM_SIZE))write_log(/*AUTOINST*/
					     // Outputs
					     .wr_ptr		(wr_ptr[PTR_L-1:0]),
					     .push		(push),
					     // Inputs
					     .fifo_wr		(fifo_wr),
					     .fifo_rd		(fifo_rd),
					     .fifo_full		(fifo_full),
					     .clk		(clk),
					     .reset_L		(reset_L));

read_logic #(.MEM_SIZE (MEM_SIZE))read_log(/*AUTOINST*/
					   // Outputs
					   .rd_ptr		(rd_ptr[PTR_L-1:0]),
					   .pop			(pop),
					   // Inputs
					   .fifo_rd		(fifo_rd),
					   .fifo_wr		(fifo_wr),
					   .fifo_empty		(fifo_empty),
					   .clk			(clk),
					   .reset_L		(reset_L));

control_logic #(.MEM_SIZE (MEM_SIZE))control_log(/*AUTOINST*/
						 // Outputs
						 .error			(error),
						 .almost_empty		(almost_empty),
						 .almost_full		(almost_full),
						 .fifo_full		(fifo_full),
						 .fifo_empty		(fifo_empty),
						 // Inputs
						 .full_threshold	(full_threshold[PTR_L-1:0]),
						 .empty_threshold	(empty_threshold[PTR_L-1:0]),
						 .fifo_rd		(fifo_rd),
						 .fifo_wr		(fifo_wr),
						 .clk			(clk),
						 .reset_L		(reset_L));

memory #(.MEM_SIZE (MEM_SIZE))memoria(/*AUTOINST*/
				      // Outputs
				      .data_out_MM	(data_out_MM[WORD_SIZE-1:0]),
				      // Inputs
				      .rd_ptr		(rd_ptr[PTR_L-1:0]),
				      .wr_ptr		(wr_ptr[PTR_L-1:0]),
				      .data_in_MM	(data_in_MM[WORD_SIZE-1:0]),
				      .push		(push),
				      .pop		(pop),
				      .reset_L		(reset_L),
				      .clk		(clk));

reg [WORD_SIZE-1:0]    data_in_MM;
always @(*) begin
    data_in_MM<=fifo_data_in;
    fifo_data_out<=data_out_MM;
end


endmodule
