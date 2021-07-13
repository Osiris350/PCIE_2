module control_logic 
#(
    parameter MEM_SIZE = 8,   //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 10,   //Cantidad de bits
    parameter PTR_L = 3        //Longitud de bits de las senales que son de tamano igual a la cantidad de entradas de la memoria
)
(
    input [PTR_L-1:0] full_threshold,
    input [PTR_L-1:0] empty_threshold,
    input fifo_rd,
    input fifo_wr,
    input clk,
    input reset_L,
    output reg error,
    output reg almost_empty,
    output reg almost_full,
    output reg fifo_full,
    output reg fifo_empty);

reg [PTR_L-1:0] counter;

always @(*) begin
    if (reset_L) begin
        //Se realiza el control de los umbrales de almost_full, en el caso que hayan mas 
        //datos almacenados en memoria que lo que indica el umbral
        if (counter >= full_threshold) begin
            almost_full <= 1;
        end 
        else begin
            almost_full <= 0;
        end
        //Se realiza el control para el caso que hayan menos datos almacenados en memoria
        //que los indicados por el umbral de vacio
        if (counter <= empty_threshold) begin
            almost_empty <= 1;
        end 
        else begin
            almost_empty <= 0;
        end
    end
    else begin
        almost_empty <= 0;
        almost_full <= 0;
    end
end


always @ (posedge clk) begin
    if (!reset_L) begin
        counter <= 0;
        error <= 0;
    end 
    else begin        
        //En esta etapa se realiza el control del error, asi como del contador que administra 
        //la cantidad de datos almacenados en memoria. Ademas se lleva el control de las senales 
        //de memoria llena o memoria vacia.
        if ((fifo_wr && ~fifo_rd && fifo_full) || (fifo_rd && ~fifo_wr && fifo_empty)) begin
            error <= 1;
        end
        else if (fifo_rd && ~fifo_wr && ~fifo_empty) begin
            counter <= counter - 1;
            error <= 0;
        end
        else if (fifo_wr && ~fifo_rd && ~fifo_full) begin
            counter <= counter + 1;
            error <= 0;
        end
        
    end
end

always @(*) begin
    if (reset_L) begin
        if (counter >= MEM_SIZE) begin
            fifo_full = 1;
        end 
        else begin
            fifo_full = 0;
        end
        if (counter <= 0) begin
            fifo_empty <= 1;
        end
        else begin
            fifo_empty = 0;
        end    
    end
    else begin
        fifo_full <= 0;
        fifo_empty <= 0;
    end


end

endmodule