Un programa recibe por stack la direccion del inicio de un arreglo de 8 elementos enteros sin signo.
Debe calcular la suma de todos los elementos impares y escribirla en un periferico mapeado a la A1C200020h
La suma de los elementos del arreglo debe estar implementado en una subrutina que recibe por stack la direccion del inicio del arreglo y devuelve la suma, 
o en caso de que esta no puede ser representado en 32 bits, devuelve 0

.begin

.org 2048

length .equ 32

.macro pop reg
    ld %r14, reg
    add %r14, 4, %r14
.endmacro

.macro push dato
    add %r14, -4, %r14
    st dato, %r14
.endmacro

main:   pop %r10        ! Guardo en r10 la direccion del inicio
        push %r15
        push %r10
        call suma

        sethi A1C20h %r3;
        sll %r3, 2, %r3;
        add %r3, 002h, %r3;

        pop %r1
        st %r1, %r3

        pop %r15
        jmpl %r15, 4, %r0


suma:   add %r0, %r0, %r10
        add %r0, %r0, %r1
        pop %r9
for:    subcc %r10, length, %r0
        be fin
        ld %r9, %r10, %r2
        add %r2, %r0, %r3
        sll %r3, 31, %r3
        addcc %r3, %r0, %r0
        add %r10, 4, %r10
        be for
        addcc %r2, %r1, %r1
        bvs error
        ba for

error:  add %r0, %r0, %r1

fin:    push %r1
        jmpl %r15, 4, %r0
        

x: 2

1760: IF [R[IR[13]]] GOTO 1762
1761: R[rd] <-- ADD[R[rs1], R[rs2]] GOTO 1764
1762: R[temp0] <-- SEXT13[R[IR]]
1763: R[rd] <-- ADD[R[rs1], R[temp0]] 
1764: R[pc] <-- AND[R[rd], R[rd]] GOTO 0



