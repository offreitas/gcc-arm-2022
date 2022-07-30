	.section text, "ax"
       	.global main
main:
	LDR     r0, =0xFFFFFFFF      @ set up parameters
        LDR     r1, =0x80000000
        BL      firstfunc            @ call subroutine
        SWI     0x123456             @ terminate the program
firstfunc:
       	MULS    r2, r0, r1           @ r2 = r0 * r1
       	MOV     pc, lr               @ return from subroutine
