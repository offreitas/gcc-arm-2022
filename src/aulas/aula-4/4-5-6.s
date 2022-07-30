    .section .text, "ax"
    .global main
main:
    @ variables
    ldr     r0, =0          @ result
    ldr     r1, =43         @ n
    ldr     r2, =0          @ counter

    @ preparing to enter in loop
    adr     r3, array
    sub     r1, r1, #1
    bl      loop

save:
    adr     r7, ultimo
    ldr     r6, [r3, #4]
    str     r6, ultimo

fim:
    swi     0x123456

loop:
    cmp     r2, r1
    moveq   pc, lr
    ldr     r4, [r3]
    ldr     r5, [r3, #4]!
    add     r6, r5, r4
    str     r6, [r3, #4]
    add     r2, r2, #1
    b       loop

array:
    .word   0, 1

ultimo:
    .word   0
    .align  1
