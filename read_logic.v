module read_logic 
#(
    parameter MEM_SIZE = 8,   //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 10,    //Cantidad de bits
    parameter PTR_L = 3        //Longitud de bits para el puntero
)
(
    input fifo_rd,
    input fifo_wr, // Se utiliza como senal de control
    input fifo_empty,
    input clk,
    input reset_L,
    output reg [PTR_L-1:0] rd_ptr,
    output reg pop
);

//Control de senal de pop, a partir de fifo_rd y fifo_empty
always @(*) begin
    if (reset_L) begin
        if ((fifo_rd && !fifo_empty) || (fifo_rd && fifo_wr)) begin
            pop = 1;
        end
        else begin
            pop = 0; //Caso que el fifo este vacio y se intente leer la memoria
        end
    end
    else begin
        pop=0;
    end
    
end


//Control del puntero del lectura, a partir de fifo_rd y fifo_empty
always @(posedge clk) begin
    if (!reset_L) begin
        rd_ptr <= 0;
    end 
    else begin
        if ((fifo_rd && !fifo_empty) || (fifo_rd && fifo_wr)) begin
            rd_ptr <= rd_ptr + 1;
            if (rd_ptr == MEM_SIZE-1) begin 
                rd_ptr <= 0;
            end
        end 
    end
end

endmodule