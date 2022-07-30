.global _start
.text

_start:
    b _Reset                        @ position 0x00 - Reset
    ldr pc, _undefined_instruction  @ position 0x04 - Undefined instruction
    ldr pc, _software_interrupt     @ position 0x08 - Software Interruption
    ldr pc, _prefetch_abort         @ position 0x0C - Prefetch Abort
    ldr pc, _data_abort             @ position 0x10 - Data Abort
    ldr pc, _not_used               @ position 0x14 - Not used
    ldr pc, _irq                    @ position 0x18 - Interruption (IRQ)
    ldr pc, _fiq                    @ position 0x1C - Interruption (FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND: .word 0x10140000    @ interrupt status register
INTSEL: .word 0x1014000C    @ interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010     @ interrupt enable register
TIMER0L: .word 0x101E2000   @ timer 0 load register
TIMER0V: .word 0x101E2004   @ timer 0 value registers
TIMER0C: .word 0x101E2008   @ timer 0 control register
TIMER0X: .word 0x101E200c   @ timer 0 interrupt clear register

_Reset:
    ldr sp, =taskA_stack_top    @ put taskA stack top address at sp

    mrs r0, cpsr                @ save cpsr at r0 temporarily
    msr cpsr_c, #0xd2           @ change cpsr control bits
    ldr sp, =irq_stack_top      @ put IRQ stack top address at sp when cpsr control bits change
    msr cpsr, r0                @ go back to initial cpsr

    ldr r0, =linhaB             @ load linhaB address
    add r0, r0, #52             @ get thirteenth address at linhaB
    ldr r1, =taskB_stack_top    @ load taskB stack top address
    str r1, [r0], #8            @ save taskB stack top address at linhaB
    ldr r1, =taskB              @ load first instruction from taskB
    str r1, [r0], #4            @ save taskB first instruction at linhaB
    mrs r1, cpsr                @ move cpsr to r1
    bic r1, #0x80               @ enable IRQ interruptions
    str r1, [r0]                @ store new cpsr at linhaB

    bl  entry
    bl  timer_init

    ldr r0, =0x10
    msr cpsr, r0
    ldr sp, =taskA_stack_top

    bl  taskA
    b .
undefined_instruction:
    b .
software_interrupt:
    b do_software_interrupt @ go to software interrupt handler
prefetch_abort:
    b .
data_abort:
    b .
not_used:
    b .
irq:
    b do_irq_interrupt @ go to IRQ interrupt handler
fiq:
    b .
do_software_interrupt:
    add r1, r2, r3  @ r1 = r2 + r3
    mov pc, lr      @ go back to the saved address in lr
@ IRQ interrupt routine
do_irq_interrupt: nop
    sub     lr, lr, #4
    str     lr, pc_irq
    ldr     lr, INTPND              @ load interruption status register
    ldr     lr, [lr]
    tst     lr, #0x0010             @ verify if is a timer interruption
    blne    handler_timer
    b       .                       @ undefined interruption

handler_timer: nop
    bl      save_process_table
    ldr     r0, TIMER0X
    ldr     r1, =0
    str     r1, [r0]
    bl      change_process

load_process_table: nop
    ldr     r0, nproc
    mov     r0, r0, lsl #2
    add     r0, r0, r0, lsl #4
    add     r0, r0, #linhaA
    mov     pc, lr

save_process_table: nop
    stmfd   sp!, {r0 - r12, lr}
    bl      load_process_table

    mov     lr, r0                  @ move process table address to lr
    ldmfd   sp!, {r0 - r12}         @ load registers stored at sp
    stmia   lr!, {r0 - r12}         @ store registers at lr

    mrs     r0, cpsr                @ save current cpsr temporarily
    mrs     r1, spsr                @ get saved cpsr
    tst     r1, #0xf                @ test if is user mode
    orreq   r1, r1, #0xf
    orr     r1, r1, #0xc0           @ disable interruptions
    mov     r2, lr                  @ r2 gets lr address
    msr     cpsr_c, r1              @ change cpsr mode
    stmia   r2!, {sp, lr}           @ save sp and lr
    msr     cpsr, r0                @ restore current cpsr

    and     r1, r1, #0x1f
    mrs     r1, spsr
    ldr     r0, pc_irq
    stmia   r2!, {r0 - r1}
    ldmfd   sp!, {pc}

change_process: nop
    ldr     r0, nproc
    cmp     r0, #1
    moveq   r0, #0
    movne   r0, #1
    str     r0, nproc
    bl      load_process_table

    add     r0, r0, #68             @ get last process table address
    ldmdb   r0!, {r1 - r2}          @ r1 = pc ; r2 = cpsr
    msr     spsr, r2
    mrs     r1, cpsr
    msr     cpsr_c, #0xd3
    ldmdb   r0!, {r13 - r14}        @ restore sp and lr
    msr     cpsr, r1

    mov     lr, r0                  @ lr gets r0 process table address
    ldmdb   lr!, {r0 - r12}         @ restore registers
    ldr     lr, [lr, #60]           @ put pc in lr
    stmfd   sp!, {lr}               @ stack lr in sp
    ldmfd   sp!, {pc}^              @ return from interruption

timer_init: nop
    ldr r0, INTEN
    ldr r1, =0x10   @ bit 4 for timer 0 interrupt enable
    str r1, [r0]
    ldr r0, TIMER0L
    ldr r1, =0xfff  @ setting timer value
    str r1,[r0]
    ldr r0, TIMER0C
    mov r1, #0xE0   @ enable timer module
    str r1, [r0]
    mrs r0, cpsr
    bic r0, r0, #0x80
    msr cpsr_c, r0  @ enabling interrupts in the cpsr
    mov pc, lr

nproc:      .word   0
pc_irq:     .word   0
cpsr_irq:   .word   0
linhaA:     .space  68
linhaB:     .space  68
