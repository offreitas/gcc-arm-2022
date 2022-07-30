    .section .text, "ax"
    .global main
main:
    ldr     r0, =0
    adr     r1, fib
    bl      loop

fim:
    swi     0x123456

loop:
    cmp     r0, #11
    moveq   pc, lr
    ldrb    r2, [r1]
    ldrb    r3, [r1, #1]!
    add     r4, r2, r3
    strb    r4, [r1, #1]
    add     r0, r0, #1
    b       loop

fib:
    .byte   0, 1
    .align  1
