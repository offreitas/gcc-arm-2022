    .section .text, "ax"
    .global main
main:
    ldr     r0, =-3
    ldr     r1, =0
    bl      abs

fim:
    swi     0x123456

abs:
    movs    r2, r0
    rsblt   r1, r0, #0
    mov     pc, lr
