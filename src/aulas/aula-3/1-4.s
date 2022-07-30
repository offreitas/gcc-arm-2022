    .section .text, "ax"
    .global main
main:
    ldr     r0, =0xe
    ldr     r1, =0xfffffffe
antes:
    movs    r1, r1, lsl #1
    mov     r0, r0, lsl #1
    addcss  r0, r0, #1
fim:
    swi 0x123456
