    .section .text, "ax"
    .global main
main:
    ldr     r0, =0x24
    ldr     r1, =0xff03fc06
    str     r1, [r0]
    
loads:
    ldrsb   sp, [r0]
    ldrsh   sp, [r0]
    ldr     sp, [r0]
    ldrb    sp, [r0]
fim:
    swi     0x123456
