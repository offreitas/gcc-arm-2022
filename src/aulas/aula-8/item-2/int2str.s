    .text
    .global int2str
int2str:
    @ divisor
    ldr     r2, =10
    @ number to make string
    ldr     r3, =0x30
    @ pontstr address
    stmfd   sp!, {lr}
    @ counter to shift
    ldr     r4, =0
    @ store counter in stack
    stmfd   sp!, {r4}

loop_int2str:
    cmp     r0, #0
    beq     end_int2str
    stmfd   sp!, {r0, r2}
    bl      divide
    ldmfd   sp!, {r4, r5}
    add     r5, r5, r3
    strb    r5, [r1]
    mov     r0, r4
    cmp     r4, #0
    beq     end_int2str

    @ check word limits
    bl      shift

    b       loop_int2str
end_int2str:
    ldmfd   sp!, {r4}
    ldmfd   sp!, {lr}
    mov     pc, lr

shift:
    ldmfd   sp!, {r4}
    mov     r5, r4
    add     r4, r4, #1
shift_loop:
    ldrb    r6, [r1, r5]
    add     r5, r5, #1
    strb    r6, [r1, r5]
    subs    r5, r5, #2
    blt     end_shift
    b       shift_loop
end_shift:
    stmfd   sp!, {r4}
    mov     pc, lr

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
    ldmfd   sp!, {lr}
    ldmfd   sp!, {r11, r12}
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
