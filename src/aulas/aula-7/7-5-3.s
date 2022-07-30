    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008
    @ value address
    ldr     r3, =hex

    bl      set_output
    bl      display_hex
fim:
    swi     0x123456

set_output:
    ldr     r4, =0x1fc00
    str     r4, [r1]
    mov     pc, lr

display_hex:
    @ load value address
    ldr     r4, =value
    ldr     r5, [r4]
    @ if r5 >= 16
    subs    r6, r5, #16
    movcs   pc, lr
    @ else
    ldr     r6, =0xf
dh_loop:
    @ if r6 == r5
    cmp     r6, r5
    beq     load_value
    @ else
    subs    r6, r6, #1
    @ if r6 < 0
    movcc   pc, lr
    @ else
    b       dh_loop
load_value:
    ldrb    r7, [r3, r6]
    mov     r7, r7, lsl #10
    str     r7, [r2] 
    mov     pc, lr

hex:
    .byte   0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111011, 0b1110001 
    .align  1

value:
    .word   13
