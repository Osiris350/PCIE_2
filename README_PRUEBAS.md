Explicacion rapida de las pruebas:

- El codigo de colores relaciona las señales estructurales y conductuales correspondientes. 

- Las señales conductuales siempre estan seguidas de su respectiva señal estructural y se separan con comentarios en la zona de señales, comentarios que a su vez separan los distintos bloques del sistema. 

- La division de pruebas aproximada en tiempo es la siguiente: 

* Seg 10 termina cambio de umbrales y empieza primer llenado de fifos de salida (Punto 2 de las pruebas del enunciado del proyecto).

* A los 70s (cuando el fifo 8 llega por primera vez a almost full) finaliza el la prueba anterior e inicia la proxima. 

* Al segundo 84s se llega todos los fifos de entrada a almost full. Y se empiezan a vaciar todos los fifos. Se terminan de vaciar los 180 segundos. 

* A partir de ahi(198s), inicia la proxima prueba, enviando las 16 combinaciones de palabras. Finaliza en los 350s.
