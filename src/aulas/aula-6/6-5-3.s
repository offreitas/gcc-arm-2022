    .section .text, "ax"
    .global main
main:
    @ n
    ldr     r1, =4
    @ n(n*n + 1)/2
    ldr     r2, =0
    @ is magic
    ldr     r9, =1

    @ copy()
    bl      copy

    @ bubbleSort()
    bl      bubbleSort

    @ testDefinition()
    bl      testDefinition
    cmp     r7, #0
    moveq   r9, #0
    beq     saveOnMem

    @ magicSum()
    bl      magicSum

    @ secDiagTest()
    bl      secDiagTest
    cmp     r9, #0
    moveq   r9, #0
    beq     saveOnMem

    @ primDiagTest()
    bl      primDiagTest
    cmp     r9, #0
    moveq   r9, #0
    beq     saveOnMem

    @ colTest()
    bl      colTest
    cmp     r9, #0
    moveq   r9, #0
    beq     saveOnMem

    @ rowTest()
    bl      rowTest

saveOnMem:
    ldr     r3, =ehmagico
    str     r9, [r3]

fim:
    swi     0x123456

@
@ FUNCTIONS
@
@ TEST DEFINITION
testDefinition:
    @ compute n*n
    mul     r3, r1, r1
    @ load sorted
    ldr     r4, =sorted
    @ is correct
    ldr     r7, =1
    @ i
    ldr     r5, =0
tdLoop:
    cmp     r5, r3
    moveq   pc, lr
    ldr     r6, [r4, r5, lsl #2]
    add     r8, r5, #1
    cmp     r8, r6
    movne   r7, #0
    movne   pc, lr
    add     r5, r5, #1
    b       tdLoop

@ COPY
copy:
    @ compute n*n
    mul     r3, r1, r1
    @ i
    ldr     r4, =0
    @ load magic
    ldr     r5, =quadrado
    @ load sorted
    ldr     r6, =sorted
copyLoop:
    cmp     r4, r3
    moveq   pc, lr
    ldr     r7, [r5, r4, lsl #2]
    str     r7, [r6, r4, lsl #2]
    add     r4, r4, #1
    b       copyLoop

@ BUBBLE SORT
bubbleSort:
    @ i
    ldr     r0, =0
    @ j
    ldr     r3, =0
    @ load sorted
    ldr     r10, =sorted
    @ size
    mul     r11, r1, r1
outerLoop:
    sub     r4, r11, #1      @ r4 = size - 1
    cmp     r0, r4
    moveq   pc, lr          @ if i == size - 1
innerLoop:
    sub     r5, r11, #1
    sub     r5, r5, r0      @ r5 = size - i - 1
    cmp     r3, r5
    beq     endOuterLoop    @ if j == size - i - 1
    @ sort code
    add     r6, r3, #1
    ldr     r7, [r10, r3, lsl #2]
    ldr     r8, [r10, r6, lsl #2]
    cmp     r7, r8
    ble     endInnerLoop    @ if r7 <= l8
    str     r7, [r10, r6, lsl #2]
    str     r8, [r10, r3, lsl #2]
    @ end of sort code
endInnerLoop:
    add     r3, r3, #1
    b       innerLoop
endOuterLoop:
    add     r0, r0, #1
    ldr     r3, =0          @ resets j
    b       outerLoop

@ VALUE OF MAGIC SUM
magicSum:
    mul     r2, r1, r1
    add     r2, r2, #1
    mul     r3, r2, r1
    mov     r2, r3, lsr #1
    mov     pc, lr

@ TEST SECONDARY DIAGONAL
secDiagTest:
    @ store lr value
    str     lr, [sp, #-4]!
    @ i
    ldr     r3, =0
    @ arr
    ldr     r6, =quadrado
sdtLoop:
    cmp     r3, r1
    beq     testSecDiagValue
    @ r5 = (i + 1)(n - 1)
    mul     r5, r3, r1
    sub     r5, r5, r3
    add     r5, r5, r1
    sub     r5, r5, #1
    @ end computation
    ldr     r7, [r6, r5, lsl #2]
    str     r7, [sp, #-4]!
    add     r3, r3, #1
    b       sdtLoop
testSecDiagValue:
    bl      accTest
    ldr     lr, [sp]
    mov     pc, lr

@ TEST PRIMARY DIAGONAL
primDiagTest:
    @ store lr value
    str     lr, [sp, #-4]!
    @ i
    ldr     r3, =0
    @ arr
    ldr     r6, =quadrado
pdtLoop:
    cmp     r3, r1
    beq     testPrimDiagValue
    @ r5 = i * (n + 1)
    mul     r5, r3, r1
    add     r5, r5, r3
    @ end computation
    ldr     r7, [r6, r5, lsl #2]
    str     r7, [sp, #-4]!
    add     r3, r3, #1
    b       pdtLoop
testPrimDiagValue:
    bl      accTest
    ldr     lr, [sp]
    mov     pc, lr

@ TEST COLUMNS
colTest:
    @ store lr value
    str     lr, [sp, #-4]!
    @ i
    ldr     r3, =0
    @ arr
    ldr     r6, =quadrado
ctOuterLoop:
    cmp     r3, r1
    moveq   pc, lr
    @ j
    ldr     r4, =0
ctInnerLoop:
    cmp     r4, r1
    beq     testColValue
    @ r5 = i + (n * j)
    mul     r5, r4, r1
    add     r5, r5, r3
    @ end computation
    ldr     r7, [r6, r5, lsl #2]
    str     r7, [sp, #-4]!
    add     r4, r4, #1
    b       ctInnerLoop
testColValue:
    bl      accTest
    ldr     lr, [sp]
    cmp     r9, #0
    moveq   pc, lr
    add     r3, r3, #1
    b       ctOuterLoop

@ TEST ROWS
rowTest:
    @ store lr value
    str     lr, [sp, #-4]!
    @ i
    ldr     r3, =0
    @ arr
    ldr     r6, =quadrado
rtOuterLoop:
    cmp     r3, r1
    moveq   pc, lr
    @ j
    ldr     r4, =0
rtInnerLoop:
    cmp     r4, r1
    beq     testRowValue
    @ r5 = (i * n) + j
    mul     r5, r3, r1
    add     r5, r5, r4
    @ end computation
    ldr     r7, [r6, r5, lsl #2]
    str     r7, [sp, #-4]!
    add     r4, r4, #1
    b       rtInnerLoop
testRowValue:
    bl      accTest
    ldr     lr, [sp]
    cmp     r9, #0
    moveq   pc, lr
    add     r3, r3, #1
    b       rtOuterLoop

@ SUM VALUES
accTest:
    @ counter
    ldr     r10, =0
    @ auxiliary reg
    ldr     r11, =0
    @ accumulator
    ldr     r12, =0
atLoop:
    cmp     r1, r10
    beq     atEnd
    @ accumulate
    ldr     r11, [sp], #4
    add     r12, r12, r11
    @ end block
    add     r10, r10, #1
    b       atLoop
atEnd:
    cmp     r12, r2
    movne   r9, #0
    mov     pc, lr

quadrado:
    .word   16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4, 15, 14, 1

sorted:
    .space  100

ehmagico:
    .space  4

@ quadrado:
@     .word   4, 9, 2, 3, 5, 7, 8, 1, 6

@ quadrado:
@     .word   5, 5, 5, 5, 5, 5, 5, 5, 5
