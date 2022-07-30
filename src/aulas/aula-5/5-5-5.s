    .section .text, "ax"
    .global main
main:
    ldr     r0, =0b101010101010
    ldr     r1, =0
    ldr     r2, =0

    bl      parity_check

stop:
    swi     0x123456

parity_check:
    cmp     r2, #32
    moveq   pc, lr
    movs    r0, r0, lsr #1
    eorcs   r1, r1, #0b1
    add     r2, r2, #1
    b       parity_check
