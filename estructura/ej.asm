! Un periferico que esta mapeado en la direccion C21000A1h entrega datos de 32 bits en formato de punto flotante simple precision. 
! Escribir un programa que lee 64 valores de ese periferico y devuelve por stack la cantidad de valores positivos entregados por el mismo. 
! La lectura de cada dato del periferico debe ser realizada por una subrutina que no recibe parametros y que devuelve via stack el valor leido. 
! Escribir programa principal y subrutina en el mismo modulo

.begin
.macro pop reg
    ld %r14, reg;
    add %r14, 4, %r14;
.endmacro

.macro push dato
    add %r14, -4, %r14;
    st dato, %r14;
.endmacro

length .equ 256;

main:       push %r15
            add %r0, %r0, %r9;
            add %r0, %r0, %r10;
for:        subcc %r9, length, %r0;
            be fin
            call lectura
            pop %r4
            srl %r4, 31, %r4
            andcc %r4, [X], %r0;
            be for
            add %r10, 1, %r10
            ba for
            

fin:        pop %r15;
            push %r10;
            jmpl %r15, 4, %r0;

lectura:    sethi C2100h %r3;
            sll %r3, 2, %r3;
            add %r3, 0A1h, %r3;
            ld %r3, %r4;
            push %r4;
            jmpl %r15 + 4, %r0
            
X: 1


.end

