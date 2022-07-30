    .section .text, "ax"
    .global main
main:
    ldr     r0, =0xf
    ldr     r1, =0xffffffff
antes:
    mov     r1, r1, lsr #1
    movs    r0, r0, lsr #1
    addcss  r1, r1, #0x80000000
fim:
    swi 0x123456
