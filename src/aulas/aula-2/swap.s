	.text
	.global main
main:
	ldr r0, =0xF631024C      @ set up parameters
	ldr r1, =0x17539ABD
	bl  swap                 @ call subroutine
	swi 0x123456             @ terminate the program
swap:
	eor r0, r0, r1
	eor r1, r0, r1
	eor r0, r0, r1
	mov pc, lr               @ return from subroutine
