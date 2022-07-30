    .section .text, "ax"
    .global main

main:
    ldr     r3, =0x4000
    ldr     r4, =0x20
    strb    r9, [r3, r4]
    ldrb    r8, [r3, r4, lsl #3]
    ldr     r7, [r3], r4
    strb    r6, [r3], r4, asr #2
fim:
    swi     0x123456
