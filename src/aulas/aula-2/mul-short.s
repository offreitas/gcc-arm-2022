	.section text, "ax"
       	.global main
main:
	LDR     r0, =2		@ set up parameters
        BL      firstfunc       @ call subroutine
        SWI     0x123456        @ terminate the program
firstfunc:
       	MOV   	r1, r0, LSL #5	@ r2 = r0 * 32
       	MOV     pc, lr          @ return from subroutine
