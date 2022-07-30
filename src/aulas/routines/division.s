    .section .text, "ax"
    .global main
main:
    @ dividend
    ldr     r1, =1
    @ divisor
    ldr     r2, =10

    @ divide(dividend, divisor)
    stmfd   sp!, {r1, r2}
    bl      divide
    @ r3 = quocient
    @ r4 = remainder
    ldmfd   sp!, {r3, r4}
fim:
    swi     0x123456

@
@ int divide(dividend, divisor)
@ return quocient and remainder respectively
@ r12, r11, r10, r9, r8, r7, r6
@
divide:
    @ store lr
    stmfd   sp!, {lr}

    @ r11 = dividend
    @ r12 = divisor
    ldmed   sp, {r11, r12}

    @ if r12 == 0 return -1
    cmp     r12, #0
    beq     error

    @ if dividend < divisor
    subs    r8, r11, r12
    blt     cant_div

    @ msb(dividend)
    stmfd   sp!, {r11}
    bl      msb
    @ r10 = dividend msb
    ldmfd   sp!, {r10}

    @ r11 = dividend
    @ r12 = divisor
    ldmed   sp, {r11, r12}
    @ msb(divisor)
    stmfd   sp!, {r12}
    bl      msb
    @ r9 = divisor msb
    ldmfd   sp!, {r9}

    @ r11 = dividend
    @ r12 = divisor
    ldmfd   sp!, {lr}
    ldmfd   sp!, {r11, r12}
    @ r8 -> bits to be shifted
    sub     r8, r10, r9
    @ r12 >> r8
    mov     r12, r12, lsl r8
    @ r8 += 1
    add     r8, r8, #1
    @ r6 = 0 (reset quocient)
    ldr     r6, =0
div_loop:
    @ r7 -> tmp
    @ r7 = r11 - r12 (dividend - divisor)
    subs    r7, r11, r12
    bcc     div_nsub
    bcs     div_sub
div_sub:
    @ r6 -> quocient
    @ r6 << 1
    mov     r6, r6, lsl #1
    @ r6 += 1
    add     r6, r6, #1
    @ r11 -= r12 (dividend -= divisor)
    sub     r11, r11, r12
    @ r12 >> 1
    mov     r12, r12, lsr #1
    @ r8 -= 1 (decrement bits to be shifted)
    subs    r8, r8, #1
    @ if r8 == 0 return
    beq     div_return
    b       div_loop
div_nsub:
    @ r6 << 1 (quocient << 1)
    mov     r6, r6, lsl #1
    @ r12 >> 1 (divisor >> 1)
    mov     r12, r12, lsr #1
    @ r8 -= 1 (decrement bits to be shifted)
    subs    r8, r8, #1
    @ if r8 == 0 return
    beq     div_return
    b       div_loop
error:
    @ return -1
    ldr     r12, =-1
    stmed   sp!, {r12}
    mov     pc, lr
cant_div:
    ldr     r6, =0
div_return:
    @ store quocient and remainder in stack
    stmfd   sp!, {r6, r11}
    mov     pc, lr

@
@ int msb(number)
@ return most significant bit
@ r12, r11
@
msb:
    @ r12 = number
    ldmfd   sp!, {r12}
    @ number msb
    ldr     r11, =0
msb_loop:
    movs    r12, r12, lsr #1
    addne   r11, r11, #1
    @ if r11 == 0
    beq     msb_return
    @ jump to loop
    b       msb_loop
msb_return:
    @ put msb in stack
    stmfd   sp!, {r11}
    mov     pc, lr
