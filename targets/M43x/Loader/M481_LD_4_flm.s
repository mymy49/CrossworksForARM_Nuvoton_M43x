	.syntax unified

	.section PrgCode,"ax",%progbits
	.balign 4
	.thumb_func
Delay:
	push {r0, lr}
	nop
.LPrgCode0:
	ldr r0, [sp]
	subs r1, r0, #1
	str r1, [sp]
	cmp r0, #0
	bne .LPrgCode0
	pop {r3, pc}

	.global Init
	.thumb_func
Init:
	push.w {r4-r8, lr}
	mov r6, r0
	mov r7, r1
	mov r8, r2
	movs r5, #0x64
	movs r0, #0x59
	ldr r1, .LPrgCode1
	str r0, [r1]
	movs r0, #22
	lsls r1, r1, #22
	str.w r0, [r1, #0x0100]
	movs r0, #0x88
	str.w r0, [r1, #0x0100]
	lsls r0, r0, #27
	ldr.w r0, [r0, #0x0100]
	and r0, r0, #1
	cbnz r0, .LPrgCode2
	movs r0, #1
.LPrgCode9:
	pop.w {r4-r8, pc}
.LPrgCode2:
	ldr r0, .LPrgCode3
	ldr r0, [r0]
	orr r0, r0, #4
	mov.w r1, #0x40000000
	str.w r0, [r1, #0x0200]
	mov r0, r1
	ldr.w r0, [r0, #0x0204]
	orr r0, r0, #4
	str.w r0, [r1, #0x0204]
	movs r0, #0x80
	bl Delay
	mov.w r0, #0x40000000
	ldr.w r0, [r0, #0x01F4]
	ldr r1, .LPrgCode4
	add r1, r9
	strb r0, [r1]
	ldr r0, .LPrgCode5
	mov.w r1, #0x40000000
	str.w r0, [r1, #0x0240]
	nop
.LPrgCode6:
	ldr r0, .LPrgCode3
	adds r0, #0x50
	ldr r0, [r0]
	and r0, r0, #4
	cmp r0, #0
	beq .LPrgCode6
	ldr r0, .LPrgCode3
	adds r0, #16
	ldr r4, [r0]
	bic r4, r4, #7
	orr r0, r4, #2
	mov.w r1, #0x40000000
	str.w r0, [r1, #0x0210]
	mov.w r0, #0x0300
	bl Delay
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x21
	ldr r1, .LPrgCode7
	str r0, [r1]
	mov r0, r1
	ldr r0, [r0, #28]
	orr r0, r0, #1
	str r0, [r1, #28]
	mov r0, r1
	ldr r0, [r0]
	and r0, r0, #1
	cbnz r0, .LPrgCode8
	movs r0, #1
	b .LPrgCode9
.LPrgCode8:
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	and r0, r0, #32
	cbnz r0, .LPrgCode10
	movs r0, #1
	b .LPrgCode9
.LPrgCode10:
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r1, .LPrgCode7
	str r0, [r1]
	movs r0, #0
	b .LPrgCode9

	.global UnInit
	.thumb_func
UnInit:
	mov r1, r0
	nop
.LPrgCode11:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode11
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	bic r0, r0, #0x21
	ldr r2, .LPrgCode7
	str r0, [r2]
	mov r0, r2
	ldr r0, [r0, #28]
	bic r0, r0, #1
	str r0, [r2, #28]
	ldr r0, .LPrgCode3
	adds r0, #16
	ldr r0, [r0]
	orr r0, r0, #7
	mov.w r2, #0x40000000
	str.w r0, [r2, #0x0210]
	movs r0, #0
	bx lr

	.global BlankCheck
	.thumb_func
BlankCheck:
	mov r3, r0
	movs r0, #1
	bx lr

	.global PageErase
	.thumb_func
PageErase:
	mov r2, r0
	nop
.LPrgCode12:
	ldr r0, .LPrgCode7
	adds r0, #0xC0
	ldr r0, [r0]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode12
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r3, .LPrgCode7
	str r0, [r3]
	movs r0, #0x22
	str r0, [r3, #12]
	mov r0, r3
	str r2, [r0, #4]
	cbnz r1, .LPrgCode13
	mov.w r0, #0xFFFFFFFF
	str r0, [r3, #8]
	b .LPrgCode14
.LPrgCode13:
	ldr r0, .LPrgCode15
	ldr r3, .LPrgCode7
	str r0, [r3, #8]
.LPrgCode14:
	movs r0, #1
	ldr r3, .LPrgCode7
	str r0, [r3, #16]
	isb
	nop
.LPrgCode16:
	ldr r0, .LPrgCode7
	adds r0, #0xC0
	ldr r0, [r0]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode16
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	and r0, r0, #0x40
	cbz r0, .LPrgCode17
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r3, .LPrgCode7
	str r0, [r3]
	movs r0, #1
.LPrgCode18:
	bx lr
.LPrgCode17:
	movs r0, #0
	b .LPrgCode18

	.global EraseSector
	.thumb_func
EraseSector:
	push {r4, lr}
	mov r4, r0
	and r0, r4, #0xF00000
	cmp.w r0, #0x200000
	bne .LPrgCode19
	ldr r0, .LPrgCode4
	add r0, r9
	ldrb r0, [r0]
	cbz r0, .LPrgCode20
	sub.w r0, r4, #0x200000
	movs r1, #1
	bl PageErase
.LPrgCode21:
	pop {r4, pc}
.LPrgCode20:
	movs r1, #1
	mov r0, r4
	bl PageErase
	b .LPrgCode21
.LPrgCode19:
	movs r1, #0
	mov r0, r4
	bl PageErase
	b .LPrgCode21

	.global EraseBlock
	.thumb_func
EraseBlock:
	mov r1, r0
	nop
.LPrgCode22:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode22
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r2, .LPrgCode7
	str r0, [r2]
	movs r0, #0x25
	str r0, [r2, #12]
	mov r0, r2
	str r1, [r0, #4]
	cmp.w r1, #0x200000
	bne .LPrgCode23
	ldr r0, .LPrgCode15
	str r0, [r2, #8]
.LPrgCode23:
	movs r0, #1
	ldr r2, .LPrgCode7
	str r0, [r2, #16]
	isb
	nop
.LPrgCode24:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode24
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	and r0, r0, #0x40
	cbz r0, .LPrgCode25
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r2, .LPrgCode7
	str r0, [r2]
	movs r0, #1
.LPrgCode26:
	bx lr
.LPrgCode25:
	movs r0, #0
	b .LPrgCode26

	.global EraseSectorEx
	.thumb_func
EraseSectorEx:
	push {r4-r7, lr}
	mov r5, r0
	mov r6, r1
	movs r4, #0
	b .LPrgCode27
.LPrgCode32:
	ldr r0, .LPrgCode4
	add r0, r9
	ldrb r0, [r0]
	cbnz r0, .LPrgCode28
	ldrh.w r0, [r5, r4, lsl #2]
	ubfx r0, r0, #0, #14
	cbnz r0, .LPrgCode28
	subs r0, r6, r4
	cmp r0, #4
	bcc .LPrgCode28
	ldr.w r0, [r5, r4, lsl #2]
	bl EraseBlock
	subs r7, r0, #0
	beq .LPrgCode29
	mov r0, r7
.LPrgCode31:
	pop {r4-r7, pc}
.LPrgCode29:
	adds r4, r4, #4
	b .LPrgCode27
.LPrgCode28:
	ldr.w r0, [r5, r4, lsl #2]
	bl EraseSector
	subs r7, r0, #0
	beq .LPrgCode30
	mov r0, r7
	b .LPrgCode31
.LPrgCode30:
	adds r4, r4, #1
.LPrgCode27:
	cmp r4, r6
	bcc .LPrgCode32
	movs r0, #0
	b .LPrgCode31
	.thumb_func
FMC_MultiProgram:
	push {r4-r6, lr}
	mov r4, r0
	mov r3, r1
	mov r5, r2
	movs r2, #0
	mov r1, r5
	add.w r0, r3, #15
	bic r3, r0, #15
	nop
.LPrgCode33:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode33
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r6, .LPrgCode7
	str r0, [r6]
	bic r0, r4, #15
	str r0, [r6, #4]
	movs r0, #0x27
	str r0, [r6, #12]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	adds r6, #0x80
	str r0, [r6]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	str.w r0, [r6, #0x84]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	adds r6, #0x88
	str r0, [r6]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	adds r6, r6, #4
	str r0, [r6]
	movs r0, #1
	ldr r6, .LPrgCode7
	str r0, [r6, #16]
	subs r3, #16
	b .LPrgCode34
.LPrgCode37:
	nop
.LPrgCode35:
	ldr r0, .LPrgCode7
	adds r0, #0xC0
	ldr r0, [r0]
	and r0, r0, #0x30
	cmp r0, #0
	bne .LPrgCode35
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	adds r6, #0x80
	str r0, [r6]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	str.w r0, [r6, #0x84]
	nop
.LPrgCode36:
	ldr r0, .LPrgCode7
	adds r0, #0xC0
	ldr r0, [r0]
	and r0, r0, #0xC0
	cmp r0, #0
	bne .LPrgCode36
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	adds r6, #0x88
	str r0, [r6]
	mov r0, r2
	adds r2, r2, #1
	ldr.w r0, [r1, r0, lsl #2]
	ldr r6, .LPrgCode7
	str.w r0, [r6, #0x8C]
	subs r3, #16
.LPrgCode34:
	cmp r3, #0
	bne .LPrgCode37
	nop
.LPrgCode38:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode38
	pop {r4-r6, pc}
	.thumb_func
FMC_WordProgram:
	push {r4, lr}
	mov r3, r0
	adds r0, r1, #3
	bic r1, r0, #3
	nop
.LPrgCode39:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode39
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r4, .LPrgCode7
	str r0, [r4]
	movs r0, #0x21
	str r0, [r4, #12]
	b .LPrgCode40
.LPrgCode43:
	bic r0, r3, #3
	ldr r4, .LPrgCode7
	str r0, [r4, #4]
	ldr r0, [r2]
	str r0, [r4, #8]
	movs r0, #1
	str r0, [r4, #16]
	isb
	nop
.LPrgCode41:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode41
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	and r0, r0, #0x40
	cbz r0, .LPrgCode42
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r4, .LPrgCode7
	str r0, [r4]
	movs r0, #1
.LPrgCode44:
	pop {r4, pc}
.LPrgCode42:
	adds r3, r3, #4
	adds r2, r2, #4
	subs r1, r1, #4
.LPrgCode40:
	cmp r1, #0
	bne .LPrgCode43
	movs r0, #0
	b .LPrgCode44

	.global ProgramPage
	.thumb_func
ProgramPage:
	push.w {r4-r10, lr}
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov.w r8, #0
	mov r10, r8
	nop
.LPrgCode45:
	ldr r0, .LPrgCode7
	ldr r0, [r0, #16]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode45
	ldr r0, .LPrgCode7
	ldr r0, [r0]
	orr r0, r0, #0x40
	ldr r1, .LPrgCode7
	str r0, [r1]
	adds r0, r4, #3
	bic r4, r0, #3
	b .LPrgCode46
.LPrgCode1:
	.word 0x40000100
.LPrgCode3:
	.word 0x40000200
.LPrgCode4:
	.word 0x00000004
.LPrgCode5:
	.word 0x0008421E
.LPrgCode7:
	.word 0x4000C000
.LPrgCode15:
	.word 0x0055AA03
.LPrgCode50:
	ubfx r0, r5, #0, #9
	cbnz r0, .LPrgCode47
	cmp.w r4, #0x0200
	bcc .LPrgCode47
	mov.w r7, #0x0200
	add.w r2, r6, r8
	mov r1, r7
	mov r0, r5
	bl FMC_MultiProgram
	mov r10, r0
	b .LPrgCode48
.LPrgCode47:
	ubfx r0, r5, #0, #9
	cbnz r0, .LPrgCode49
	cmp r4, #16
	bcc .LPrgCode49
	bic r7, r4, #15
	add.w r2, r6, r8
	mov r1, r7
	mov r0, r5
	bl FMC_MultiProgram
	mov r10, r0
	b .LPrgCode48
.LPrgCode49:
	mov r7, r4
	add.w r2, r6, r8
	mov r1, r7
	mov r0, r5
	bl FMC_WordProgram
	mov r10, r0
.LPrgCode48:
	add r5, r7
	add r8, r7
	subs r4, r4, r7
	cmp.w r10, #0
	beq .LPrgCode46
	movs r0, #1
.LPrgCode51:
	pop.w {r4-r10, pc}
.LPrgCode46:
	cmp r4, #0
	bne .LPrgCode50
	movs r0, #0
	b .LPrgCode51

	.global Verify
	.thumb_func
Verify:
	push {r4, lr}
	adds r3, r1, #3
	bic r1, r3, #3
	nop
.LPrgCode53:
	ldr r3, .LPrgCode52
	ldr r3, [r3, #16]
	and r3, r3, #1
	cmp r3, #0
	bne .LPrgCode53
	ldr r3, .LPrgCode52
	ldr r3, [r3]
	orr r3, r3, #0x40
	ldr r4, .LPrgCode52
	str r3, [r4]
	movs r3, #0
	str r3, [r4, #12]
	b .LPrgCode54
.LPrgCode59:
	bic r3, r0, #3
	ldr r4, .LPrgCode52
	str r3, [r4, #4]
	movs r3, #0
	str r3, [r4, #8]
	movs r3, #1
	str r3, [r4, #16]
	isb
	nop
.LPrgCode55:
	ldr r3, .LPrgCode52
	ldr r3, [r3, #16]
	and r3, r3, #1
	cmp r3, #0
	bne .LPrgCode55
	ldr r3, .LPrgCode52
	ldr r3, [r3]
	and r3, r3, #0x40
	cbz r3, .LPrgCode56
	ldr r3, .LPrgCode52
	ldr r3, [r3]
	orr r3, r3, #0x40
	ldr r4, .LPrgCode52
	str r3, [r4]
.LPrgCode58:
	pop {r4, pc}
.LPrgCode56:
	ldr r3, .LPrgCode52
	ldr r3, [r3, #8]
	ldr r4, [r2]
	cmp r3, r4
	beq .LPrgCode57
	b .LPrgCode58
.LPrgCode57:
	adds r0, r0, #4
	adds r2, r2, #4
	subs r1, r1, #4
.LPrgCode54:
	cmp r1, #0
	bne .LPrgCode59
	nop
	b .LPrgCode58

	.global KeyCompare
	.thumb_func
KeyCompare:
	push {r4, lr}
	mov r3, r0
	ldr r0, .LPrgCode52
	ldr r0, [r0, #0x60]
	and r0, r0, #2
	cbz r0, .LPrgCode60
	ldr r0, .LPrgCode52
	str r3, [r0, #0x50]
	str r1, [r0, #0x54]
	str r2, [r0, #0x58]
	movs r0, #1
	ldr r4, .LPrgCode52
	str r0, [r4, #0x5C]
	nop
.LPrgCode61:
	ldr r0, .LPrgCode52
	ldr r0, [r0, #0x60]
	and r0, r0, #1
	cmp r0, #0
	bne .LPrgCode61
.LPrgCode60:
	ldr r0, .LPrgCode52
	ldr r0, [r0, #0x60]
	and r0, r0, #4
	cbnz r0, .LPrgCode62
	movs r0, #2
.LPrgCode64:
	pop {r4, pc}
.LPrgCode62:
	ldr r0, .LPrgCode52
	ldr r0, [r0, #0x60]
	and r0, r0, #2
	cbz r0, .LPrgCode63
	movs r0, #1
	b .LPrgCode64
.LPrgCode63:
	movs r0, #0
	b .LPrgCode64
	.short 0x0000
.LPrgCode52:
	.word 0x4000C000

	.section PrgData,"aw",%progbits
	.balign 4
.LPrgData2:
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
