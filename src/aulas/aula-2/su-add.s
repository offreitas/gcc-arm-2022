	.section text, "ax"
       	.global main
main:
	LDR     r0, =0xFFFF0000      @ set up parameters
        LDR     r1, =0x87654321
        BL      firstfunc            @ call subroutine
        SWI     0x123456             @ terminate the program
firstfunc:
       	ADDS    r0, r0, r1           @ r0 = r0 + r1
       	MOV     pc, lr               @ return from subroutine
