    .section .text, "ax"
    .global main
main:
    ldr r4, =3              @ set up parameters
    bl func
    swi 0x123456
func:
    mov r1, r4, lsl #14
    mov pc, lr
