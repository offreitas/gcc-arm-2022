    .section .text, "ax"
    .global main
main:
    @
    @   VARIABLES
    @
    ldr     r1, =0b1011010110110110
    @ output
    ldr     r2, =0
    @ auxiliary
    ldr     r3, =0    
    @ counter
    ldr     r4, =0
    
    @
    @   FSM
    @
    bl      search

stop:
    swi     0x123456

@ STATE SEARCH
search:
    cmp     r4, #32
    moveq   pc, lr
    movs    r1, r1, lsr #1
    add     r4, r4, #1
    movcs   r3, r1
    bcs     check
end_check:
    b       search

@ STATE CHECK
check:
    cmp     r4, #28
    moveq   pc, lr
    movs    r3, r3, lsr #1
    addcc   r4, r4, #1
    movcc   r1, r3
    bcc     end_check
    movs    r3, r3, lsr #1
    addcs   r4, r4, #1
    movcs   r1, r3
    bcs     end_check
    movs    r3, r3, lsr #1
    addcc   r4, r4, #1
    movcc   r1, r3
    bcc     end_check
    ldr     r5, =1
    sub     r6, r4, #1
    mov     r5, r5, lsl r6
    add     r2, r2, r5
    mov     r1, r1, lsr #2
    add     r4, r4, #2
    b       search
