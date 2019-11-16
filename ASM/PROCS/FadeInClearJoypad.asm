
procFadeInClearJoypad .dstruct structProcInfo, None, rlProcFadeInClearJoypadInit, rlProcFadeInClearJoypadOnCycle, None ; 81/C4BD

rlProcFadeInClearJoypadInit ; 81/C4C5

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcBody0,b,x
	rtl

rlProcFadeInClearJoypadOnCycle ; 81/C4C9

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda aProcBody0,b,x
	tax
	sep #$20
	lda _FadeInTable,x
	bmi +

	sta bBuf_INIDISP
	rep #$30
	stz wJoy1New
	stz wJoy1Alt
	stz wJoy1Input
	plx

	lda aProcBody0,b,x
	inc a
	sta aProcBody0,b,x
	rtl

	+
	rep #$30
	plx
	jsl rlProcEngineFreeProc
	rtl

	_FadeInTable ; 81/C4F1
		.byte INIDISP_Setting(False, 0)
		.byte INIDISP_Setting(False, 0)
		.for i in range(16)
			.byte INIDISP_Setting(False, i)
		.next
		.char -1

procFadeInAfterSound .dstruct structProcInfo, None, rlProcFadeInClearJoypadInit, rlProcFadeInAfterSoundOnCycle, None ; 81/C504

rlProcFadeInAfterSoundOnCycle ; 81/C50C

	.al
	.xl
	.autsiz
	.databank ?

	lda aUnknown0004BA,b
	ora wUnknown0004F4,b
	and #$00FF
	beq +

	rtl

	+
	lda #$0003
	sta aProcBody0,b,x
	lda #<>rlProcFadeInClearJoypadOnCycle
	sta aProcHeaderOnCycle,b,x
	rtl
