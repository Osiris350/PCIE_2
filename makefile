test:
	iverilog BancoPrueba.v 
	./a.out
	rm a.out
	gtkwave memoria.vcd

