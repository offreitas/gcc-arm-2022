    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008
    @ address for 7 segment display
    ldr     r3, =hex
    @ array's address
    ldr     r4, =array

    bl      config_io
    bl      display
fim:
    swi     0x123456

config_io:
    @ configure DIP switches, simple LEDs and 7 segment display
    ldr     r5, =0x1fcf0
    str     r5, [r1]
    mov     pc, lr

display:
    @ get DIP switches' value
    ldr     r5, [r2]
    mov     r5, r5, lsl #28
    mov     r5, r5, lsr #28
    @ load value from memory using DIP switches as multiplexor
    ldr     r6, [r4, r5]
    @ translate memory content to 7 segment display
    ldr     r7, [r3, r6]
    @ prepare to write output in IOPDATA
    mov     r5, r5, lsl #4      @ simple LEDs
    mov     r7, r7, lsl #10     @ 7 segment display
    add     r7, r7, r5
    @ write output to IOPDATA
    str     r7, [r2]
    b       display

hex:
    .byte   0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111011, 0b1110001 
    .align  1

array:
    .byte   15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
    .align  1
