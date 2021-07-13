module Arbitro_cond #(

    parameter FIFO_UNITS = 4,    // Cantidad de FIFOs
    parameter WORD_SIZE = 10
    )(
    input clk,
    input reset,
    input [WORD_SIZE-1:0] demux_data_out,
    input wire [FIFO_UNITS-1:0] arb_empty,
    input wire [FIFO_UNITS-1:0] arb_almost_full,
    output reg [FIFO_UNITS-1:0] arb_pop_cond,
    output reg [FIFO_UNITS-1:0] arb_push_cond
    );

    reg all_empty;

    integer i=0;
    integer j=0;

    always@(*) begin
        for(i=0; i < FIFO_UNITS; i=i+1) begin
                arb_pop_cond[i] = 1;
                arb_push_cond[i] = 1;
            end
        all_empty = 1;

        if(!reset) begin
            for(i=0; i < FIFO_UNITS; i=i+1) begin
                arb_pop_cond[i] = 0;
                arb_push_cond[i] = 0;
            end
        end

        else if(reset)
            for(i=0; i < FIFO_UNITS-1; i=i+1) begin
                if(arb_empty[i]) begin
                    arb_pop_cond[i] = 0;
                    arb_pop_cond[i+1] = 1;

                    for(j=i+2; j < FIFO_UNITS; j=j+1) begin
                        arb_pop_cond[j] = 0;
                    end
                end
            end

            for(i=0; i < FIFO_UNITS-1; i=i+1) begin
                if(!arb_empty[i]) begin
                    for(j=i+1; j < FIFO_UNITS; j=j+1) begin
                        arb_pop_cond[j] = 0;
                        arb_push_cond[j] = 0;
                    end

                    all_empty = 0;
                end
            end

            if(arb_empty[FIFO_UNITS-1]) begin
                arb_pop_cond[FIFO_UNITS-1] = 0;
            end

            for(i=0; i < FIFO_UNITS; i=i+1) begin
                if(!arb_empty[i]) all_empty = 0;
            end

            if(all_empty) begin
                arb_pop_cond = 0;
                arb_push_cond = 0;
            end

            for(i=0; i < FIFO_UNITS; i=i+1) begin
                if(arb_almost_full[i]) begin
                    arb_pop_cond = 0;
                    arb_push_cond = 0;
                end
            end

            

            if(demux_data_out[9:8] == 2'b00) begin
                arb_push_cond = 4'b0000;
                if (demux_data_out[7:0] != 'b0) arb_push_cond = 4'b0001;
            end
    
            else if(demux_data_out[9:8] == 2'b01) arb_push_cond = 4'b0010;
            else if(demux_data_out[9:8] == 2'b10) arb_push_cond = 4'b0100;
            else arb_push_cond = 4'b1000;
    end
endmodule