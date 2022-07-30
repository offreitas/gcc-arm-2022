    .section .text, "ax"
    .global main
main:
    @
    @   VARIABLES
    @
    @ base address
    ldr     r0, =arr
    @ array size
    ldr     r1, [r0], #4

    bl      bubbleSort

fim:
    swi     0x123456

bubbleSort:
    @ i
    ldr     r2, =0
    @ j
    ldr     r3, =0

outerLoop:
    sub     r4, r1, #1      @ r4 = size - 1
    cmp     r2, r4
    moveq   pc, lr          @ if i == size - 1
innerLoop:
    sub     r5, r1, #1
    sub     r5, r5, r2      @ r5 = size - i - 1
    cmp     r3, r5
    beq     endOuterLoop    @ if j == size - i - 1
    @ sort code
    add     r6, r3, #1
    ldr     r7, [r0, r3, lsl #2]
    ldr     r8, [r0, r6, lsl #2]
    cmp     r7, r8
    ble     endInnerLoop    @ if r7 <= l8
    str     r7, [r0, r6, lsl #2]
    str     r8, [r0, r3, lsl #2]
    @ end of sort code
endInnerLoop:
    add     r3, r3, #1
    b       innerLoop
endOuterLoop:
    add     r2, r2, #1
    ldr     r3, =0          @ resets j
    b       outerLoop

arr:
    .word 9, 6, 1, 5, 4, 8, 7, 3, 9, 2
