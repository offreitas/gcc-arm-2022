    .section .text, "ax"
    .global main

main:
    @ auxiliary variable
    adr     r1, A
    ldr     r2, =s
    ldr     r3, =0
    ldr     r4, =0
    ldr     r5, =0
    
    @ loading size
    ldr     r2, [r2]

    @ init_Indices
    bl      ind

    @ init_Pointers
    adr     r1, B
    mov     r2, r2, lsl #2
    add     r5, r1, r2
    ldr     r3, =B
    bl      point

fim:
    swi     0x123456

ind:
    cmp     r2, r3
    moveq   pc, lr
    str     r4, [r1, r3, lsl #2]
    add     r3, r3, #1
    b       ind

point:
    cmp     r5, r3
    moveq   pc, lr
    str     r4, [r3], #4
    b       point

A:
    .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
B:
    .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
s:
    .word   10
p:
    .word   0
