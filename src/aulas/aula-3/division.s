    .section .text, "ax"
    .global main
main:
    @ variables
    ldr     r0,  =0                 @ tmp register to hold dividend
    ldr     r1,  =123456789         @ dividend
    ldr     r2,  =1234              @ divisor
    ldr     r3,  =0                 @ quocient
    ldr     r4,  =0                 @ bits to be shifted
    ldr     r5,  =0                 @ remainder
    ldr     r6,  =0                 @ tmp register used in division
    ldr     r7,  =0                 @ most significant bit from dividend
    ldr     r8,  =0                 @ most significant bit from divisor
    ldr     r9,  =0                 @ argument of msb (number to hold msb)
    ldr     r10, =0                 @ argument of msb (number to find msb)
    ldr     r11, =0                 @ tmp register to hold dividend

    @ saving dividend and divisor
    mov     r0,  r1
    mov     r11, r2

    @ find msb
    mov     r10, r1                 @ passing arguments
    ldr     r9, =0
    cmp     r2, #0                  @ if divisor is 0, jump to fim
    beq     fim
    cmp     r2, #1                  @ if divisor is 1, quocient is dividend and jump to fim
    moveq   r3, r1
    beq     fim
    bl      msb
    mov     r7, r9
    mov     r10, r2                 @ passing arguments
    ldr     r9, =0
    bl      msb
    mov     r8, r9

    @ division
    sub     r4, r7, r8
    mov     r2, r2, lsl r4          @ shift divisor to msb
    add     r4, r4, #1
    bl      division
    mov     r5, r1

    @ restoring dividend and divisor
    mov     r1, r0
    mov     r2, r11

fim:
    swi     0x123456

msb:
    movs    r10, r10, lsr #1
    addne   r9, r9, #1
    moveq   pc, lr
    b       msb

division:
    subs    r6, r1, r2
    bcc     ndivide
    bcs     divide
divide:
    mov     r3, r3, lsl #1
    add     r3, r3, #1
    sub     r1, r1, r2
    mov     r2, r2, lsr #1
    subs    r4, r4, #1
    moveq   pc, lr
    b       division
ndivide:
    mov     r3, r3, lsl #1
    mov     r2, r2, lsr #1
    subs    r4, r4, #1
    moveq   pc, lr
    b       division
