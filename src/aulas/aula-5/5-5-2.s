    .section .text, "ax"
    .global main
main:
    ldr     r4, =0
    ldr     r5, =0
    ldr     r6, =0
    bl      factorial

stop:
    swi     0x123456

factorial:
    mov     r6, #0x4
    mov     r4, r6
loop:
    subs    r6, r6, #1
    mulne   r5, r6, r4
    movne   r4, r5 
    bne     loop
    mov     pc, lr
