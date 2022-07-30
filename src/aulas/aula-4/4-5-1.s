    .section .text, "ax"
    .global main
main:
    ldr     r0, =0
    ldr     r1, =10
    ldr     r2, =array
    ldr     r3, =5

@ post-indexed
post:
    ldr     r5, [r2], r3, lsl #2
    ldr     r5, [r2]
    add     r0, r5, r1

@ pre-indexed
pre:
    ldr     r2, =array
    ldr     r4, [r2, r3, lsl #2]
    add     r0, r4, r1
fim:
    swi     0x123456

.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
    