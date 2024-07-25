Un periferico mapeado enla direccion A500A120h entrega una palabra de 32 bits cuyos 18 bits menos significativos contiene la informacion de interes. 
Escribir programa que declara un arreglo de 20 elementos y lo completa con los primeros 20 valores leidos del periferico mencionado (sus primeros 18 bits extendiendo el signo) 
Implementarlo:
    Declarando en el mismo modula una rutina cuya funcion es leer el periferico mencionado, 
    no recibe parametros de entrada y edevuelve por stack el valor de 18 bits extendido en signo a 32

    Declarando una macro que cumpla una funcion similar a lo indicado en a

.begin

.org 3000
.dwb 20
address .equ 3000

.org 2048

.macro pop reg
    ld %r14, reg
    add %r14, 4, %r14
.endmacro

.macro push dato
    add %r14, -4, %r14
    st dato, %r14
.endmacro

length .equ 80

main:       push %r15
            add %r0, %r0, %r10

for:        subcc %r10, length, %r0
            be fin
            call lectura
            pop %r3
            add %r10, address, %r9
            st %r3, %r9
            add %r10, 4, %r10
            ba for

fin:        pop %r15
            jmpl %r15 + 4, %r0

lectura:    sethi A500Ah, %r4
            sll %r4, 2, %r4
            add %r4, 120h, %r4
            ld %r4, %r3
            sll %r3, 12, %r3
            sra %r3, 12, %r3
            push %r3
            jmpl %r15 + 4, %r0

.end
