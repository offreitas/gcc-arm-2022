	.section .text, "ax"
	.global main
main:
      	LDR r0, =0xF631024C       @ set up parameters
      	LDR r1, =11261249
      	BL  swap                 @ call subroutine
fim:
      	SWI 0x123456             @ terminate the program
swap:
      	EOR r0, r0, r1
	EOR r1, r0, r1
	EOR r0, r0, r1
      	MOV pc, lr               @ return from subroutine
