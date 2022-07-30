.global _start
.text

_start:
    b _Reset                        @ Posição 0x00 - Reset
    ldr pc, _undefined_instruction  @ Posição 0x04 - Intrução não-definida
    ldr pc, _software_interrupt     @ Posição 0x08 - Interrupção de Software
    ldr pc, _prefetch_abort         @ Posição 0x0C - Prefetch Abort
    ldr pc, _data_abort             @ Posição 0x10 - Data Abort
    ldr pc, _not_used               @ Posição 0x14 - Não utilizado
    ldr pc, _irq                    @ Posição 0x18 - Interrupção (IRQ)
    ldr pc, _fiq                    @ Posição 0x1C - Interrupção(FIQ)

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
    ldr sp, =stack_top
    mrs r0, cpsr
    msr cpsr_c, #0xd2
    ldr sp, =irq_stack_top
    msr cpsr, r0
    bl  main
    b .
undefined_instruction:
    b .
software_interrupt:
    b do_software_interrupt @ Vai para o handler de interrupções de software
prefetch_abort:
    b .
data_abort:
    b .
not_used:
    b .
irq:
    b do_irq_interrupt @ Vai para o handler de interrupções IRQ
fiq:
    b .
do_software_interrupt:
    add r1, r2, r3 @ r1 = r2 + r3
    mov pc, lr @ Volta p/ o endereço armazenado em lr
@Rotina de interrupções IRQ
do_irq_interrupt: nop
    stmfd   sp!, {r0 - r12}         @ save r0 - r12 in IRQ sp
    ldr     r0, =linhaA             @ load linhaA address
    ldmfd   sp!, {r1}               @ load r0 value from IRQ sp in r1
    str     r1, [r0]                @ store r0 value in linhaA
    ldmfd   sp!, {r1 - r12}         @ load r1 - r12 values
    add     r0, r0, #4              @ next linhaA address
    stm     r0, {r1 - r12}          @ store in linhaA r1 - r12 values

    ldr     r0, =pc_irq             @ load pc_irq variable address
    sub     lr, lr, #4              @ get previous process pc
    str     lr, [r0]                @ save previous process pc in pc_irq variable

    mrs     r2, cpsr
    mrs     r0, spsr                @ get supervisor mode cpsr
    orr     r0, r0, #0x80           @ disable interruptions
    ldr     r1, =cpsr_irq
    str     r0, [r1]
    msr     cpsr, r0                @ copy spsr with disabled interruptions to cpsr

    ldr     r0, =linhaA             @ load linhaA address
    add     r0, r0, #52             @ get fourteenth word address at linhaA
    stmia   r0!, {r13 - r14}        @ save r13 - r14 starting from the third address at linhaA
    msr     cpsr, r2                @ restore interruption cpsr
    ldr     r1, pc_irq              @ load pc IRQ
    str     r1, [r0], #4            @ save pc IRQ at sixteenth address at linhaA
    ldr     r1, cpsr_irq            @ get supervisor mode cpsr
    str     r1, [r0]                @ store supervisor mode cpsr at linhaA

    ldr     r0, INTPND              @ load interruption status register
    ldr     r0, [r0]
    tst     r0, #0x0010             @ verify if is a timer interruption
    blne    handler_timer           @ branch to interruption handler timer routine

    ldr     lr, =linhaA             @ load linhaA address
    ldmia   lr!, {r0 - r12}         @ restore registers
    stmfd   sp!, {r0 - r12}         @ stack restored registers
    ldr     r0, =linhaA             @ load linhaA address
    add     r0, r0, #56             @ load lr value
    ldr     lr, [r0], #4            @ store lr value in lr
    ldr     r1, [r0]                @ load pc value
    str     r1, [sp, #52]           @ stack pc value
    ldmfd   sp!, {r0 - r12, pc}^    @ return

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

main:
    bl entry
    bl timer_init @ initialize interrupts and timer 0
loop:
    bl idle
    b  loop

pc_irq:     .word   0
cpsr_irq:   .word   0
linhaA:     .space  100
