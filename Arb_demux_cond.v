module Arb_demux_cond #(
    parameter FIFO_UNITS = 4,   // Cantidad de FIFOs
    parameter WORD_SIZE = 10,   // Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
    )(
    input wire [FIFO_UNITS-1:0] arb_push,
    input wire [WORD_SIZE-1:0] fifo_data_in,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond0,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond1,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond2,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond3
    );

    reg [WORD_SIZE-1:0] dataOut_aux0, dataOut_aux1, dataOut_aux2, dataOut_aux3;

    always @(*) begin
        if(fifo_data_in[9:8]== 2'b00) begin
            fifo_data_out_cond0 = fifo_data_in;  
            fifo_data_out_cond1 = 0;
            fifo_data_out_cond2 = 0;
            fifo_data_out_cond3 = 0;      
        end

        else if(fifo_data_in[9:8]== 2'b01) begin
            fifo_data_out_cond0 = 0;    
            fifo_data_out_cond1 = fifo_data_in;
            fifo_data_out_cond2 = 0;
            fifo_data_out_cond3 = 0;          
        end

        else if(fifo_data_in[9:8]== 2'b10) begin
            fifo_data_out_cond0 = 0;    
            fifo_data_out_cond1 = 0;    
            fifo_data_out_cond2 = fifo_data_in;  
            fifo_data_out_cond3 = 0;    
        end

        else begin
            fifo_data_out_cond0 = 0; 
            fifo_data_out_cond1 = 0; 
            fifo_data_out_cond2 = 0;          
            fifo_data_out_cond3 = fifo_data_in;  
        end

        dataOut_aux0 = fifo_data_out_cond0;
        dataOut_aux1 = fifo_data_out_cond1;
        dataOut_aux2 = fifo_data_out_cond2;
        dataOut_aux3 = fifo_data_out_cond3;
    end

endmodule