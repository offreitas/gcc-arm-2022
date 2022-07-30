	.section .text, "ax"
	.global main
main:
      	MOV r0, #15              @ set up parameters
      	MOV r1, #20
      	BL  firstfunc            @ call subroutine
      	MOV r0, #0x18            @
      	LDR r1, =0x20026         @
      	SWI 0x123456             @ terminate the program
firstfunc:
      	ADD r0, r0, r1           @ r0 = r0 + r1
      	MOV pc, lr               @ return from subroutine
