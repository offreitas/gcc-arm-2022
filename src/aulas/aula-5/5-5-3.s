    .section .text, "ax"
    .global main
main:
    ldr     r1, =data
    ldr     r2, =0
    ldr     r3, =0
    ldr     r4, =0
    ldr     r5, =9

    bl      find_gt

stop:
    swi     0x123456

find_gt:
    ldr     r2, [r1], #4
loop:
    sub     r5, r5, #1
    cmp     r5, #0
    moveq   pc, lr
    ldr     r3, [r1], #4
    subs    r4, r2, r3
    movcc   r2, r3
    b       loop

data:
    .word   3, 1, 5, 18, 9, 37, 5, 10, 6
