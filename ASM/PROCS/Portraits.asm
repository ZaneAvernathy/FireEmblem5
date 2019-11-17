
procPortrait0 .dstruct structProcInfo, (0, "@"), rlProcPortraitInit, rlProcPortraitOnCycle, aProcPortraitCode ; 82/902B
procPortrait1 .dstruct structProcInfo, (1, "@"), rlProcPortraitInit, rlProcPortraitOnCycle, aProcPortraitCode ; 82/9033
procPortrait2 .dstruct structProcInfo, (2, "@"), rlProcPortraitInit, rlProcPortraitOnCycle, aProcPortraitCode ; 82/903B
procPortrait3 .dstruct structProcInfo, (3, "@"), rlProcPortraitInit, rlProcPortraitOnCycle, aProcPortraitCode ; 82/9043

rlProcPortraitInit ; 82/904B

	.al
	.xl
	.autsiz
	.databank ?

	; Portrait slot

	lda wProcInput0,b
	sta aProcBody0,b,x

	; Coordinates in tiles, packed (Y << 8) | X

	lda wProcInput1,b
	sta aProcBody1,b,x

	; Portrait ID

	lda wProcInput2,b
	sta aProcBody3,b,x

	; Fade-in flag?

	lda wProcInput3,b
	sta aProcBody6,b,x

	lda #$0000
	sta aProcBody4,b,x

	; X to pixels

	lda wProcInput1,b
	pha
	and #$00FF
	asl a
	asl a
	asl a
	sta wR0

	; Y to pixels

	pla
	xba
	and #$00FF
	asl a
	asl a
	asl a

	; Result is coordinates in pixels, packed (Y << 8) | X

	xba
	ora wR0
	sta aProcBody2,b,x

	; Display flag?

	ldy #$0000
	lda wUnknown001836,b
	cmp #$0001
	beq +

	inc y

	+
	tya
	sta aProcBody5,b,x

rlProcPortraitOnCycle ; 82/9093

	.al
	.xl
	.autsiz
	.databank ?

	; Wait until decomp list is free

	lda bDecompListFlag,b
	and #$00FF
	bne _End

	; Portrait slot

	lda aProcBody0,b,x
	sta wR1

	; Portrait ID

	lda aProcBody3,b,x
	pha

	; Copy portrait and fetch palette

	jsl rlCopyPortraitToBuffer

	pla
	jsl rlGetPortraitPalettePointerByIndex

	; Check if fading in

	lda aProcBody6,b,x
	beq _NoFade

	; Copy palette to $7E4BF8

	lda #(`$7E4BF8)<<8
	sta lR19+1
	lda #<>$7E4BF8
	sta lR19

	lda #$0020
	sta wR20

	jsl rlBlockCopy

	lda #(`aBGPal0)<<8
	sta lR18+1
	lda #<>aBGPal0
	sta lR18

	; Display flag?

	lda aProcBody5,b,x
	sta wR1

	; Portrait slot

	lda aProcBody0,b,x
	jsl rlGetPortraitPaletteBufferPointer

	; Clear palette slot

	lda lR19+1
	sta lR18+1
	lda lR19
	sta lR18

	lda #$0020
	sta wR19

	lda #$0000
	jsl rlBlockFillWord
	bra _9106

	_NoFade

	; Normal palette stuff?

	; Display flag?

	lda aProcBody5,b,x
	sta wR1

	; Portrait slot

	lda aProcBody0,b,x
	jsl rlGetPortraitPaletteBufferPointer

	; Copy palette to slot

	lda #$0020
	sta wR20

	jsl rlBlockCopy

	_9106
	lda #<>rlProcPortraitOnCycle2
	sta aProcHeaderOnCycle,b,x

	_End
	rtl

rlProcPortraitOnCycle2 ; 82/910D

	.al
	.xl
	.autsiz
	.databank ?

	; Loop here until portrait is decompressed

	lda bDecompListFlag,b
	and #$00FF
	beq +

	rtl

	+
	lda #<>rlProcPortraitOnCycle3
	sta aProcHeaderOnCycle,b,x

rlProcPortraitOnCycle3 ; 82/911C

	.al
	.xl
	.autsiz
	.databank ?

	lda bDMAArrayFlag,b
	and #$00FF
	bne _End

	; Display flag?

	lda aProcBody5,b,x
	sta wR0

	; Portrait slot

	lda aProcBody0,b,x

	jsl rlDMAPortraitFromBuffer

	; Check if displaying?

	lda aProcBody5,b,x
	beq _Invisible

	lda #<>rlProcPortraitOnCycle4c
	sta aProcHeaderOnCycle,b,x

	; Check if fading in

	lda aProcBody6,b,x
	beq _End

	lda #<>rlProcPortraitOnCycle4bFadingIn
	sta aProcHeaderOnCycle,b,x
	bra _End

	_Invisible
	lda #<>rlProcPortraitOnCycle4aInvisible
	sta aProcHeaderOnCycle,b,x

	_End
	rtl

rlProcPortraitOnCycle4aInvisible ; 82/914F

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody1,b,x
	sta wR0
	lda aProcBody0,b,x
	jsl rlUnknown8CC176
	lda #<>rlProcPortraitOnCycle4bFadingIn
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcPortraitOnCycle4bFadingIn ; 82/9162

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsProcPortraitRenderPortrait
	jsr rsUnknow8291D8
	bcc +

	jsl $959637
	lda #<>rlProcPortraitOnCycle4c
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcPortraitOnCycle4c ; 82/9175

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown82931A
	lda aProcBody4,b,x
	beq +

	lda aProcBody6,b,x
	beq rlProcPortraitOnCycle5._FreeProc

	lda #<>rlProcPortraitOnCycle5
	sta aProcHeaderOnCycle,b,x

	+
	jsr rsProcPortraitRenderPortrait
	rtl

rlProcPortraitOnCycle5 ; 82/918C

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsProcPortraitRenderPortrait
	jsr rsUnknown82926E
	bcc _End

	lda aProcBody5,b,x
	bne _FreeProc

	; Coordinates

	lda aProcBody1,b,x
	sta wR0

	; slot

	lda aProcBody0,b,x
	jsl rlUnknown8CC43F

	_FreeProc
	jsl rlProcEngineFreeProc

	_End
	rtl

aProcPortraitCode ; 82/91AA
	PROC_HALT

rsProcPortraitRenderPortrait ; 82/91AC

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody5,b,x
	beq +

	; Coordinates in pixels

	lda aProcBody2,b,x
	and #$00FF
	sta wR0

	lda aProcBody2,b,x
	xba
	and #$00FF
	sta wR1

	jsl rlUnknown829352
	tay
	lda aProcBody0,b,x
	jsl rlDrawPortraitSprite

	lda #TM.OBJEnable
	tsb bBuf_TM

	+
	rts

aUnknown8291D4 ; 82/91D4
	.word $0000, $0019

rsUnknow8291D8 ; 82/91D8

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #$0010
	sta wUnknown0017D7,b

	lda aProcBody0,b,x
	tay
	lda aProcBody5,b,x
	beq +

	inc y
	inc y
	inc y
	inc y

	+
	sty wR0
	lda wR0
	cmp #$0008
	bmi +

	-
	bra -

	+
	asl a
	tax
	jsr (aUnknown8291FE,x)
	plx
	rts

aUnknown8291FE ; 82/91FE
	.addr rsUnknown82920E
	.addr rsUnknown82921A
	.addr rsUnknown829226
	.addr rsUnknown829232
	.addr rsUnknown82923E
	.addr rsUnknown82924A
	.addr rsUnknown829256
	.addr rsUnknown829262

rsUnknown82920E ; 82/920E

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0020

	rts

rsUnknown82921A ; 82/921A

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0040

	rts

rsUnknown829226 ; 82/9226

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0060

	rts

rsUnknown829232 ; 82/9232

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0080

	rts

rsUnknown82923E ; 82/923E

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0140

	rts

rsUnknown82924A ; 82/924A

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0160

	rts

rsUnknown829256 ; 82/9256

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0100

	rts

rsUnknown829262 ; 82/9262

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0120

	rts

rsUnknown82926E ; 82/926E

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #$0000
	sta wUnknown0017D9,b

	lda #$0008
	sta wUnknown0017D7,b

	lda aProcBody0,b,x
	tay
	lda aProcBody5,b,x
	beq +

	inc y
	inc y
	inc y
	inc y

	+
	sty wR0
	lda wR0
	cmp #$0008
	bmi +

	-
	bra -

	+
	asl a
	tax
	jsr (aUnknown82929A,x)
	plx
	rts

aUnknown82929A ; 82/929A
	.addr rsUnknown8292AA
	.addr rsUnknown8292B2
	.addr rsUnknown8292BA
	.addr rsUnknown8292C2
	.addr rsUnknown8292CA
	.addr rsUnknown8292D2
	.addr rsUnknown8292DA
	.addr rsUnknown8292E2

rsUnknown8292AA ; 82/92AA

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown8292EA

	rts

rsUnknown8292B2 ; 82/92B2

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown8292F0

	rts

rsUnknown8292BA ; 82/92BA

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown8292F6

	rts

rsUnknown8292C2 ; 82/92C2

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown8292FC

	rts

rsUnknown8292CA ; 82/92CA

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown829302

	rts

rsUnknown8292D2 ; 82/92D2

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown829308

	rts

rsUnknown8292DA ; 82/92DA

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown82930E

	rts

rsUnknown8292E2 ; 82/92E2

	.al
	.xl
	.autsiz
	.databank ?

	clc
	jsl $979BD5

	.addr aUnknown829314

	rts

aUnknown8292EA ; 82/92EA
	.word $0020, $0010, $FFFF

aUnknown8292F0 ; 82/92F0
	.word $0040, $0010, $FFFF

aUnknown8292F6 ; 82/92F6
	.word $0060, $0010, $FFFF

aUnknown8292FC ; 82/92FC
	.word $0080, $0010, $FFFF

aUnknown829302 ; 82/9302
	.word $0140, $0010, $FFFF

aUnknown829308 ; 82/9308
	.word $0160, $0010, $FFFF

aUnknown82930E ; 82/930E
	.word $0100, $0010, $FFFF

aUnknown829314 ; 82/9314
	.word $0120, $0010, $FFFF

rsUnknown82931A ; 82/931A

	.al
	.xl
	.autsiz
	.databank ?

	lda $7E4592
	bne +

	jsl rlUnknown829352
	and #$FFFF
	beq +

	lda #$0000
	jsl rlUnknown829365
	bra ++

	+
	lda wUnknown0017E9,b
	bit #$0010
	beq ++

	lda aProcBody5,b,x
	bne ++

	+
	jsl rlUnknown829352
	sta wR1
	lda aProcBody1,b,x
	sta wR0
	lda aProcBody0,b,x
	jsl rlUnknown8CC2FD

	+
	rts

rlUnknown829352 ; 82/9352

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda aProcBody0,b,x
	and #$0001
	asl a
	tax
	lda $7E458E,x
	plx
	rtl

aUnknown829361 ; 82/9361
	.word $0000, $0019

rlUnknown829365 ; 82/9365

	.al
	.xl
	.autsiz
	.databank ?

	phx
	pha
	lda aProcBody0,b,x
	and #$0001
	asl a
	tax
	pla
	sta $7E458E,x
	plx
	rtl

aUnknown829376 ; 82/9376
	.word $0000, $0019

rlClearWMPortraitByIndex ; 82/937A

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsl rlUnknown829389
	bcc +

	lda #$0001
	sta aProcBody4,b,x

	+
	plx
	rtl

rlUnknown829389 ; 82/9389

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	phy
	asl a
	tax
	lda #(`procPortrait0)<<8
	sta lR43+1
	lda @l aPortraitProcTable8293AB,x
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	ply
	plp
	plb
	sec
	rtl

	+
	ply
	plp
	plb
	clc
	rtl

aPortraitProcTable8293AB ; 82/93AB
	.addr procPortrait0
	.addr procPortrait1
	.addr procPortrait2
	.addr procPortrait3

procItemSelectPortrait .dstruct structProcInfo, None, rlProcItemSelectPortraitInit, rlProcItemSelectPortraitOnCycle, aProcItemSelectPortraitCode ; 82/93B3

rlProcItemSelectPortraitInit ; 82/93BB

	.al
	.xl
	.autsiz
	.databank ?

	; Portrait ID

	lda wProcInput0,b
	sta aProcBody1,b,x

	; Slot

	lda wProcInput1,b
	sta aProcBody0,b,x

	lda aProcBody1,b,x
	sta wR0

	lda aProcBody0,b,x
	jsl rlCopyPortraitPaletteToBuffer
	rtl

rlProcItemSelectPortraitOnCycle ; 82/93D4

	.al
	.xl
	.autsiz
	.databank ?

	lda bDecompListFlag,b
	and #$00FF
	bne +

	lda aProcBody0,b,x
	sta wR1
	lda aProcBody1,b,x
	jsl rlUnknown8CBFEC
	lda #<>rlProcItemSelectPortraitOnCycle2
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcItemSelectPortraitOnCycle2 ; 82/93EF

	.al
	.xl
	.autsiz
	.databank ?

	lda bDecompListFlag,b
	and #$00FF
	bne +

	lda bDMAArrayFlag,b
	and #$00FF
	bne +

	lda aProcBody0,b,x
	jsl rlUnknown8CC01B
	lda #<>rlProcItemSelectPortraitOnCycle3
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcItemSelectPortraitOnCycle3 ; 82/940D

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlProcEngineFreeProc
	rtl

aProcItemSelectPortraitCode ; 82/9412
	PROC_HALT

aDialogueBoxHDMAInfo .dstruct structHDMAArrayEntryInfo, rlDialogueBoxHDMAInit, rlDialogueBoxHDMAOnCycle, aDialogueBoxHDMACode, aDialogueHDMATable, CGADSUB - PPU_REG_BASE, DMAPx_Setting(DMAPx_TransferCPUToIO, DMAPx_Mode1, DMAPx_ABusIncrement, DMAPx_Direct) ; 82/9414

.byte $00 ; Don't know

rlDialogueBoxHDMAInit ; 82/9420

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	lda #TS_Setting(True, True, True, False, True)
	sta bBuf_TS
	lda #CGWSEL_Setting(True)
	sta bBuf_CGWSEL
	lda #CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	sta bBuf_CGADSUB
	rep #$20
	rtl

rlDialogueBoxHDMAOnCycle ; 82/9435

	.al
	.xl
	.autsiz
	.databank ?

	rtl

aDialogueBoxHDMACode ; 82/9436
	.dstruct structHDMAArrayCodeHalt

aDialogueHDMATable ; 82/9438

	.byte HDMA_DirectTableSetting(True, 64)

	.for i=0, i<8, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Add, False, False, False, False, False, False, False)
	.next

	.for i=5, i>=0, i-=1
		.word (COLDATA_Setting(i, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.for i=0, i<21, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.word (COLDATA_Setting(1, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.word (COLDATA_Setting(2, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.word (COLDATA_Setting(3, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.byte HDMA_DirectTableSetting(True, 64)

	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.word (COLDATA_Setting(4, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.word (COLDATA_Setting(5, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

	.for i=0, i<56, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Add, False, False, False, False, False, False, False)
	.next

	.byte HDMA_DirectTableSetting(True, 64)

	.for i=0, i<32, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Add, False, False, False, False, False, False, False)
	.next

	.for i=0, i<4, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next


	.for i=4, i>=0, i-=1
		.word (COLDATA_Setting(i, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.for i=0, i<8, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.byte HDMA_DirectTableSetting(True, 32)

	.for i=0, i<14, i+=1
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.for i=1, i<=4, i+=1
		.word (COLDATA_Setting(i, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
		.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.next

	.word (COLDATA_Setting(5, True, True, True) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)
	.word (COLDATA_Setting(0, False, False, False) << 8) | CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, True, False)

.byte HDMA_DirectTableSetting(False, 0)

procPortrait4 .dstruct structProcInfo, (4, "@"), rlProcPortraitBGInit, None, aProcPortraitBGCode ; 82/95FD
procPortrait5 .dstruct structProcInfo, (5, "@"), rlProcPortraitBGInit, None, aProcPortraitBGCode ; 82/9605

aProcPortraitBGCode ; 82/960D

	PROC_SET_ONCYCLE rlUnknown829832

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlCopyDialogueBoxGraphicsAndPalette

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rsClearDialogueBoxBG3

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown8298F0

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_HALT_WHILE_DECOMPRESSING

	PROC_SET_ONCYCLE rlUnknown829921

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown8296E2

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL rlUnknown829684

	PROC_HALT_WHILE $9A94AB

	PROC_SET_ONCYCLE rlUnknown82999C

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown8299AC

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL rlUnknown82974B

	PROC_SET_ONCYCLE rlUnknown8296E2

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL rlUnknown8296B3

	PROC_HALT_WHILE $9A94AB

	PROC_END

rlUnknown829684 ; 82/9684

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	and #$0001
	bne +

	lda #(`$9A9433)<<8
	sta lR18+1
	lda #<>$9A9433
	sta lR18
	bra ++

	+
	lda #(`$9A9444)<<8
	sta lR18+1
	lda #<>$9A9444
	sta lR18

	+
	phx
	lda #(`$9A94AB)<<8
	sta lR43+1
	lda #<>$9A94AB
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlUnknown8296B3 ; 82/96B3

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	and #$0001
	bne +

	lda #(`$9A9455)<<8
	sta lR18+1
	lda #<>$9A9455
	sta lR18
	bra ++

	+
	lda #(`$9A9466)<<8
	sta lR18+1
	lda #<>$9A9466
	sta lR18

	+
	phx
	lda #(`$9A94AB)<<8
	sta lR43+1
	lda #<>$9A94AB
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlUnknown8296E2 ; 82/96E2

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	lda bDecompListFlag,b
	bne _End

	lda #<>++
	sta aProcHeaderOnCycle,b,x
	lda aProcBody0,b,x
	and #$0001
	bne +

	lda #(`$9FBADE)<<8
	sta lR18+1
	lda #<>$9FBADE
	sta lR18
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	rtl

	+
	lda #(`$9FBC9D)<<8
	sta lR18+1
	lda #<>$9FBC9D
	sta lR18
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	rtl

	+
	stz aProcHeaderSleepTimer,b,x
	lda bDecompListFlag,b
	bne _End

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	_End
	rtl

rlUnknown82973E ; 82/973E

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	and #$0001
	asl a
	tay
	jsl rlUpdateDialogueBoxBG1Tilemap
	rtl

rlUnknown82974B ; 82/974B

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	and #$0001
	asl a
	tay
	jsl rlUpdateDialogueBoxBG3Tilemap
	rtl

rlUnknown829758 ; 82/9758

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`$9A87BF)<<8
	sta lR43+1
	lda #<>$9A87BF
	sta lR43
	jsl rlHDMAArrayEngineFindEntry
	bcs +

	lda #(`$9A87BF)<<8
	sta lR43+1
	lda #<>$9A87BF
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry

	+
	rtl

rlUnknown829777 ; 82/9777

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x

	jsl rlProcEngineFreeProc

	lda #(`procPortrait4)<<8
	sta lR43+1
	lda #<>procPortrait4
	sta lR43
	jsl rlProcEngineFindProc
	bcs +

	lda #(`procPortrait5)<<8
	sta lR43+1
	lda #<>procPortrait5
	sta lR43
	jsl rlProcEngineFindProc
	bcs +

	lda #(`$9A87BF)<<8
	sta lR43+1
	lda #<>$9A87BF
	sta lR43
	jsl rlHDMAArrayEngineFindEntry
	bcc +

	jsl rlHDMAArrayEngineFreeEntryByOffset

	+
	rtl

rlUnknown8297B3 ; 82/97B3

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	sta wProcInput0,b
	phx
	lda #(`$9A8814)<<8
	sta lR43+1
	lda #<>$9A8814
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlUnknown8297CA ; 82/97CA

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	sta wProcInput0,b
	phx
	lda #(`$9A88C3)<<8
	sta lR43+1
	lda #<>$9A88C3
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlProcPortraitBGInit ; 82/97E1

	.al
	.xl
	.autsiz
	.databank ?

	lda wProcInput0,b
	sta aProcBody0,b,x

	lda wProcInput2,b
	sta aProcBody2,b,x

	lda #$0000
	sta aProcBody3,b,x

	lda #$0001
	sta @l wUnknown001586

	lda aProcBody2,b,x
	jsl rlScrollCameraCharEffect

	lda @l wEventEngineXCoordinate
	sta wR0
	lda @l wEventEngineYCoordinate
	sta wR1
	ora wR0
	beq +

	jsl rlUnknown81B544
	lda wR0
	lsr a
	lsr a
	lsr a
	lsr a
	sta aProcBody5,b,x

	lda wR1
	lsr a
	lsr a
	lsr a
	lsr a
	sta aProcBody6,b,x

	rtl

	+
	lda #$0000
	sta aProcBody5,b,x
	sta aProcBody6,b,x
	rtl

rlUnknown829832 ; 82/9832

	.al
	.xl
	.autsiz
	.databank `*

	stz aProcHeaderSleepTimer,b,x
	lda bDMAArrayFlag,b
	and #$00FF
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x

	plx
	phx
	lda aProcBody0,b,x
	asl a
	tay
	lda aUnknown829856,y
	sta aProcBody1,b,x
	plx

	+
	rtl

aUnknown829856 ; 82/9856
	.word $0042, $0502

rlCopyDialogueBoxGraphicsAndPalette ; 82/985A

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x

	lda bDecompListFlag,b
	and #$00FF
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	lda #$0000
	pha
	jsl rlGetDialogueBoxGraphicsPointer

	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	pla
	jsl rlCopyDialogueBoxPalette

	+
	rtl

rsClearDialogueBoxBG3 ; 82/988C

	.al
	.xl
	.autsiz
	.databank ?

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	lda aProcBody0,b,x
	asl a
	tax
	jsr (aUnknown8298A0,x)
	rtl

aUnknown8298A0 ; 82/98A0
	.addr rsClearUpperDialogueBoxBG3
	.addr rsClearLowerDialogueBoxBG3

rsClearUpperDialogueBoxBG3 ; 82/98A4

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0400
	sta wR19
	lda #$02D0
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer, $0400, VMAIN_Setting(True), $A000

	plx
	rts

rsClearLowerDialogueBoxBG3 ; 82/98CA

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`$7EEB7C)<<8
	sta lR18+1
	lda #<>$7EEB7C
	sta lR18
	lda #$0400
	sta wR19
	lda #$02D0
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $7EEB7C, $0400, VMAIN_Setting(True), $A400

	plx
	rts

rlUnknown8298F0 ; 82/98F0

	.al
	.xl
	.autsiz
	.databank ?

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	phx
	lda #(`$7EEF7C)<<8
	sta lR18+1
	lda #<>$7EEF7C
	sta lR18
	lda #$0800
	sta wR19
	lda #$02D0
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $7EEF7C, $0800, VMAIN_Setting(True), $A800

	plx
	rtl

rlUnknown829921 ; 82/9921

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x

	lda bDMAArrayFlag,b
	and #$00FF
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	lda #$0800
	sta wR0
	lda #(`$7FB0F5)<<8
	sta lR18+1
	lda #<>$7FB0F5
	sta lR18
	lda #$2400
	sta wR1
	phx
	jsl rlDMAByPointer
	plx

	+
	rtl

rlUnknown829952 ; 82/9952

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	lda #<>rlUnknown829973
	sta aProcHeaderOnCycle,b,x
	lda aProcBody5,b,x
	sta @l wEventEngineXCoordinate
	lda aProcBody6,b,x
	sta @l wEventEngineYCoordinate
	lda aProcBody0,b,x
	sta wR1
	jsl rlUnknown8CCDA5
	rtl

rlUnknown829973 ; 82/9973

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	jsl rlUnknown8CCEE3
	lda @l wUnknown0017DF
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	+
	rtl

rlUnknown82998C ; 82/998C

	.al
	.xl
	.autsiz
	.databank ?

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	jsl rlUnknown829B6E
	rtl

rlUnknown82999C ; 82/999C

	.al
	.xl
	.autsiz
	.databank ?

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx
	jsl $959637
	rtl

rlUnknown8299AC ; 82/99AC

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	lda aProcBody3,b,x
	beq +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	+
	rtl

rlUnknown8299C0 ; 82/99C0

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	lda #<>rlUnknown8299E1
	sta aProcHeaderOnCycle,b,x
	lda aProcBody5,b,x
	sta @l wEventEngineXCoordinate
	lda aProcBody6,b,x
	sta @l wEventEngineYCoordinate
	lda aProcBody0,b,x
	sta wR1
	jsl rlUnknown8CCE19
	rtl

rlUnknown8299E1 ; 82/99E1

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	jsl rlUnknown8CCEE3
	lda @l wUnknown0017DF
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	+
	rtl

rsUnknown8299FA ; 82/99FA

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0010
	sta wUnknown0017D7,b
	clc
	lda aProcBody0,b,x
	bne +

	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0000

	bra ++

	+
	jsl $979B67

	.word <>$7E4BF8
	.word $0010, $0000

	+
	rts

rsUnknown829A1D ; 82/9A1D

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta wUnknown0017D9,b

	lda #$0008
	sta wUnknown0017D7,b

	clc
	lda aProcBody0,b,x
	bne +

	jsl $979BD5

	.addr aUnknown829A3E

	bra ++

	+

	jsl $979BD5

	.addr aUnknown829A44

	+
	rts

aUnknown829A3E ; 82/9A3E

	.word $0000, $0010, $FFFF

aUnknown829A44 ; 82/9A44

	.word $0000, $0010, $FFFF

rlUnknown829A4A ; 82/9A4A

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	phx
	asl a
	tay

	lda #(`aUnknown829AF3)<<8
	sta lUnknown000DDE+1,b
	lda #<>aUnknown829AF3
	sta lUnknown000DDE,b

	lda #$2000
	sta wUnknown000DE7,b

	lda #(`aUnknown929AA7)<<8
	sta lR18+1
	lda #<>aUnknown929AA7
	sta lR18

	jsl $87D6FC

	lda #(`aUnknown829AC9)<<8
	sta lR18+1
	lda #<>aUnknown829AC9
	sta lR18
	jsl $87DD95
	lda aUnknown829AA3,y
	tax
	jsl $87D4DD
	lda #(`$7EC7BC)<<8
	sta lR18+1
	lda aUnknown829B39,y
	sta lR18
	lda #$0200
	sta wR0
	lda aUnknown829B3D,y
	sta wR1
	jsl rlDMAByPointer
	plx
	plp
	plb
	rtl

aUnknown829AA3 ; 82/9AA3
	.word $0042
	.word $0502

aUnknown929AA7 ; 82/9AA7
	.byte $04, $04

	.word $0040, $0041, $0042, $0043
	.word $0050, $0051, $0052, $0053
	.word $0060, $0061, $0062, $0063
	.word $0070, $0071, $0072, $0073

aUnknown829AC9 ; 82/9AC9
	.byte $04, $04

	.word $0044, $0047, $0074, $0077
	.word $004C, $004D, $004E, $004F
	.word $005C, $005D, $005E, $005F
	.word $0048, $0058, $0049, $0059

aUnknown829AEB ; 82/9AEB
	.word $004A
	.word $005A
	.word $004B
	.word $005B

aUnknown829AF3 ; 82/9AF3
	.byte $1E, $08
	.long aBG1TilemapBuffer
	.byte $00
	.long $7FB0F5

rsUnknown829AFC ; 82/9AFC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	phx
	and #$0001
	asl a
	tay
	phy
	jsl rlUpdateDialogueBoxBG1Tilemap
	ply
	jsl rlUpdateDialogueBoxBG3Tilemap
	plx
	plp
	plb
	rts

rlUpdateDialogueBoxBG1Tilemap ; 82/9B14

	.al
	.xl
	.autsiz
	.databank `*

	lda #(`aBG1TilemapBuffer)<<8
	sta lR18+1
	lda aUnknown829B39,y
	sta lR18
	lda #$0200
	sta wR19
	lda #$02FF
	jsl rlBlockFillWord
	lda #$0200
	sta wR0
	lda aUnknown829B3D,y
	sta wR1
	jsl rlDMAByPointer
	rtl

aUnknown829B39 ; 82/9B39
	.word <>aBG1TilemapBuffer + ((0 + (1 * $20)) * 2)
	.word <>aBG1TilemapBuffer + ((0 + (20 * $20)) * 2)

aUnknown829B3D ; 82/9B3D
	.word $7020
	.word $7280

rlUpdateDialogueBoxBG3Tilemap ; 82/9B41

	.al
	.xl
	.autsiz
	.databank `*

	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda aUnknown829B66,y
	sta lR18
	lda #$0200
	sta wR19
	lda #$02D0
	jsl rlBlockFillWord
	lda #$0200
	sta wR0
	lda aUnknown829B6A,y
	sta wR1
	jsl rlDMAByPointer
	rtl

aUnknown829B66 ; 82/9B66
	.word <>aBG3TilemapBuffer + ((0 + (1 * $20)) * 2)
	.word <>aBG3TilemapBuffer + ((0 + (20 * $20)) * 2)

aUnknown829B6A ; 82/9B6A
	.word $5020
	.word $5280

rlUnknown829B6E ; 82/9B6E

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #$0000
	jsr rsUnknown829B7D

	lda #$0001
	jsr rsUnknown829B7D

	plx
	rtl

rsUnknown829B7D ; 82/9B7D

	.al
	.xl
	.autsiz
	.databank ?

	pha
	phx
	jsl rlCheckPortrait4Or5Active
	plx
	pla
	bcs +

	jsr rsUnknown829AFC
	bra ++

	+
	lda aProcBody3,b,x
	bne +

	lda aProcBody0,b,x
	jsl rlUnknown829A4A

	+
	rts

rsUnknown829B99 ; 82/9B99

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsl rlCheckPortrait4Or5Active
	bcc +

	lda #$0001
	sta aProcBody3,b,x

	+
	plx
	rtl

rlCheckPortrait4Or5Active ; 82/9BA8

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	phy
	tax
	lda #(`procPortrait4)<<8
	sta lR43+1
	lda #<>procPortrait4
	sta lR43
	txa
	beq +

	lda #(`procPortrait5)<<8
	sta lR43+1
	lda #<>procPortrait5
	sta lR43

	+
	jsl rlProcEngineFindProc
	bcc +

	ply
	plp
	plb
	sec
	rtl

	+
	ply
	plp
	plb
	clc
	rtl
