	.section .text, "ax"
	.global main
main:
	ldr r12, =15              	@ set up parameters
	ldr r3, =1
	bl  firstfunc            	@ call subroutine
	swi 0x123456             	@ terminate the program
firstfunc:
	sub r11, r12, r3, lsl #32	@ r11 = r12 - r3 lsl 32 ERROR
	mov pc, lr               	@ return from subroutine
