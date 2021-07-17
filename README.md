# Proyecto \#2: Capa de transacción PCIE adaptada y lógica de conmutación

Este proyecto se basa en la creación de la capa de transacción del PCIE. Esta capa se modela de tal forma que lee los datos de entrada, los guarda en una memoria de entrada para posteriormente redirigirlos al puerto de salida en el que se requieran bajo una prioridad dada. Además cuenta con un árbitro para el manejo de las memorias internas (en este caso FIFOs), que se encarga de manejar las prioridades de los FIFOS de entrada, y limitar el paso de información cuando se llenan los FIFOs. Por otra parte, la capa de transacción también cuenta con una máquina de estados que controla la etapa en la que se encuentra el módulo. 
## Autores

- Luis Alonso Rodríguez - B76547
- Jafet David Gutiérrez Guevara - B73558
- Gabriel Araya Mora - B80525
- Andrés Arias Campos - B80661
## Documentation

La capa de transacción diseñada está compuesta por los siguientes elementos:

- FIFO: Se utilizan ocho unidades en total, las cuales se encargan del manejo de memoria en la arquitectura.
- Árbitro: Se utiliza para el manejo de los buses de memoria en los FIFOs, esto para evitar que dos de ellos traten de pasar por un cable al mismo tiempo.
- Multiplexor y demultiplexor: El multiplexor se compone por 4 entradas y una salida de datos. Su propósito es pasar las palabras de salida de cada FIFO al demultiplexor. Por otra parte, el demultiplexor está conformado por una entrada y 4 salidas de datos. Su función es la de direccionar las palabras que le pasa el multiplexor al FIFO correspondiente. El multiplexor utiliza la salida de pop del árbitro como entrada de selección, mientras que el demultiplexor escoge la salida de datos con base en los dos bits más significativos de las palabras de entrada.
- Contadores: Se utilizan para verificar que la cantidad de palabras de entrada y salida sean la misma, esto para corroborar que no se perdieron datos en el proceso.
- FSM: También llamada máquina de estados, es la encargada de indicar en cuál estado se encuentra la capa. Entre los estados se encuentran: el de reinicio (reset), el de inicio (init), el de inactividad (idle) y el de activo (active).

A continuación se muestra el diagrama que describe la arquitectura de la capa de transacción desarrollada: 

[![Diagrama-completo.jpg](https://i.postimg.cc/RZSrFzcQ/Diagrama-completo.jpg)](https://postimg.cc/qz5DbSDz)

### Universidad de Costa Rica 

#### Facultad de Ingeniería

#### Escuela de Ingeniería Eléctrica

#### IE0523 - Circuitos Digitales II
