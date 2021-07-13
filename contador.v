module contador_cond (
    input POP_0,
    input POP_1,
    input POP_2,
    input POP_3,
    input IDLE,
    input req,
    input [1:0] idx,
    input reset_L,
    input clk,
    output reg [4:0] data_out,
    output reg valids    
);

    reg [4:0] cont_0 = 5'b0;
    reg [4:0] cont_1 = 5'b0;
    reg [4:0] cont_2 = 5'b0;
    reg [4:0] cont_3 = 5'b0;

always @(posedge clk)begin
    if(reset_L == 0)begin
        cont_0 <= 5'b0;
        cont_1 <= 5'b0;
        cont_2 <= 5'b0;
        cont_3 <= 5'b0;
    end    
    else begin  
        if(POP_0) begin
            cont_0 <= cont_0 + 1;
        end
        if(POP_1) begin
            cont_1 <= cont_1 + 1;
        end
        if(POP_2) begin
            cont_2 <= cont_2 + 1;
        end
        if(POP_3) begin
            cont_3 <= cont_3 + 1;
        end
    end   
end

always @(*) begin
    if (IDLE && req) begin
        case (idx)
            2'b00: begin
                data_out = cont_0;
            end
            2'b01: begin
                data_out = cont_1;
            end
            2'b10: begin
                data_out = cont_2;
            end
            2'b11: begin
                data_out = cont_3;
            end
        endcase
        valids = 1;
    end
    else begin
        data_out = 0;
        valids = 0;
    end
end
endmodule
