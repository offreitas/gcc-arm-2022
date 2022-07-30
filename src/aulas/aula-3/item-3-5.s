    .section .text, "ax"
    .global main
main:
    ldr     r0, =0b10110100     @ 2-gray code
    ldr     r1, =0              @ 3-gray code
    ldr     r2, =0              @ 10
    ldr     r3, =0              @ 11
    ldr     r4, =0              @ 01
    ldr     r5, =0              @ 00
    ldr     r6, =0

    mov     r2, r0, lsr #6
    mov     r3, r0, lsr #4
    mov     r3, r3, lsl #30
    mov     r3, r3, lsr #30
    mov     r4, r0, lsr #2
    mov     r4, r4, lsl #30
    mov     r4, r4, lsr #30
    mov     r5, r5, lsl #30
    mov     r5, r5, lsr #30

    mov     r6, r2, lsl #21
    add     r1, r1, r6
    mov     r6, r3, lsl #18
    add     r1, r1, r6
    mov     r6, r4, lsl #15
    add     r1, r1, r6
    mov     r6, r5, lsl #12
    add     r1, r1, r6

    add     r6, r5, #0b100
    mov     r6, r6, lsl #9
    add     r1, r1, r6 
    add     r6, r4, #0b100
    mov     r6, r6, lsl #6
    add     r1, r1, r6 
    add     r6, r3, #0b100
    mov     r6, r6, lsl #3
    add     r1, r1, r6 
    add     r6, r2, #0b100
    add     r1, r1, r6 

fim:
    swi     0x123456
