    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008

    bl      config_io
    bl      display

fim:
    swi     0x123456

config_io:
    ldr     r3, =0b11110000
    str     r3, [r1]
    mov     pc, lr

display:
    ldr     r3, =value
    ldr     r4, [r3]
    cmp     r4, #16
    movcs   pc, lr
    mov     r4, r4, lsl #4
    ldr     r3, [r2]
    add     r3, r3, r4
    str     r3, [r2]
    mov     pc, lr

value:
    .word   12
