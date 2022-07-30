.global _start
.text

@
@ VETOR DE INTERRUPÇÕES
@
_start: nop
    b   _Reset                      @ Posição 0x00 - Reset
    ldr pc, _undefined_instruction  @ Posição 0x04 - Intrução não-definida
    ldr pc, _software_interrupt     @ Posição 0x08 - Interrupção de Software
    ldr pc, _prefetch_abort         @ Posição 0x0C - Prefetch Abort
    ldr pc, _data_abort             @ Posição 0x10 - Data Abort
    ldr pc, _not_used               @ Posição 0x14 - Não utilizado
    ldr pc, _irq                    @ Posição 0x18 - Interrupção (IRQ)
    ldr pc, _fiq                    @ Posição 0x1C - Interrupção(FIQ)

_undefined_instruction: nop
    .word undefined_instruction
_software_interrupt: nop
    .word software_interrupt
_prefetch_abort: nop
    .word prefetch_abort
_data_abort: nop
    .word data_abort
_not_used: nop
    .word not_used
_irq: nop
    .word irq
_fiq: nop
    .word fiq

@
@ CONSTANTES
@
INTPND:     .word 0x10140000 @ Interrupt status register
INTSEL:     .word 0x1014000C @ Interrupt select register( 0 = irq, 1 = fiq)
INTEN:      .word 0x10140010 @ Interrupt enable register
TIMER0L:    .word 0x101E2000 @ Timer 0 load register
TIMER0V:    .word 0x101E2004 @ Timer 0 value registers
TIMER0C:    .word 0x101E2008 @ Timer 0 control register
TIMER0X:    .word 0x101E200c @ Timer 0 interrupt clear register

@
@ TRATAMENTO DE INTERRUPÇÕES
@
_Reset: nop
    mrs r0, cpsr
    msr cpsr_ctl, #0b11011010   @ IRQ Mode
    ldr sp, =irq_stack_top
    msr cpsr, r0
    ldr sp, =stack_top
    bl  do_irq_interrupt
    b .

undefined_instruction: nop
    b .

software_interrupt: nop
    b do_software_interrupt @ Vai para o handler de interrupções de software

prefetch_abort: nop
    b .

data_abort: nop
    b .

not_used: nop
    b .

irq: nop
    b do_irq_interrupt @ Vai para o handler de interrupções IRQ

fiq: nop
    b .

@ Rotina de Interrupção de software
do_software_interrupt: nop
    add r1, r2, r3  @ r1 = r2 + r3
    mov pc, lr     @ Volta p/ o endereço armazenado em lr

@ Rotina de interrupções IRQ
do_irq_interrupt: nop
    stmfd   sp!, {r0 - r3, lr}  @ Empilha os registradores
    ldr     r0, INTPND          @ Carrega o registrador de status de interrupção
    ldr     r0, [r0]
    tst     r0, #0x0010         @ Verifica se é uma interupção de timer
    bne     handler_timer       @ Vai para o rotina de tratamento da interupção de timer
    ldmfd   sp!, {r0 - r3, lr}  @ Retorna
    mov     pc, lr
    
handler_timer: nop
    ldr     r0, TIMER0X
    mov     r1, #0x0
    str     r1, [r0]            @ Escreve no registrador TIMER0X para limpar o pedido de interrupção

    @ Inserir código que sera executado na interrupção
    @ de timer aqui (chaveamento de processos,
    @ ou alternar LED por exemplo)

    ldmfd   sp!, {r0 - r3, lr}
    mov     pc, lr             @ Retorna

@
@ INICIALIZAÇÃO DO TIMER
@
timer_init: nop
    mrs     r0, cpsr
    bic     r0,r0,#0x80
    msr     cpsr_c,r0       @ Enabling interrupts in the cpsr
    ldr     r0, INTEN
    ldr     r1,=0x10        @ Bit 4 for timer 0 interrupt enable
    str     r1,[r0]
    ldr     r0, TIMER0C
    ldr     r1, [r0]
    mov     r1, #0xA0       @ Enable timer module
    str     r1, [r0]
    ldr     r0, TIMER0V
    mov     r1, #0xff       @ Setting timer value
    str     r1,[r0]
    mov     pc, lr

main: nop
    bl timer_init @ Initialize interrupts and timer 0
stop: nop 
    b stop
