    .section .text, "ax"
    .global main
main:
    @
    @   VARIABLES
    @
    @ number to search
    ldr     r1, =0x360036
    @ output
    ldr     r2, =0
    @ result auxiliary
    ldr     r3, =0    
    @ counter of search loop
    ldr     r4, =0
    @ first number in sequence
    ldr     r5, =0
    @ number to be compared
    ldr     r6, =0
    @ sequence auxiliary
    ldr     r7, =0
    @ sequence
    ldr     r8, =0x36
    @ sequence size
    ldr     r9, =7
    @ check state limit
    ldr     r10, =0
    @ counter of check loop
    ldr     r11, =0
    @ auxiliary to make result
    ldr     r12, =0

    
    @
    @   FSM
    @
    movs    r5, r8, lsr #1      @ check first number of the sequence
    movcs   r5, #1
    movcc   r5, #0
    rsb     r10, r9, #32        @ limit of the check state limit
    bl      search

stop:
    swi     0x123456

@ STATE SEARCH
search:
    cmp     r9, #1
    bne     search_loop
    cmp     r8, #1
    moveq   r2, r1
    mvnne   r2, r1
    mov     pc, lr
    
search_loop:
    cmp     r4, #32             @ check if r4 is equal to limit
    moveq   pc, lr
    movs    r1, r1, lsr #1
    movcs   r6, #1
    movcc   r6, #0
    add     r4, r4, #1
    cmp     r5, r6
    moveq   r3, r1              @ move number to auxiliary
    moveq   r7, r8, lsr #1      @ move sequence to auxiliary
    moveq   r11, #1             @ initialize counter
    beq     check
end_check:
    b       search_loop

@ STATE CHECK
check:
    cmp     r4, r10             @ check if r4 is equal to limit
    moveq   pc, lr

    @ found sequence
    cmp     r11, r9
    beq     found_seq

shift:
    movs    r3, r3, lsr #1
    movcs   r6, #1
    movcc   r6, #0
    movs    r7, r7, lsr #1
    movcs   r5, #1
    movcc   r5, #0
    cmp     r5, r6
    addeq   r11, r11, #1

    @ wrong number
    subne   r5, r11, #1
    addne   r4, r4, r5
    bne     reset
    b       check

found_seq:
    sub     r5, r11, #2
    mov     r1, r1, lsr r5
    mov     r12, #1             @ put 1 in r2 if detected sequence
    sub     r5, r4, #1
    mov     r12, r12, lsl r5
    add     r2, r2, r12
    sub     r5, r11, #2
    add     r4, r4, r5
    b       reset

reset:
    movs    r5, r8, lsr #1      @ check first number of the sequence
    movcs   r5, #1
    movcc   r5, #0
    b       search_loop
