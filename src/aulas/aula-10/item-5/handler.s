.global handler_timer
.text

TIMER0X: .word 0x101E200c   @ Timer 0 interrupt clear register

handler_timer: 
    stmfd   sp!, {r0 - r12, lr}
    ldr     r0, TIMER0X
    mov     r1, #0x0
    str     r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção
    @ Inserir código que sera executado na interrupção de timer aqui (chaveamento de processos, ou alternar LED por exemplo)
    ldmfd   sp!, {r0 - r12, pc}^ @ Retorna
