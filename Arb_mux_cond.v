module Arb_mux_cond #(
    parameter FIFO_UNITS = 4,   // Cantidad de FIFOs
    parameter WORD_SIZE = 10,   // Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
    )(
    input wire [FIFO_UNITS-1:0] arb_pop,
    input wire [WORD_SIZE-1:0] fifo_data_in0,
    input wire [WORD_SIZE-1:0] fifo_data_in1,
    input wire [WORD_SIZE-1:0] fifo_data_in2,
    input wire [WORD_SIZE-1:0] fifo_data_in3,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond
    );

    reg [WORD_SIZE-1:0] dataIn_aux0, dataIn_aux1, dataIn_aux2, dataIn_aux3;

    always@(*) begin
        if(arb_pop == 4'b0001) begin
            fifo_data_out_cond = fifo_data_in0;  
        end

        else if(arb_pop == 4'b0010) begin
            fifo_data_out_cond = fifo_data_in1;  
        end

        else if(arb_pop == 4'b0100) begin
            fifo_data_out_cond = fifo_data_in2;  
        end

        else if(arb_pop == 4'b1000) begin
            fifo_data_out_cond = fifo_data_in3;  
        end

        else fifo_data_out_cond = 0;
        
        dataIn_aux0 = fifo_data_in0;
        dataIn_aux1 = fifo_data_in1;
        dataIn_aux2 = fifo_data_in2;
        dataIn_aux3 = fifo_data_in3;
    end 
endmodule