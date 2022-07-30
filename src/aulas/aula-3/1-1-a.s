	.section .text, "ax"
	.global main
main:
	ldr r7, =20
	bl  firstfunc            @ call subroutine
	swi 0x123456             @ terminate the program
firstfunc:
	add r3, r7, #1024        @ r3 = r7 + 1023 ERROR
	mov pc, lr               @ return from subroutine
