`include "Arb_mux_cond.v"
`include "Arb_demux_cond.v"

module Bloque_mxdx_cond #(
    parameter FIFO_UNITS = 4,   // Cantidad de FIFOs
    parameter WORD_SIZE = 10,   // Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
    )(
        input wire [FIFO_UNITS-1:0] arb_pop,
        input wire [FIFO_UNITS-1:0] arb_push,
        input wire [WORD_SIZE-1:0] fifo_data_in0,
        input wire [WORD_SIZE-1:0] fifo_data_in1,
        input wire [WORD_SIZE-1:0] fifo_data_in2,
        input wire [WORD_SIZE-1:0] fifo_data_in3,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond0,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond1,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond2,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond3,
        output wire [WORD_SIZE-1:0] data_aux_cond
    );

    Arb_mux_cond mux(/*AUTOINST*/
		     // Outputs
		     .fifo_data_out_cond(data_aux_cond[WORD_SIZE-1:0]),
		     // Inputs
		     .arb_pop		(arb_pop[FIFO_UNITS-1:0]),
		     .fifo_data_in0	(fifo_data_in0[WORD_SIZE-1:0]),
		     .fifo_data_in1	(fifo_data_in1[WORD_SIZE-1:0]),
		     .fifo_data_in2	(fifo_data_in2[WORD_SIZE-1:0]),
		     .fifo_data_in3	(fifo_data_in3[WORD_SIZE-1:0]));

    Arb_demux_cond demux(/*AUTOINST*/
			 // Outputs
			 .fifo_data_out_cond0	(fifo_data_out_cond0[WORD_SIZE-1:0]),
			 .fifo_data_out_cond1	(fifo_data_out_cond1[WORD_SIZE-1:0]),
			 .fifo_data_out_cond2	(fifo_data_out_cond2[WORD_SIZE-1:0]),
			 .fifo_data_out_cond3	(fifo_data_out_cond3[WORD_SIZE-1:0]),
			 // Inputs
			 .arb_push		(arb_push[FIFO_UNITS-1:0]),
			 .fifo_data_in		(data_aux_cond[WORD_SIZE-1:0]));

endmodule