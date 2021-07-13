module write_logic 
#(
    parameter MEM_SIZE = 4,     //Tamano de memoria (Cantidad de entradas)
    parameter WORD_SIZE = 6,    //Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
)
(
    input fifo_wr,
    input fifo_rd, // Se utiliza como senal de control
    input fifo_full,
    input clk,
    input reset_L,
    output reg [PTR_L-1:0] wr_ptr,
    output reg push
);

//Control de la senal push, a partir de la senal de fifo_wr y fifo_full
always @(*) begin
    if (reset_L) begin
        if ((fifo_wr && !fifo_full) || (fifo_rd && fifo_wr)) begin
            push = 1;
        end
        else begin 
            push = 0; //Caso en que esta lleno el fifo y se intenta escribir
        end
    end
    else begin
        push = 0; //Valor inicial
    end
end

//Control del puntero de escritura, a partir de la senal fifo_wr y fifo_full
always @(posedge clk) begin
    if (!reset_L) begin
        wr_ptr <= 0; //Valor inicial
    end 
    else begin
        if ((fifo_wr && !fifo_full) || (fifo_rd && fifo_wr)) begin
            wr_ptr <= wr_ptr + 1;
            if (wr_ptr == MEM_SIZE-1) begin //Control reinicio del puntero al menor valor
                wr_ptr <= 0;
            end
        end
    end
end



endmodule