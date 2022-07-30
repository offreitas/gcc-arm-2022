    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008

    bl      config_io
    bl      light_leds
fim:
    swi     0x123456

config_io:
    ldr     r3, =0xf0
    str     r3, [r1]
    mov     pc, lr

light_leds:
    @ light leds
load_leds:
    @ led
    ldr     r3, =0xf
ll_loop:
    mov     r4, r3, lsl #4
    str     r4, [r2]
    @ save lr
    stmea   sp!, {lr}
    bl      sleep
    @ led -= 1
    ldmea   sp!, {lr}
    subs    r3, r3, #1
    movcc   pc, lr
    b       ll_loop

sleep:
    @ i
    ldr     r8, =0xffff
sleep_loop:
    @ if i == 0
    moveq   pc, lr
    @ i -= 1
    subs    r8, r8, #1
    b       sleep_loop
