module probador #( 
    parameter MEM_SIZE = 8,      //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 10,    //Cantidad de bits
    parameter PTR_L = 3,         //Longitud de bits para el puntero
    parameter FIFO_UNITS = 4    //Cantidad de fifos por banco de fifos
    )
    (
	//Fifos Salida
    input [WORD_SIZE-1:0] fifo5_data_out,
    input [WORD_SIZE-1:0] fifo6_data_out,
    input [WORD_SIZE-1:0] fifo7_data_out,
    input [WORD_SIZE-1:0] fifo8_data_out,
    input [WORD_SIZE-1:0] fifo5_data_out_s,
    input [WORD_SIZE-1:0] fifo6_data_out_s,
    input [WORD_SIZE-1:0] fifo7_data_out_s,
    input [WORD_SIZE-1:0] fifo8_data_out_s,
    //Errores de los fifos
    input fifo1_error,
    input fifo2_error,
    input fifo3_error,
    input fifo4_error,
    input fifo5_error,
    input fifo6_error,
    input fifo7_error,
    input fifo8_error,
    input fifo1_error_s,
    input fifo2_error_s,
    input fifo3_error_s,
    input fifo4_error_s,
    input fifo5_error_s,
    input fifo6_error_s,
    input fifo7_error_s,
    input fifo8_error_s,
    //almost_emptys
    input fifo1_almost_empty,
    input fifo2_almost_empty,
    input fifo3_almost_empty,
    input fifo4_almost_empty,
    input fifo5_almost_empty,
    input fifo6_almost_empty,
    input fifo7_almost_empty,
    input fifo8_almost_empty,
    input fifo1_almost_empty_s,
    input fifo2_almost_empty_s,
    input fifo3_almost_empty_s,
    input fifo4_almost_empty_s,
    input fifo5_almost_empty_s,
    input fifo6_almost_empty_s,
    input fifo7_almost_empty_s,
    input fifo8_almost_empty_s,
    //almost fulls
    input fifo1_almost_full,
    input fifo2_almost_full,
    input fifo3_almost_full,
    input fifo4_almost_full,
    input fifo1_almost_full_s,
    input fifo2_almost_full_s,
    input fifo3_almost_full_s,
    input fifo4_almost_full_s,
    //Fulls
    input fifo1_full,
    input fifo2_full,
    input fifo3_full,
    input fifo4_full,
    input fifo5_full,
    input fifo6_full,
    input fifo7_full,
    input fifo8_full,
    input fifo1_full_s,
    input fifo2_full_s,
    input fifo3_full_s,
    input fifo4_full_s,
    input fifo5_full_s,
    input fifo6_full_s,
    input fifo7_full_s,
    input fifo8_full_s,
    //Contadores
    input [4:0] data_out_contador, 
    input valids,
    input [4:0] data_out_contador_s, 
    input valids_s,
    //Maquina
    input  active_out,
    input  active_out_s,
    //outputs generales 
    output reg [PTR_L-1:0] umbral_IN_H,
    output reg [PTR_L-1:0] umbral_IN_L,
    output reg [WORD_SIZE-1:0] fifo1_data_in,
    output reg [WORD_SIZE-1:0] fifo2_data_in,
    output reg [WORD_SIZE-1:0] fifo3_data_in,
    output reg [WORD_SIZE-1:0] fifo4_data_in,
    output reg clk, 
    output reg reset_L, 
    //Fifos de entrada
        //Fifo #1
    output reg fifo1_wr,
        //Fifo #2
    output reg fifo2_wr,
        //Fifo #3
    output reg fifo3_wr,
        //Fifo #4
    output reg fifo4_wr,
    //Fifos Salida
        //Fifo #5
    output reg fifo5_rd,
        //Fifo #6
    output reg fifo6_rd,
        //Fifo #7
    output reg fifo7_rd,
        //Fifo #8
    output reg fifo8_rd,
    //Contadores 
    output reg req, 
    output reg [1:0] idx,
    //Maquina
    output reg init
    );

    reg Q;

    initial begin
        $dumpfile("layer.vcd");
        $dumpvars;
        
        umbral_IN_L = 3;
        umbral_IN_H = 5;
        fifo1_data_in = 'b0;
        fifo2_data_in = 'b0;
        fifo3_data_in = 'b0;
        fifo4_data_in = 'b0;
        reset_L = 0;
        req = 0;
        idx = 0;
        init = 0;

        //Fifos de entrada
        //Fifo #1
        fifo1_wr = 0;
        //Fifo #2
        fifo2_wr = 0;
        //Fifo #3
        fifo3_wr = 0;
        //Fifo #4
        fifo4_wr = 0;
    //Fifos Salida
        //Fifo #5
        fifo5_rd = 0;
        //Fifo #6
        fifo6_rd = 0;
        //Fifo #7
        fifo7_rd = 0;
        //Fifo #8
        fifo8_rd = 0;

        repeat (2) begin 
            @(posedge clk)
            reset_L <= 0;
        end
        @(posedge clk)
        reset_L <= 1;
        // PUNTO #1 de las pruebas
        @(posedge clk)
        init <=1;
        //PUNTO #2 de las pruebas
        @(posedge clk)
        umbral_IN_L = 1;
        umbral_IN_H = 7;
        @(posedge clk)
        umbral_IN_L = 2;
        umbral_IN_H = 6;
        @(posedge clk)
        init <=0;
        //Sale del init
        //Prueba #3 provocando almost full en fifos de salida
        //Llenando fifos de entrada
        @(posedge clk)
            fifo1_wr <=1;
            fifo2_wr <=1;
            fifo3_wr <=1;
            fifo4_wr <=1;
            fifo1_data_in <= 'hFF;
            fifo2_data_in <= 'h01FF;
            fifo3_data_in <= 'h02FF;
            fifo4_data_in <= 'h03FF;
        @(posedge clk)
            fifo1_data_in <= 'hEE;
            fifo2_data_in <= 'h01EE;
            fifo3_data_in <= 'h02EE;
            fifo4_data_in <= 'h03EE;
        @(posedge clk)
            fifo1_data_in <= 'hDD;
            fifo2_data_in <= 'h01DD;
            fifo3_data_in <= 'h02DD;
            fifo4_data_in <= 'h03DD;
        @(posedge clk)
            fifo1_data_in <= 'hCC;
            fifo2_data_in <= 'h01CC;
            fifo3_data_in <= 'h02CC;
            fifo4_data_in <= 'h03CC;
        @(posedge clk)
            fifo1_data_in <= 'hBB;
            fifo2_data_in <= 'h01BB;
            fifo3_data_in <= 'h02BB;
            fifo4_data_in <= 'h03BB;
        @(posedge clk)
            fifo1_data_in <= 'hAA;
            fifo2_data_in <= 'h01AA;
            fifo3_data_in <= 'h02AA;
            fifo4_data_in <= 'h03AA;
        @(posedge clk)
            fifo1_data_in <= 'h00;
            fifo2_data_in <= 'h00;
            fifo3_data_in <= 'h00;
            fifo4_data_in <= 'h00;
            fifo1_wr <=0;
            fifo2_wr <=0;
            fifo3_wr <=0;
            fifo4_wr <=0;
        @(posedge clk)
            fifo1_wr <=0;
            fifo5_rd <=1;
        @(posedge clk)
            fifo5_rd <=0;
        // Hay que esperar 6 ciclos para que se llene el fifo 
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo6_rd <=1;
        @(posedge clk)
            fifo6_rd <=0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo7_rd <=1;
        @(posedge clk)
            fifo7_rd <=0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)


        // Prueba siguiente: Llenar los FIFOS de entrada (provocar almost full en fifos de entrada)


        // Llenar fifos 1,2,3 y 4 de entrada:
        @(posedge clk)
        fifo1_wr <= 1;
        fifo2_wr <= 1;
        fifo3_wr <= 1;
        fifo4_wr <= 1;
        fifo1_data_in <= 'hFF;
        fifo2_data_in <= 'h01FF;
        fifo3_data_in <= 'h02FF;
        fifo4_data_in <= 'h03FF;
        @(posedge clk)
        fifo1_data_in <= 'hEE;
        fifo2_data_in <= 'h01EE;
        fifo3_data_in <= 'h02EE;
        fifo4_data_in <= 'h03EE;
        @(posedge clk)
        fifo1_data_in <= 'hDD;
        fifo2_data_in <= 'h01DD;
        fifo3_data_in <= 'h02DD;
        fifo4_data_in <= 'h03DD;
        @(posedge clk)
        fifo1_data_in <= 'hCC;
        fifo2_data_in <= 'h01CC;
        fifo3_data_in <= 'h02CC;
        fifo4_data_in <= 'h03CC;
        @(posedge clk)
        fifo1_data_in <= 'hBB;
        fifo2_data_in <= 'h01BB;
        fifo3_data_in <= 'h02BB;
        fifo4_data_in <= 'h03BB;
        @(posedge clk)
        fifo1_data_in <= 'hAA;
        fifo2_data_in <= 'h01AA;
        fifo3_data_in <= 'h02AA;
        fifo4_data_in <= 'h03AA;
        @(posedge clk)
        fifo1_wr <= 0;
        fifo2_wr <= 0;
        fifo3_wr <= 0;
        fifo4_wr <= 0;
        fifo8_rd <=1;
        //Dejando los fifos vacios 

        @(posedge clk)
            fifo5_rd <=1;
            //fifo6_rd <=1;
            //fifo7_rd <=1;
            fifo8_rd <=0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo5_rd <=0;
        @(posedge clk)
            fifo6_rd <=1;
            //fifo6_rd <=1;
            //fifo7_rd <=1;
            //fifo8_rd <=1;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo6_rd <=0;
        @(posedge clk)
            fifo7_rd <=1;
            //fifo6_rd <=1;
            //fifo7_rd <=1;
            //fifo8_rd <=1;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo7_rd <=0;
        @(posedge clk)
            fifo8_rd <=1;
            //fifo6_rd <=1;
            //fifo7_rd <=1;
            //fifo8_rd <=1;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
            fifo8_rd <=0;
        // Ya estan vacios
        //Punto #5 de la prueba (Ver los contadores)    
        @(posedge clk)
            req = 1;
            idx = 0;
        @(posedge clk)
            idx = 1;
        @(posedge clk)
            idx = 2;
        @(posedge clk)
            idx = 3;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)

        //Prueba #6 4x4
        // Llenar fifos 1,2,3 y 4 de entrada:
        @(posedge clk)
        fifo1_wr = 1;
        fifo2_wr = 1;
        fifo3_wr = 1;
        fifo4_wr = 1;
        fifo1_data_in = 'hFF;
        fifo2_data_in = 'hFF;
        fifo3_data_in = 'hFF;
        fifo4_data_in = 'hFF;
        @(posedge clk)
        fifo1_data_in = 'h01EE;
        fifo2_data_in = 'h01EE;
        fifo3_data_in = 'h01EE;
        fifo4_data_in = 'h01EE;
        @(posedge clk)
        fifo1_data_in = 'h02DD;
        fifo2_data_in = 'h02DD;
        fifo3_data_in = 'h02DD;
        fifo4_data_in = 'h02DD;
        @(posedge clk)
        fifo1_data_in = 'h03CC;
        fifo2_data_in = 'h03CC;
        fifo3_data_in = 'h03CC;
        fifo4_data_in = 'h03CC;

        @(posedge clk)
        fifo1_wr = 0;
        fifo2_wr = 0;
        fifo3_wr = 0;
        fifo4_wr = 0;

        repeat (20) begin
            @(posedge clk);
        end
        // Vaciando todos los fifos
        repeat (20) begin
            @(posedge clk);
        end

        @(posedge clk)
        fifo5_rd = 0;
        fifo6_rd = 0;

        repeat (4) begin
            @(posedge clk);
        end
        fifo5_rd = 0;
        fifo6_rd = 0;

        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)

        @(posedge clk)
        fifo7_rd = 0;
        fifo8_rd = 0;

        repeat (4) begin
            @(posedge clk);
        end
        fifo5_rd = 1;
        fifo6_rd = 1;
        fifo7_rd = 1;
        fifo8_rd = 1;

        repeat (3) begin
            @(posedge clk);
        end
        @(posedge clk);
        fifo5_rd = 0;
        fifo6_rd = 0;
        fifo7_rd = 0;
        fifo8_rd = 0;

        @(posedge clk)
        @(posedge clk)
        @(posedge clk)

        // Leer los contadores de palabras:
        @(posedge clk);
        req = 1;
        idx = 00;
        @(posedge clk);
        req = 1;
        idx = 01;
        @(posedge clk);
        req = 1;
        idx = 10;
        @(posedge clk);
        req = 1;
        idx = 11;
        $finish;    
    end

    initial clk <= 1;
    always #1 clk <= ~clk; 
endmodule