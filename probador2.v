module probador2 #( 
    parameter RAM_WIDTH = 10,
	parameter RAM_DEPTH = 8,
	parameter ADDR_SIZE = 3
    )
    (
	output reg clk,rst,wr_enb,rd_enb,
	output reg [RAM_WIDTH-1:0] data_in,
	output reg [ADDR_SIZE-1:0] rd_addr, wr_addr,
	input [RAM_WIDTH-1:0] data_out,
    input [RAM_WIDTH-1:0] data_out_s
    );

    initial begin
        $dumpfile("memoria.vcd");
        $dumpvars;

        rst = 0;
        data_in = 'hFF;
        {rd_addr, wr_addr} = 'b0;
        {wr_enb,rd_enb} = 'b0;

        repeat (2) begin 
            @(posedge clk)
                rst = 1;
        end

        @(posedge clk)
            wr_enb <= 1; // Vamos a escribir
            rd_enb <= 0; // No se lee nada;
            wr_addr <= 'b000000; 

        @(posedge clk)
            data_in = 'hCC;
            wr_enb <= 1; // Vamos a escribir
            rd_enb <= 1; // Vamos a leer
            wr_addr <= 'b000000; 
            rd_addr <= 'b000000;

        @(posedge clk)
            wr_enb <= 1; 
            rd_enb <= 1;
            rd_addr <= 'b000001;
            wr_addr <='b000010; 

        @(posedge clk)
            wr_enb <= 0; 
            rd_enb <= 1;
            rd_addr <= 'b000000;
            wr_addr <='b000010; 

        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)

        $finish;    
    end

    initial clk <= 1;
    always #1 clk <= ~clk; 
endmodule