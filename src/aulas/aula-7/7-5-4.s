    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008
    @ array address
    ldr     r4, =array
    @ hex address
    ldr     r7, =hex
    
    bl      config_io
    bl      display

fim:
    swi     0x123456

config_io:
    ldr     r3, =0b1111111
    mov     r3, r3, lsl #10
    str     r3, [r1]
    mov     pc, lr

sleep:
    ldr     r3, =0xfffff
sloop:
    subs    r3, r3, #1
    movmi   pc, lr
    b       sloop

display:
    @ stores lr in sp
    stmfd   sp!, {lr}
    @ i
    ldr     r5, =0
    @ size
    ldr     r6, [r5], #1
dloop:
    cmp     r5, r6
    ldmfd   sp!, {lr}
    moveq   pc, lr
    ldr     r8, [r7, r5]
    mov     r8, r8, lsl #10
    str     r8, [r2]
    stmfd   sp!, {lr}
    bl      sleep


array:
    .byte   10, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    .align  1

hex:
    .byte   0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111011, 0b1110001 

