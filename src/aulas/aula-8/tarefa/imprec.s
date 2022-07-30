	.file	"imprec.c"
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.text
.Ltext0:
	.align	2
	.global	main
	.type	main, %function
main:
.LFB2:
	.file 1 "imprec.c"
	.loc 1 9 0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
.LCFI0:
	stmfd	sp!, {fp, ip, lr, pc}
.LCFI1:
	sub	fp, ip, #4
.LCFI2:
	.loc 1 10 0
	pronto: nop
	
	.loc 1 15 0
	mov	r0, #149
	ldr	r1, .L2
	bl	int2str
	.loc 1 16 0
	ldr	r0, .L2
	bl	impstr
	.loc 1 18 0
	fim: nop
	
	.loc 1 23 0
	mov	r3, #0
	.loc 1 24 0
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	straluno
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%c\n\000"
	.text
	.align	2
	.global	impstr
	.type	impstr, %function
impstr:
.LFB3:
	.loc 1 27 0
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
.LCFI3:
	stmfd	sp!, {fp, ip, lr, pc}
.LCFI4:
	sub	fp, ip, #4
.LCFI5:
	sub	sp, sp, #4
.LCFI6:
	str	r0, [fp, #-16]
	.loc 1 29 0
	inic_imprime: nop
	
	.loc 1 35 0
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L5
	.loc 1 38 0
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r0, .L6
	mov	r1, r3
	bl	printf
	.loc 1 40 0
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	mov	r0, r3
	bl	impstr
.L5:
	.loc 1 44 0
	fim_imprime: nop
	
	.loc 1 50 0
	ldmfd	sp, {r3, fp, sp, pc}
.L7:
	.align	2
.L6:
	.word	.LC0
.LFE3:
	.size	impstr, .-impstr
	.comm	straluno,100,1
	.section	.debug_frame,"",%progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.byte	0xe
	.byte	0xc
	.uleb128 0xd
	.uleb128 0x0
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI0-.LFB2
	.byte	0xd
	.uleb128 0xc
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x8e
	.uleb128 0x2
	.byte	0x8d
	.uleb128 0x3
	.byte	0x8b
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xc
	.uleb128 0xb
	.uleb128 0x4
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI3-.LFB3
	.byte	0xd
	.uleb128 0xc
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x8d
	.uleb128 0x3
	.byte	0x8b
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xc
	.uleb128 0xb
	.uleb128 0x4
	.align	2
.LEFDE2:
	.text
.Letext0:
	.section	.debug_info
	.4byte	0x157
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.Ldebug_line0
	.4byte	.Letext0
	.4byte	.Ltext0
	.ascii	"GNU C 3.4.3\000"
	.byte	0x1
	.ascii	"imprec.c\000"
	.ascii	"/home/student/src/aulas/aula-8/tarefa\000"
	.uleb128 0x2
	.4byte	.LASF0
	.byte	0x4
	.byte	0x7
	.uleb128 0x3
	.ascii	"long int\000"
	.byte	0x4
	.byte	0x5
	.uleb128 0x3
	.ascii	"long long int\000"
	.byte	0x8
	.byte	0x5
	.uleb128 0x3
	.ascii	"int\000"
	.byte	0x4
	.byte	0x5
	.uleb128 0x3
	.ascii	"unsigned int\000"
	.byte	0x4
	.byte	0x7
	.uleb128 0x2
	.4byte	.LASF0
	.byte	0x4
	.byte	0x7
	.uleb128 0x3
	.ascii	"unsigned char\000"
	.byte	0x1
	.byte	0x8
	.uleb128 0x3
	.ascii	"short int\000"
	.byte	0x2
	.byte	0x5
	.uleb128 0x4
	.byte	0x4
	.4byte	0xba
	.uleb128 0x3
	.ascii	"char\000"
	.byte	0x1
	.byte	0x8
	.uleb128 0x3
	.ascii	"short unsigned int\000"
	.byte	0x2
	.byte	0x7
	.uleb128 0x3
	.ascii	"long long unsigned int\000"
	.byte	0x8
	.byte	0x7
	.uleb128 0x5
	.byte	0x1
	.ascii	"main\000"
	.byte	0x1
	.byte	0x9
	.4byte	0x78
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5b
	.uleb128 0x6
	.4byte	0x133
	.byte	0x1
	.ascii	"impstr\000"
	.byte	0x1
	.byte	0x1b
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5b
	.uleb128 0x7
	.ascii	"pont\000"
	.byte	0x1
	.byte	0x1a
	.4byte	0xb4
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.byte	0x0
	.uleb128 0x8
	.4byte	0x143
	.4byte	0xba
	.uleb128 0x9
	.4byte	0x8f
	.byte	0x63
	.byte	0x0
	.uleb128 0xa
	.ascii	"straluno\000"
	.byte	0x1
	.byte	0x6
	.4byte	0x133
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	straluno
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x2f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x15b
	.4byte	0xf2
	.ascii	"main\000"
	.4byte	0x109
	.ascii	"impstr\000"
	.4byte	0x143
	.ascii	"straluno\000"
	.4byte	0x0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,"",%progbits
.LASF0:
	.ascii	"long unsigned int\000"
	.ident	"GCC: (GNU) 3.4.3"
