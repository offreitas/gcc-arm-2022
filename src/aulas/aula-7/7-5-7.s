    .section .text, "ax"
    .global main
main:
    @ IOPMOD 0x3ff5000
    ldr     r1, =0x3ff5000
    @ IOPDATA 0x3ff5008
    ldr     r2, =0x3ff5008
    @ memory space
    ldr     r3, =dip_mem

    bl      config_io
    bl      save_dip

fim:
    swi     0x123456

config_io:
    ldr     r4, =0b0000
    str     r4, [r1]
    mov     pc, lr

save_dip:
    ldr     r4, [r2]
    mov     r4, r4, lsl #28
    mov     r4, r4, lsr #28
    str     r4, [r3]
    mov     pc, lr

dip_mem:
    .space  1
