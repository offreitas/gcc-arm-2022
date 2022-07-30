.section .text, "ax"
.global main

main:
    ldr     r1, =array_a
    ldr     r2, =array_b
    ldr     r3, =0
    ldr     r4, =0
    bl      loop
fim:
    swi     0x123456

loop:
    cmp     r3, #8
    moveq   pc, lr
    rsb     r4, r3, #7
    ldr     r5, [r2, r4, lsl #2]
    str     r5, [r1, r3, lsl #2]
    add     r3, r3, #1
    b       loop

.data
array_a: .word 1, 2, 3, 4, 5, 6, 7, 8
array_b: .word 10, 20, 30, 40, 50, 60, 70, 80
