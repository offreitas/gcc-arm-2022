    .text
    .global main
main:
    # argument
    ldr     r0, =7

    bl      imprime
fim:
    swi     0x123456


imprime:
    mov     ip, sp
    stmfd   sp!, {fp, ip, lr, pc}
    sub     fp, ip, #4
    sub     sp, sp, #4
    str     r0, [fp, #-16]
    ldr     r3, [fp, #-16]
    cmp     r3, #0
    beq     fim_imprime
    add     r3, r3, #0x30
    ldr     r0, =string
    mov     r1, r3
    bl      printf
    ldr     r3, [fp, #-16]
    sub     r3, r3, #1
    mov     r0, r3
    bl      imprime
fim_imprime:
    ldmfd   sp, {r3, fp, sp, pc}

.data
    string: .ascii "%c\n\000"
