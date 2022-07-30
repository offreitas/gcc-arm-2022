    .section .text, "ax"
    .global main
main:
    @ n
    ldr     r1, =11261249
    @ is prime
    ldr     r2, =0

    @ isprime(n)
    stmfd   sp!, {r1}
    bl      isprime
    ldmfd   sp!, {r2}
fim:
    swi     0x123456

@
@ isprime(number)
@
isprime:
    @ r3 = n
    ldmfd   sp, {r3}
    @ if r2 <= 1
    cmp     r3, #1
    bls     prime_no
    @ if r2 <= 3
    cmp     r3, #3
    bls     prime_yes
    
    @ if (n % 2 == 0 || n % 3 == 0)
    @ if (n % 2 == 0)
    stmfd   sp!, {lr}
    ldr     r4, =2
    stmfd   sp!, {r3, r4}
    @ divide(n, 2)
    bl      divide
    ldmfd   sp!, {r4, r5}
    ldmfd   sp!, {lr}
    cmp     r5, #0
    beq     prime_no
    @ if (n % 3 == 0)
    stmfd   sp!, {lr}
    ldr     r4, =3
    stmfd   sp!, {r3, r4}
    @ divide(n, 3)
    bl      divide
    ldmfd   sp!, {r4, r5}
    ldmfd   sp!, {lr}
    cmp     r5, #0
    beq     prime_no

    @ for (int i = 5; i * i <= n; i = i + 6)
    ldr     r4, =5
prime_loop:
    @ if (i * i > n)
    mul     r5, r4, r4
    cmp     r5, r3
    bhi     prime_yes

    @ if (n % i == 0 || n % (i + 2) == 0)
    @ if (n % i == 0)
    stmfd   sp!, {lr}
    stmfd   sp!, {r3, r4}
    @ divide(n, i)
    bl      divide
    ldmfd   sp!, {r5, r6}
    ldmfd   sp!, {lr}
    cmp     r6, #0
    beq     prime_no
    @ if (n % (i + 2))
    add     r5, r4, #2
    stmfd   sp!, {lr}
    stmfd   sp!, {r3, r5}
    @ divide(n, i + 2)
    bl      divide
    ldmfd   sp!, {r5, r6}
    ldmfd   sp!, {lr}
    cmp     r6, #0
    beq     prime_no

    @ r4 += 6 (i += 6)
    add     r4, r4, #6
    b       prime_loop
prime_yes:
    ldr     r3, =1
    stmfd   sp!, {r3}
    mov     pc, lr
prime_no:
    ldr     r3, =0
    stmfd   sp!, {r3}
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
