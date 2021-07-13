test:
	yosys synth.ys
	sed -i 's/Arb_demux_cond/Arb_demux_cond_synth/' transactionLayer_synth.v
	sed -i 's/Arb_mux_cond/Arb_mux_cond_synth/' transactionLayer_synth.v
	sed -i 's/Bloque_mxdx_cond/Bloque_mxdx_cond_synth/' transactionLayer_synth.v
	sed -i 's/contador/contador_synth/' transactionLayer_synth.v
	sed -i 's/maquina_est/maquina_est_synth/' transactionLayer_synth.v
	sed -i 's/transactionLayer/transactionLayer_synth/' transactionLayer_synth.v
	iverilog BancoPrueba.v cmos_cells.v
	./a.out
	rm a.out
	gtkwave prueba.gtkw
