    .section .text, "ax"
    .global main
main:
    bl      func1
fim:
    swi     0x123456

func2:
    ldmea   r13!, {r0-r4}
    mul     r0, r1, r2
    add     r0, r0, r3
    mov     pc, r4
func1:
    ldr     r0, a
    ldr     r1, b
    ldr     r2, c
    ldr     r3, d
    stmea   r13!, {r0-r3, lr}
    b       func2

@
@   VARIABLES IN MEMORY
@
a:
    .word   0
b:
    .word   3
c:
    .word   4
d:
    .word   8
