    .section .text, "ax"
    .global main
main:
    ldr     r1, =10
    ldr     r2, =array_a
    ldr     r3, =5
    ldr     r4, =10
    ldr     r6, =0

@ post-indexed
post:
    ldr     r5, [r2], r3, lsl #2
    ldr     r5, [r2]
    add     r6, r1, r5
    ldr     r5, [r2], r3, lsl #2
    str     r6, [r2], r3, lsl #2

pre:
    ldr     r2, =array_b
    ldr     r6, =0
    ldr     r5, [r2, r3, lsl #2]
    add     r6, r1, r5
    str     r6, [r2, r4, lsl #2]

fim:
    swi     0x123456

.data
array_a: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
array_b: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
