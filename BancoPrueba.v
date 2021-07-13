`include  "transactionLayer.v"
`include  "transactionLayer_synth.v"
`include  "probador.v"

module BancoPrueba;

parameter MEM_SIZE = 8;      //Tamano de memoria (Cantidad de entradas)
parameter WORD_SIZE = 10;    //Cantidad de bits
parameter PTR_L = 3;    //Longitud de bits para el puntero
parameter FIFO_UNITS = 4;    //Cantidad de fifos por banco de fifos

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			active_out, active_out_s;		// From layer1 of transactionLayer.v
wire			clk;			// From probador1 of probador.v
wire [4:0]		data_out_contador, data_out_contador_s;	// From layer1 of transactionLayer.v
wire			fifo1_almost_empty, fifo1_almost_empty_s;	// From layer1 of transactionLayer.v
wire			fifo1_almost_full, fifo1_almost_full_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo1_data_in;		// From probador1 of probador.v
wire			fifo1_error, fifo1_error_s;		// From layer1 of transactionLayer.v
wire			fifo1_full, fifo1_full_s;		// From layer1 of transactionLayer.v
wire			fifo1_wr;		// From probador1 of probador.v
wire			fifo2_almost_empty, fifo2_almost_empty_s;	// From layer1 of transactionLayer.v
wire			fifo2_almost_full, fifo2_almost_full_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo2_data_in;		// From probador1 of probador.v
wire			fifo2_error, fifo2_error_s;		// From layer1 of transactionLayer.v
wire			fifo2_full, fifo2_full_s;		// From layer1 of transactionLayer.v
wire			fifo2_wr;		// From probador1 of probador.v
wire			fifo3_almost_empty, fifo3_almost_empty_s;	// From layer1 of transactionLayer.v
wire			fifo3_almost_full, fifo3_almost_full_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo3_data_in;		// From probador1 of probador.v
wire			fifo3_error, fifo3_error_s;		// From layer1 of transactionLayer.v
wire			fifo3_full, fifo3_full_s;		// From layer1 of transactionLayer.v
wire			fifo3_wr;		// From probador1 of probador.v
wire			fifo4_almost_empty, fifo4_almost_empty_s;	// From layer1 of transactionLayer.v
wire			fifo4_almost_full, fifo4_almost_full_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo4_data_in;		// From probador1 of probador.v
wire			fifo4_error, fifo4_error_s;		// From layer1 of transactionLayer.v
wire			fifo4_full, fifo4_full_s;		// From layer1 of transactionLayer.v
wire			fifo4_wr;		// From probador1 of probador.v
wire			fifo5_almost_empty, fifo5_almost_empty_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo5_data_out, fifo5_data_out_s;		// From layer1 of transactionLayer.v
wire			fifo5_error, fifo5_error_s;		// From layer1 of transactionLayer.v
wire			fifo5_full, fifo5_full_s;		// From layer1 of transactionLayer.v
wire			fifo5_rd;		// From probador1 of probador.v
wire			fifo6_almost_empty, fifo6_almost_empty_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo6_data_out, fifo6_data_out_s;		// From layer1 of transactionLayer.v
wire			fifo6_error, fifo6_error_s;		// From layer1 of transactionLayer.v
wire			fifo6_full, fifo6_full_s;		// From layer1 of transactionLayer.v
wire			fifo6_rd;		// From probador1 of probador.v
wire			fifo7_almost_empty, fifo7_almost_empty_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo7_data_out, fifo7_data_out_s;		// From layer1 of transactionLayer.v
wire			fifo7_error, fifo7_error_s;		// From layer1 of transactionLayer.v
wire			fifo7_full, fifo7_full_s;		// From layer1 of transactionLayer.v
wire			fifo7_rd;		// From probador1 of probador.v
wire			fifo8_almost_empty, fifo8_almost_empty_s;	// From layer1 of transactionLayer.v
wire [WORD_SIZE-1:0]	fifo8_data_out, fifo8_data_out_s;		// From layer1 of transactionLayer.v
wire			fifo8_error, fifo8_error_s;		// From layer1 of transactionLayer.v
wire			fifo8_full, fifo8_full_s;		// From layer1 of transactionLayer.v
wire			fifo8_rd;		// From probador1 of probador.v
wire [1:0]		idx;			// From probador1 of probador.v
wire			init;			// From probador1 of probador.v
wire			req;			// From probador1 of probador.v
wire			reset_L;		// From probador1 of probador.v
wire [PTR_L-1:0]	umbral_IN_H;		// From probador1 of probador.v
wire [PTR_L-1:0]	umbral_IN_L;		// From probador1 of probador.v
wire			valids, valids_s;			// From layer1 of transactionLayer.v
// End of automatics

transactionLayer layer1(/*AUTOINST*/
			// Outputs
			.fifo5_data_out	(fifo5_data_out[WORD_SIZE-1:0]),
			.fifo6_data_out	(fifo6_data_out[WORD_SIZE-1:0]),
			.fifo7_data_out	(fifo7_data_out[WORD_SIZE-1:0]),
			.fifo8_data_out	(fifo8_data_out[WORD_SIZE-1:0]),
			.fifo1_error	(fifo1_error),
			.fifo2_error	(fifo2_error),
			.fifo3_error	(fifo3_error),
			.fifo4_error	(fifo4_error),
			.fifo5_error	(fifo5_error),
			.fifo6_error	(fifo6_error),
			.fifo7_error	(fifo7_error),
			.fifo8_error	(fifo8_error),
			.fifo1_almost_empty(fifo1_almost_empty),
			.fifo2_almost_empty(fifo2_almost_empty),
			.fifo3_almost_empty(fifo3_almost_empty),
			.fifo4_almost_empty(fifo4_almost_empty),
			.fifo5_almost_empty(fifo5_almost_empty),
			.fifo6_almost_empty(fifo6_almost_empty),
			.fifo7_almost_empty(fifo7_almost_empty),
			.fifo8_almost_empty(fifo8_almost_empty),
			.fifo1_almost_full(fifo1_almost_full),
			.fifo2_almost_full(fifo2_almost_full),
			.fifo3_almost_full(fifo3_almost_full),
			.fifo4_almost_full(fifo4_almost_full),
			.fifo1_full	(fifo1_full),
			.fifo2_full	(fifo2_full),
			.fifo3_full	(fifo3_full),
			.fifo4_full	(fifo4_full),
			.fifo5_full	(fifo5_full),
			.fifo6_full	(fifo6_full),
			.fifo7_full	(fifo7_full),
			.fifo8_full	(fifo8_full),
			.data_out_contador(data_out_contador[4:0]),
			.valids		(valids),
			.active_out	(active_out),
			// Inputs
			.umbral_IN_H	(umbral_IN_H[PTR_L-1:0]),
			.umbral_IN_L	(umbral_IN_L[PTR_L-1:0]),
			.fifo1_data_in	(fifo1_data_in[WORD_SIZE-1:0]),
			.fifo2_data_in	(fifo2_data_in[WORD_SIZE-1:0]),
			.fifo3_data_in	(fifo3_data_in[WORD_SIZE-1:0]),
			.fifo4_data_in	(fifo4_data_in[WORD_SIZE-1:0]),
			.clk		(clk),
			.reset_L	(reset_L),
			.fifo1_wr	(fifo1_wr),
			.fifo2_wr	(fifo2_wr),
			.fifo3_wr	(fifo3_wr),
			.fifo4_wr	(fifo4_wr),
			.fifo5_rd	(fifo5_rd),
			.fifo6_rd	(fifo6_rd),
			.fifo7_rd	(fifo7_rd),
			.fifo8_rd	(fifo8_rd),
			.req		(req),
			.idx		(idx[1:0]),
			.init		(init));

transactionLayer_synth layer2(/*AUTOINST*/
			// Outputs
			.fifo5_data_out	(fifo5_data_out_s[WORD_SIZE-1:0]),
			.fifo6_data_out	(fifo6_data_out_s[WORD_SIZE-1:0]),
			.fifo7_data_out	(fifo7_data_out_s[WORD_SIZE-1:0]),
			.fifo8_data_out	(fifo8_data_out_s[WORD_SIZE-1:0]),
			.fifo1_error	(fifo1_error_s),
			.fifo2_error	(fifo2_error_s),
			.fifo3_error	(fifo3_error_s),
			.fifo4_error	(fifo4_error_s),
			.fifo5_error	(fifo5_error_s),
			.fifo6_error	(fifo6_error_s),
			.fifo7_error	(fifo7_error_s),
			.fifo8_error	(fifo8_error_s),
			.fifo1_almost_empty(fifo1_almost_empty_s),
			.fifo2_almost_empty(fifo2_almost_empty_s),
			.fifo3_almost_empty(fifo3_almost_empty_s),
			.fifo4_almost_empty(fifo4_almost_empty_s),
			.fifo5_almost_empty(fifo5_almost_empty_s),
			.fifo6_almost_empty(fifo6_almost_empty_s),
			.fifo7_almost_empty(fifo7_almost_empty_s),
			.fifo8_almost_empty(fifo8_almost_empty_s),
			.fifo1_almost_full(fifo1_almost_full_s),
			.fifo2_almost_full(fifo2_almost_full_s),
			.fifo3_almost_full(fifo3_almost_full_s),
			.fifo4_almost_full(fifo4_almost_full_s),
			.fifo1_full	(fifo1_full_s),
			.fifo2_full	(fifo2_full_s),
			.fifo3_full	(fifo3_full_s),
			.fifo4_full	(fifo4_full_s),
			.fifo5_full	(fifo5_full_s),
			.fifo6_full	(fifo6_full_s),
			.fifo7_full	(fifo7_full_s),
			.fifo8_full	(fifo8_full_s),
			.data_out_contador_synth (data_out_contador_s[4:0]),
			.valids		(valids_s),
			.active_out	(active_out_s),
			// Inputs
			.umbral_IN_H	(umbral_IN_H[PTR_L-1:0]),
			.umbral_IN_L	(umbral_IN_L[PTR_L-1:0]),
			.fifo1_data_in	(fifo1_data_in[WORD_SIZE-1:0]),
			.fifo2_data_in	(fifo2_data_in[WORD_SIZE-1:0]),
			.fifo3_data_in	(fifo3_data_in[WORD_SIZE-1:0]),
			.fifo4_data_in	(fifo4_data_in[WORD_SIZE-1:0]),
			.clk		(clk),
			.reset_L	(reset_L),
			.fifo1_wr	(fifo1_wr),
			.fifo2_wr	(fifo2_wr),
			.fifo3_wr	(fifo3_wr),
			.fifo4_wr	(fifo4_wr),
			.fifo5_rd	(fifo5_rd),
			.fifo6_rd	(fifo6_rd),
			.fifo7_rd	(fifo7_rd),
			.fifo8_rd	(fifo8_rd),
			.req		(req),
			.idx		(idx[1:0]),
			.init		(init));

probador probador1(
    /*AUTOINST*/
		   // Outputs
		   .umbral_IN_H		(umbral_IN_H[PTR_L-1:0]),
		   .umbral_IN_L		(umbral_IN_L[PTR_L-1:0]),
		   .fifo1_data_in	(fifo1_data_in[WORD_SIZE-1:0]),
		   .fifo2_data_in	(fifo2_data_in[WORD_SIZE-1:0]),
		   .fifo3_data_in	(fifo3_data_in[WORD_SIZE-1:0]),
		   .fifo4_data_in	(fifo4_data_in[WORD_SIZE-1:0]),
		   .clk			(clk),
		   .reset_L		(reset_L),
		   .fifo1_wr		(fifo1_wr),
		   .fifo2_wr		(fifo2_wr),
		   .fifo3_wr		(fifo3_wr),
		   .fifo4_wr		(fifo4_wr),
		   .fifo5_rd		(fifo5_rd),
		   .fifo6_rd		(fifo6_rd),
		   .fifo7_rd		(fifo7_rd),
		   .fifo8_rd		(fifo8_rd),
		   .req			(req),
		   .idx			(idx[1:0]),
		   .init		(init),
		   // Inputs
		   .fifo5_data_out	(fifo5_data_out[WORD_SIZE-1:0]),
		   .fifo6_data_out	(fifo6_data_out[WORD_SIZE-1:0]),
		   .fifo7_data_out	(fifo7_data_out[WORD_SIZE-1:0]),
		   .fifo8_data_out	(fifo8_data_out[WORD_SIZE-1:0]),
		   .fifo1_error		(fifo1_error),
		   .fifo2_error		(fifo2_error),
		   .fifo3_error		(fifo3_error),
		   .fifo4_error		(fifo4_error),
		   .fifo5_error		(fifo5_error),
		   .fifo6_error		(fifo6_error),
		   .fifo7_error		(fifo7_error),
		   .fifo8_error		(fifo8_error),
		   .fifo1_almost_empty	(fifo1_almost_empty),
		   .fifo2_almost_empty	(fifo2_almost_empty),
		   .fifo3_almost_empty	(fifo3_almost_empty),
		   .fifo4_almost_empty	(fifo4_almost_empty),
		   .fifo5_almost_empty	(fifo5_almost_empty),
		   .fifo6_almost_empty	(fifo6_almost_empty),
		   .fifo7_almost_empty	(fifo7_almost_empty),
		   .fifo8_almost_empty	(fifo8_almost_empty),
		   .fifo1_almost_full	(fifo1_almost_full),
		   .fifo2_almost_full	(fifo2_almost_full),
		   .fifo3_almost_full	(fifo3_almost_full),
		   .fifo4_almost_full	(fifo4_almost_full),
		   .fifo1_full		(fifo1_full),
		   .fifo2_full		(fifo2_full),
		   .fifo3_full		(fifo3_full),
		   .fifo4_full		(fifo4_full),
		   .fifo5_full		(fifo5_full),
		   .fifo6_full		(fifo6_full),
		   .fifo7_full		(fifo7_full),
		   .fifo8_full		(fifo8_full),
		   .data_out_contador	(data_out_contador[4:0]),
		   .valids		(valids),
		   .active_out		(active_out),
		   .fifo5_data_out_s	(fifo5_data_out_s[WORD_SIZE-1:0]),
		   .fifo6_data_out_s	(fifo6_data_out_s[WORD_SIZE-1:0]),
		   .fifo7_data_out_s	(fifo7_data_out_s[WORD_SIZE-1:0]),
		   .fifo8_data_out_s	(fifo8_data_out_s[WORD_SIZE-1:0]),
		   .fifo1_error_s	(fifo1_error_s),
		   .fifo2_error_s	(fifo2_error_s),
		   .fifo3_error_s	(fifo3_error_s),
		   .fifo4_error_s	(fifo4_error_s),
		   .fifo5_error_s	(fifo5_error_s),
		   .fifo6_error_s	(fifo6_error_s),
		   .fifo7_error_s	(fifo7_error_s),
		   .fifo8_error_s	(fifo8_error_s),
		   .fifo1_almost_empty_s (fifo1_almost_empty_s),
		   .fifo2_almost_empty_s (fifo2_almost_empty_s),
		   .fifo3_almost_empty_s (fifo3_almost_empty_s),
		   .fifo4_almost_empty_s (fifo4_almost_empty_s),
		   .fifo5_almost_empty_s (fifo5_almost_empty_s),
		   .fifo6_almost_empty_s (fifo6_almost_empty_s),
		   .fifo7_almost_empty_s (fifo7_almost_empty_s),
		   .fifo8_almost_empty_s (fifo8_almost_empty_s),
		   .fifo1_almost_full_s (fifo1_almost_full_s),
		   .fifo2_almost_full_s (fifo2_almost_full_s),
		   .fifo3_almost_full_s (fifo3_almost_full_s),
		   .fifo4_almost_full_s (fifo4_almost_full_s),
		   .fifo1_full_s	(fifo1_full_s),
		   .fifo2_full_s	(fifo2_full_s),
		   .fifo3_full_s	(fifo3_full_s),
		   .fifo4_full_s	(fifo4_full_s),
		   .fifo5_full_s	(fifo5_full_s),
		   .fifo6_full_s	(fifo6_full_s),
		   .fifo7_full_s	(fifo7_full_s),
		   .fifo8_full_s	(fifo8_full_s),
		   .data_out_contador_s(data_out_contador_s[4:0]),
		   .valids_s		(valids_s),
		   .active_out_s	(active_out_s)
		   );


endmodule
