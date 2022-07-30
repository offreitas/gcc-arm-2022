    .section .text, "ax"
    .global main
main:
    ldr     r0, =0xffffffff     @ first operand
    ldr     r1, =0xffffffff
    ldr     r2, =3     @ second operand
    ldr     r3, =0
    ldr     r4, =0      @ result and will also be controling the number of additions
    ldr     r5, =0      @ result and will also have the return address
    ldr     r6, =0      @ signal indicator

setted:
    mov     r9, r0      @ first operand
    mov     r10, r1
    bl      abs64
    mov     r0, r9
    mov     r1, r10
    mov     r9, r2      @ second operand
    mov     r10, r3
    bl      abs64
    mov     r2, r9
    mov     r3, r10

    ldr     r9,  =0     @ MULTIPLICATION
    ldr     r10, =0
    bl      smul64

after:
    mov     r4, r9
    mov     r5, r10
    cmp     r6, #1
    moveq   r7, r4
    moveq   r8, r5
    moveq   r4, #0xffffffff
    bleq    invt64
    cmp     r6, #1
    moveq   r4, r7
    moveq   r5, r8

fim:
    swi     0x123456


@
@   FUNCTIONS
@
smul64:
    cmp     r4, #0
    moveq   r5, lr
    movs    r7, r3, lsr #1
    bcs     calculate
shift:
    mov     r7, r0      @ first operand shift
    mov     r8, r1
    bl      flsl64
    mov     r0, r7
    mov     r1, r8
    mov     r7, r2     @ second operand shift
    mov     r8, r3
    bl      flsr64
    mov     r2, r7
    mov     r3, r8
    add     r4, r4, #1  @ compute number of iterations
    cmp     r4, #64
    moveq   pc, r5      @ return to main
    b       smul64
calculate:
    adds    r10, r10, r1
    add     r9, r9, r0
    addcs   r9, r9, #1
    b       shift

abs64: @ absolute value 64 bits
    movs    r9, r9
    rsblt   r9, r9, #0
    sublt   r9, r9, #1
    rsblt   r10, r10, #0
    eorlt   r6, r6, #0b1
    mov     pc, lr

flsl64: @ shift left 64 bits
    movs    r8, r8, lsl #1
    mov     r7, r7, lsl #1
    addcss  r7, r7, #1
    mov     pc, lr

flsr64: @ shift right 64 bits
    mov     r8, r8, lsr #1
    movs    r7, r7, lsr #1
    addcss  r8, r8, #0x80000000
    mov     pc, lr

invt64:
    eor     r7, r7, r4
    eor     r8, r8, r4
    adds    r7, r7, #1
    addcs   r8, r8, #1
    mov     pc, lr
