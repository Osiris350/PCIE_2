`include  "memoria.v"
`include "probador.v"

module bancoPrueba;

wire [7:0] data_OutA, data_OutB; 
wire [7:0] data_InA, data_InB;
wire [5:0] dir_A, dir_B;
wire enable_A,enable_B;
wire clk; 


true_dpram_sclk memoria (
    //OUTPUTS
    .q_a    (data_OutA),
    .q_b    (data_OutB),
    //INPUTS
    .data_a (data_InA),
    .data_b (data_InB),
    .addr_a (dir_A),
    .addr_b (dir_B),
    .we_a   (enable_A),
    .we_b   (enable_B),
    .clk    (clk)
);

probador probador1(
    //OUTPUTS
    .data_a (data_InA),
    .data_b (data_InB),
    .addr_a (dir_A),
    .addr_b (dir_B),
    .we_a   (enable_A),
    .we_b   (enable_B),
    .clk    (clk),
    //INPUTS
    .q_a    (data_OutA),
    .q_b    (data_OutB)
);


endmodule