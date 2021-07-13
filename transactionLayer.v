`include "fifo.v"
`include "contador.v"
`include "Bloque_mxdx_cond.v"
`include "Arbitro_cond.v"
`include "maquina_est.v"


module transactionLayer 
#(
    parameter MEM_SIZE = 8,      //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 10,    //Cantidad de bits
    parameter PTR_L = 3,         //Longitud de bits para el puntero
    parameter FIFO_UNITS = 4    //Cantidad de fifos por banco de fifos
)
(
    //inputs generales 
    input [PTR_L-1:0] umbral_IN_H,
    input [PTR_L-1:0] umbral_IN_L,
    input [WORD_SIZE-1:0] fifo1_data_in,
    input [WORD_SIZE-1:0] fifo2_data_in,
    input [WORD_SIZE-1:0] fifo3_data_in,
    input [WORD_SIZE-1:0] fifo4_data_in,
    input clk, 
    input reset_L, 
    //Fifos de entrada
        //Fifo #1
    input fifo1_wr,
        //Fifo #2
    input fifo2_wr,
        //Fifo #3
    input fifo3_wr,
        //Fifo #4
    input fifo4_wr,
    //Fifos Salida
        //Fifo #5
    input fifo5_rd,
        //Fifo #6
    input fifo6_rd,
        //Fifo #7
    input fifo7_rd,
        //Fifo #8
    input fifo8_rd,
    //Contadores 
    input req, 
    input [1:0] idx,
    //Maquina
    input init,
    //Fifos Salida
    output [WORD_SIZE-1:0] fifo5_data_out,
    output [WORD_SIZE-1:0] fifo6_data_out,
    output [WORD_SIZE-1:0] fifo7_data_out,
    output [WORD_SIZE-1:0] fifo8_data_out,
    //Errores de los fifos
    output fifo1_error,
    output fifo2_error,
    output fifo3_error,
    output fifo4_error,
    output fifo5_error,
    output fifo6_error,
    output fifo7_error,
    output fifo8_error,
    //almost_emptys
    output fifo1_almost_empty,
    output fifo2_almost_empty,
    output fifo3_almost_empty,
    output fifo4_almost_empty,
    output fifo5_almost_empty,
    output fifo6_almost_empty,
    output fifo7_almost_empty,
    output fifo8_almost_empty,
    //almost fulls
    output fifo1_almost_full,
    output fifo2_almost_full,
    output fifo3_almost_full,
    output fifo4_almost_full,
    //Fulls
    output fifo1_full,
    output fifo2_full,
    output fifo3_full,
    output fifo4_full,
    output fifo5_full,
    output fifo6_full,
    output fifo7_full,
    output fifo8_full,
    //Contadores
    output [4:0] data_out_contador, 
    output valids,
    //Maquina
    output  active_out);

//Wires intermedios 
    //Salidas de los fifos de entrada
        //data out
            wire [WORD_SIZE-1:0] fifo1_data_out;
            wire [WORD_SIZE-1:0] fifo2_data_out;
            wire [WORD_SIZE-1:0] fifo3_data_out;
            wire [WORD_SIZE-1:0] fifo4_data_out;
        //empys
            wire [FIFO_UNITS-1:0] arb_empty;
    //Fifos Salida
        //Data in
            wire [WORD_SIZE-1:0] fifo_data_in1;
            wire [WORD_SIZE-1:0] fifo_data_in2;
            wire [WORD_SIZE-1:0] fifo_data_in3;
            wire [WORD_SIZE-1:0] fifo_data_in4;
        //almost_fulls
            wire [FIFO_UNITS-1:0] arb_almost_full;
        //empys
            wire [FIFO_UNITS-1:0] vacio;
    //Salidas del mux/demux-Arbitro
            wire [WORD_SIZE-1:0] data_aux_cond;
        //POP
            wire [FIFO_UNITS-1:0] arb_pop;
        //PUSH
            wire [FIFO_UNITS-1:0] arb_push;
    //Maquina de estados
        //Umbrales
            wire [PTR_L-1:0] full_threshold;
            wire [PTR_L-1:0] empty_threshold;
        //Estados
            wire idle_out;
//Maquina de estados
    maquina_estados maquina (
        //Ouputs
        .active_out     (active_out),
        .idle_out       (idle_out),
        .umbral_OUT_L   (empty_threshold [PTR_L-1:0]),
        .umbral_OUT_H   (full_threshold [PTR_L-1:0]),
        //Inputs
        .clk         (clk),
        .init        (init),
        .reset_L     (reset_L),
        .umbral_IN_L (umbral_IN_L [PTR_L-1:0]),
        .umbral_IN_H (umbral_IN_H [PTR_L-1:0]),
        .emp_I0      (arb_empty[0]),
        .emp_I1      (arb_empty[1]),
        .emp_I2      (arb_empty[2]),
        .emp_I3      (arb_empty[3]),
        .emp_O0      (vacio[0]),
        .emp_O1      (vacio[1]),
        .emp_O2      (vacio[2]),
        .emp_O3      (vacio[3])
    ); 
//Fifos de entrada
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo1 (
        //Outputs
        .fifo_data_out   (fifo1_data_out[WORD_SIZE-1:0]),
        .error           (fifo1_error),
        .almost_empty    (fifo1_almost_empty),
        .almost_full     (fifo1_almost_full),
        .fifo_full       (fifo1_full),
        .fifo_empty      (arb_empty[0]),
        //Inputs
        .fifo_wr         (fifo1_wr),
        .fifo_rd         (arb_pop[0]),
        .fifo_data_in    (fifo1_data_in[WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo2 (
        //Outputs
        .fifo_data_out   (fifo2_data_out[WORD_SIZE-1:0]),
        .error           (fifo2_error),
        .almost_empty    (fifo2_almost_empty),
        .almost_full     (fifo2_almost_full),
        .fifo_full       (fifo2_full),
        .fifo_empty      (arb_empty[1]),
        //inputs
        .fifo_wr         (fifo2_wr),
        .fifo_rd         (arb_pop[1]),
        .fifo_data_in    (fifo2_data_in[WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo3 (
        //Outputs
        .fifo_data_out   (fifo3_data_out[WORD_SIZE-1:0]),
        .error           (fifo3_error),
        .almost_empty    (fifo3_almost_empty),
        .almost_full     (fifo3_almost_full),
        .fifo_full       (fifo3_full),
        .fifo_empty      (arb_empty[2]),
        //inputs
        .fifo_wr         (fifo3_wr),
        .fifo_rd         (arb_pop[2]),
        .fifo_data_in    (fifo3_data_in[WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo4 (
        //Outputs
        .fifo_data_out   (fifo4_data_out[WORD_SIZE-1:0]),
        .error           (fifo4_error),
        .almost_empty    (fifo4_almost_empty),
        .almost_full     (fifo4_almost_full),
        .fifo_full       (fifo4_full),
        .fifo_empty      (arb_empty[3]),
        //inputs
        .fifo_wr         (fifo4_wr),
        .fifo_rd         (arb_pop[3]),
        .fifo_data_in    (fifo4_data_in[WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
// MISC y Arbitro
    Bloque_mxdx_cond  mxdx (
        //Outputs
        .fifo_data_out_cond0 (fifo_data_in1 [WORD_SIZE-1:0]),
        .fifo_data_out_cond1 (fifo_data_in2 [WORD_SIZE-1:0]),
        .fifo_data_out_cond2 (fifo_data_in3 [WORD_SIZE-1:0]),
        .fifo_data_out_cond3 (fifo_data_in4 [WORD_SIZE-1:0]),
        .data_aux_cond (data_aux_cond [WORD_SIZE-1:0]),
        //Inputs
        .arb_pop  (arb_pop [FIFO_UNITS-1:0]),
        .arb_push (arb_push [FIFO_UNITS-1:0]),
        .fifo_data_in0 (fifo1_data_out [WORD_SIZE-1:0]),
        .fifo_data_in1 (fifo2_data_out [WORD_SIZE-1:0]),
        .fifo_data_in2 (fifo3_data_out [WORD_SIZE-1:0]),
        .fifo_data_in3 (fifo4_data_out [WORD_SIZE-1:0])
    );
    Arbitro_cond #(.FIFO_UNITS (FIFO_UNITS)) arbitro (
        //Outputs
        .arb_pop_cond    (arb_pop [FIFO_UNITS-1:0]),
        .arb_push_cond   (arb_push [FIFO_UNITS-1:0]),
        .demux_data_out (data_aux_cond [WORD_SIZE-1:0]),
        //Inputs
        .clk             (clk),
        .reset           (reset_L),
        .arb_empty       (arb_empty[FIFO_UNITS-1:0]),
        .arb_almost_full (arb_almost_full[FIFO_UNITS-1:0])
    );
//Fifos Salida
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo5 (
        //Outputs
        .fifo_data_out   (fifo5_data_out[WORD_SIZE-1:0]),
        .error           (fifo5_error),
        .almost_empty    (fifo5_almost_empty),
        .almost_full     (arb_almost_full[0]),
        .fifo_full       (fifo5_full),
        .fifo_empty      (vacio[0]), //Maquina
        //inputs
        .fifo_wr         (arb_push[0]),
        .fifo_rd         (fifo5_rd),
        .fifo_data_in    (fifo_data_in1 [WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo6 (
        //Outputs
        .fifo_data_out   (fifo6_data_out[WORD_SIZE-1:0]),
        .error           (fifo6_error),
        .almost_empty    (fifo6_almost_empty),
        .almost_full     (arb_almost_full[1]),
        .fifo_full       (fifo6_full),
        .fifo_empty      (vacio[1]),
        //inputs
        .fifo_wr         (arb_push[1]),
        .fifo_rd         (fifo6_rd),
        .fifo_data_in    (fifo_data_in2 [WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo7 (
        //Outputs
        .fifo_data_out   (fifo7_data_out[WORD_SIZE-1:0]),
        .error           (fifo7_error),
        .almost_empty    (fifo7_almost_empty),
        .almost_full     (arb_almost_full[2]),
        .fifo_full       (fifo7_full),
        .fifo_empty      (vacio[2]), //Maquina
        //inputs
        .fifo_wr         (arb_push[2]),
        .fifo_rd         (fifo7_rd),
        .fifo_data_in    (fifo_data_in3 [WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]), 
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
    fifo #(.MEM_SIZE (MEM_SIZE)) fifo8 (
        //Outputs
        .fifo_data_out   (fifo8_data_out[WORD_SIZE-1:0]),
        .error           (fifo8_error),
        .almost_empty    (fifo8_almost_empty),
        .almost_full     (arb_almost_full[3]),
        .fifo_full       (fifo8_full),
        .fifo_empty      (vacio[3]), //Maquina
        //inputs
        .fifo_wr         (arb_push[3]),
        .fifo_rd         (fifo8_rd),
        .fifo_data_in    (fifo_data_in4 [WORD_SIZE-1:0]),
        .full_threshold  (full_threshold[PTR_L-1:0]),  //Maquina
        .empty_threshold (empty_threshold[PTR_L-1:0]),
        .clk             (clk),
        .reset_L         (reset_L)
    );
//Contadores
    contador_cond contador1 (
        //Outputs
        .data_out (data_out_contador),
        .valids   (valids),
        //inputs
        .POP_0    (fifo5_rd),
        .POP_1    (fifo6_rd),
        .POP_2    (fifo7_rd),
        .POP_3    (fifo8_rd),
        .IDLE     (idle_out), //Maquina
        .req      (req),
        .idx      (idx),
        .reset_L  (reset_L),
        .clk      (clk)
    );
endmodule