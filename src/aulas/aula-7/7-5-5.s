    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008

    bl      set_iopmod
    bl      display_dips
fim:
    swi     0x123456

set_iopmod:
    ldr     r3, =0xf0
    str     r3, [r1]
    mov     pc, lr

display_dips:
    ldr     r3, [r2]
    mov     r4, r3, lsl #28
    mov     r4, r4, lsr #24
    add     r4, r4, r3
    str     r4, [r2]
    mov     pc, lr
