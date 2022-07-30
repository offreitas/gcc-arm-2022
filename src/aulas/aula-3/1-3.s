    .section .text, "ax"
    .global main
main:
    ldr     r0, =4
    ldr     r1, =4
    cmp     r0, r1
    addeqs  r2, r0, r1
    swi     0x123456
