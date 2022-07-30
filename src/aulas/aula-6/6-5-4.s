    .section .text, "ax"
    .global main
main:
    @ type of data
    ldr     r0, =4

    @ push()
    bl      push

fim:
    swi     0x123456

push:
    @ array address
    ldr     r2, =data
    @ i
    ldr     r3, =0
    @ test type of data
    cmp     r0, #1
    beq     pushByte
    cmp     r0, #2
    beq     pushHalf
    cmp     r0, #4
    beq     pushWord
    mov     pc, lr
pushByte:
    @ siexe
    ldrb    r4, [r2], #1
pbLoop:
    cmp     r3, r4
    moveq   pc, lr
    ldrb    r1, [r2], #1
    strb    r1, [sp, #-1]!
    add     r3, r3, #1
    b       pbLoop

pushHalf:
    @ size
    ldrh    r4, [r2], #2
phLoop:
    cmp     r3, r4
    moveq   pc, lr
    ldrh    r1, [r2], #2
    strh    r1, [sp, #-2]!
    add     r3, r3, #1
    b       phLoop

pushWord:
    @ size
    ldr     r4, [r2], #4
pwLoop:
    cmp     r3, r4
    moveq   pc, lr
    ldr     r1, [r2], #4
    str     r1, [sp, #-4]!
    add     r3, r3, #1
    b       pwLoop

data:
    .word   10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

@ data:
@     .hword  10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

@ data:
@     .byte   10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
