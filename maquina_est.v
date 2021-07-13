module maquina_estados
   (//Input   
    input clk,
    input init,
    input reset_L,
    input [2:0] umbral_IN_L,
    input [2:0] umbral_IN_H,
	input emp_I0,
    input emp_I1,
    input emp_I2,
    input emp_I3,
    input emp_O0,
    input emp_O1,
    input emp_O2,
    input emp_O3,
    //Output
    output reg active_out,
    output reg idle_out,
    output reg [2:0] umbral_OUT_L,
    output reg [2:0] umbral_OUT_H
    );

parameter RESET = 0;
parameter INIT = 1;
parameter IDLE = 2;
parameter ACTIVE = 3;

reg [1:0] estado;
reg [1:0] estado_prox;

reg [2:0] umbral_0 = 3'b000;
reg [2:0] umbral_1 = 3'b000;
/*
wire [2:0] umbral_0;
wire [2:0] umbral_1;
*/
reg [7:0] empty;


always @(posedge clk) begin
    if(!reset_L) begin
        estado <= RESET;
    end
    else begin 
        if (init) begin
        estado <= INIT;
        end
        else begin
            estado <= estado_prox;
        end
    end
    umbral_0 = umbral_IN_L;
    umbral_1 = umbral_IN_H;
end

always @(*) begin
    empty[0] = emp_I0;
    empty[1] = emp_I1;
    empty[2] = emp_I2;
    empty[3] = emp_I3;
    empty[4] = emp_O0;
    empty[5] = emp_O1;
    empty[6] = emp_O2;
    empty[7] = emp_O3;

    case (estado)
        RESET: begin
            idle_out = 0;
            active_out = 0;
            umbral_OUT_L = 0;
            umbral_OUT_H = 0;
            estado_prox = INIT;
        end
        INIT: begin
            idle_out = 0;
            active_out = 0;
            umbral_OUT_L = umbral_IN_L;
            umbral_OUT_H = umbral_IN_H;
            if(init) begin
                estado_prox = INIT;
            end
            else begin
                estado_prox = IDLE;
            end
        end
        IDLE: begin
            idle_out = 1;
            active_out = 0;
            umbral_OUT_L = umbral_0;
            umbral_OUT_H = umbral_1;
            if(empty == 'hFF) begin
                estado_prox = IDLE;
            end
            else begin
                estado_prox = ACTIVE;
            end
        end
        ACTIVE: begin
            idle_out = 0;
            active_out = 1;
            umbral_OUT_L = umbral_0;
            umbral_OUT_H = umbral_1;
            //estado_prox = ACTIVE;
            if(empty == 'hFF) begin
                estado_prox = IDLE;
            end
            else begin
                estado_prox = ACTIVE;
            end
        end
        default: begin
            estado_prox = INIT;
        end
    
    endcase



end

endmodule

