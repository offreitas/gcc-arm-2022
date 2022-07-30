    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008
    @ address for 7 segment display
    ldr     r3, =hex

    bl      config_io
    bl      display
fim:
    swi     0x123456

config_io:
    @ configure DIP switches and 7 segment display
    ldr     r4, =0x1fc00
    str     r4, [r1]
    mov     pc, lr

display:
    @ get DIP switches' values
    ldr     r4, [r2]
    mov     r4, r4, lsl #28
    mov     r4, r4, lsr #28
    ldr     r5, [r3, r4]
    mov     r5, r5, lsl #10
    str     r5, [r2]
    mov     pc, lr

hex:
    .byte   0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111011, 0b1110001 
    .align  1
