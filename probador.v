module probador(
    output reg [7:0] data_a, data_b, // Datos de entrada 8bits
	output reg [5:0] addr_a, addr_b, // Direccion a la que se desea guardar
	output reg we_a, we_b, clk,
	input [7:0] q_a, q_b
	
    );

    initial begin
        $dumpfile("memoria.vcd");
        $dumpvars;

        {data_a,data_b} = 'hF0;
        {addr_a, addr_b} = 'b000000;

        @(posedge clk)
            we_a <= 1; 
            we_b <= 0;
            addr_a <= 'b000001;


        @(posedge clk)
            we_a <= 0; 
            we_b <= 1;
            addr_b <= 'b000001;
            
        @(posedge clk)
            we_a <= 1; 
            we_b <= 0;
        
        @(posedge clk)
            we_a <= 0; 
            we_b <= 1;
            
        $finish;    
    end

    initial clk <= 0;
    always #1 clk <= ~clk; 
endmodule