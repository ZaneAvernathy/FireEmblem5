
rlSetupInventoryFullConvoyMenu ; 86/E41A

	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`aFullInventoryConvoyBuffer
	pha
	rep #$20
	plb

	.databank `aFullInventoryConvoyBuffer

	lda aSelectedCharacterBuffer.Item1ID,b
	sta wFullInventoryConvoyBufferItem1
	lda aSelectedCharacterBuffer.Item2ID,b
	sta wFullInventoryConvoyBufferItem2
	lda aSelectedCharacterBuffer.Item3ID,b
	sta wFullInventoryConvoyBufferItem3
	lda aSelectedCharacterBuffer.Item4ID,b
	sta wFullInventoryConvoyBufferItem4
	lda aSelectedCharacterBuffer.Item5ID,b
	sta wFullInventoryConvoyBufferItem5
	lda aSelectedCharacterBuffer.Item6ID,b
	sta wFullInventoryConvoyBufferItem6
	lda aSelectedCharacterBuffer.Item7ID,b
	sta wFullInventoryConvoyBufferItem7

	sep #$20
	lda aItemDataBuffer.DisplayedWeapon,b
	sta wFullInventoryConvoyBufferItemNew
	lda aItemDataBuffer.Durability,b
	sta wFullInventoryConvoyBufferItemNew+1
	rep #$30

	phx
	lda #(`procInventoryFullConvoyMenu)<<8
	sta lR43+1
	lda #<>procInventoryFullConvoyMenu
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	jsl $8593AD
	plb
	plp
	rtl

procInventoryFullConvoyMenu .dstruct structProcInfo, None, rlProcInventoryFullConvoyMenuInit, rlProcInventoryFullConvoyMenuOnCycle, None ; 86/E475

aProcInventoryFullConvoyMenuActions ; 86/E47D
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuInventoryOption
	.addr aProcInventoryFullConvoyMenuNewItemOption
	.word $0000

aProcInventoryFullConvoyMenuInventoryOption ; 86/E48F
	.long None
	.long rlProcInventoryFullConvoyMenuInventoryItemUsability
	.long rlProcInventoryFullConvoyMenuMoveCursor
	.long rlProcInventoryFullConvoyMenuSelectOption
	.long None
	.long None
	.enc "MenuText"
	.text "　\n"

aProcInventoryFullConvoyMenuNewItemOption ; 86/E4A5
	.long None
	.long rlProcInventoryFullConvoyMenuNewItemUsability
	.long rlProcInventoryFullConvoyMenuMoveCursor
	.long rlProcInventoryFullConvoyMenuSelectOption
	.long None
	.long None
	.enc "MenuText"
	.text "　\n"

menutextProcInventoryFullConvoyMenuPromptTable ; 86/E4BB
	.addr menutextProcInventoryFullConvoyMenuPromptLine1
	.addr menutextProcInventoryFullConvoyMenuPromptLine2
	.addr menutextProcInventoryFullConvoyMenuPromptLine3
	.word $0000

menutextProcInventoryFullConvoyMenuPromptLine1 ; 86/E4C3
	.enc "MenuText"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "持ち物がいっぱいです\n"

menutextProcInventoryFullConvoyMenuPromptLine2 ; 86/E4EB
	.enc "MenuText"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "預かり所へおくるアイテムを\n"

menutextProcInventoryFullConvoyMenuPromptLine3 ; 86/E519
	.enc "MenuText"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "\n"
	.text "えらんでください\n"

rlProcInventoryFullConvoyMenuInit ; 86/E53D

	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`wCapturingFlag
	pha
	rep #$20
	plb

	.databank `wCapturingFlag

	stz aProcBody7,b,x
	stz wCapturingFlag
	jsl $8594C1
	lda #$FF58
	sta wR0
	lda #$0001
	sta wR1
	lda #$0047
	sta wR2
	jsl $85946B
	lda #<>menutextProcInventoryFullConvoyMenuPromptTable
	sta lR18
	lda #>`menutextProcInventoryFullConvoyMenuPromptTable
	sta lR18+1
	lda #$0010
	sta wR0
	lda #$0000
	sta wR1
	lda #$000F
	sta wR2
	jsl $85898D
	sta aProcBody5,b,x
	jsl $85827A
	phx
	lda aSelectedCharacterBuffer.Character,b
	sta wR0
	lda #$0000
	jsl rlUnknown8CC137
	jsl $8A8060
	plx
	lda #$0003
	sta wR0
	lda #$0009
	sta wR1
	lda #$000F
	sta wR2
	lda #<>aProcInventoryFullConvoyMenuActions
	sta lR18
	lda #>`aProcInventoryFullConvoyMenuActions
	sta lR18+1
	jsl $85898D
	sta aProcHeaderUnknownTimer,b,x
	jsl $85827A
	lda $7E4F0A
	and #$00FF
	tax
	lda aSelectedCharacterBuffer.Items,b,x
	sta $7E4F55
	phx
	lda #(`$87A4D0)<<8
	sta lR43+1
	lda #<>$87A4D0
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	lda #TM_Setting(False, True, False, False, True)
	sta bBuf_TM
	rep #$20
	plb
	plp
	rtl

rlProcInventoryFullConvoyMenuOnCycle ; 86/E5E6

	.al
	.autsiz
	.databank ?

	phx
	lda #(`procItemSelectPortrait)<<8
	sta lR43+1
	lda #<>procItemSelectPortrait
	sta lR43
	jsl rlProcEngineFindProc
	plx
	bcc +

	rtl

	+
	lda #$0000
	sta aProcBody6,b,x
	lda #<>rlProcInventoryFullConvoyMenuOnCycle2
	sta aProcHeaderOnCycle,b,x

rlProcInventoryFullConvoyMenuOnCycle2 ; 86/E605

	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`aFullInventoryConvoyBuffer
	pha
	rep #$20
	plb

	.databank `aFullInventoryConvoyBuffer

	lda #<>rlProcInventoryFullConvoyMenuOnCycle3
	sta aProcHeaderOnCycle,b,x
	jsl $858310
	jsl $87A84B
	sep #$20
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	rep #$20
	plb
	plp
	rtl

rlProcInventoryFullConvoyMenuOnCycle3 ; 86/E628

	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`aFullInventoryConvoyBuffer
	pha
	rep #$20
	plb

	.databank `aFullInventoryConvoyBuffer

	lda aProcHeaderUnknownTimer,b,x
	jsl $858434
	bcc +

	lda aProcHeaderUnknownTimer,b,x
	jsl $8581B5
	jsl $858B43
	jsl $8A8126

	+
	plb
	plp
	rtl

rlProcInventoryFullConvoyMenuInventoryItemUsability ; 86/E64D

	.al
	.autsiz
	.databank `aFullInventoryConvoyBuffer

	ldy $7E4F48
	lda aFullInventoryConvoyBuffer,y
	jsl rlCopyItemDataToBuffer
	lda #$0100
	jsl $87A88A
	rtl


rlProcInventoryFullConvoyMenuNewItemUsability ; 86/E65F

	.al
	.autsiz
	.databank `aFullInventoryConvoyBuffer

	ldy $7E4F48
	lda aFullInventoryConvoyBuffer,y
	jsl rlCopyItemDataToBuffer
	lda #$0100
	jsl $87A87F
	rtl

rlProcInventoryFullConvoyMenuMoveCursor ; 86/E671

	.al
	.autsiz
	.databank `aFullInventoryConvoyBuffer

	ldx $7E4F48
	lda aFullInventoryConvoyBuffer,x
	sta wProcInput0,b
	phx
	lda #(`$87A4F2)<<8
	sta lR43+1
	lda #<>$87A4F2
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlProcInventoryFullConvoyMenuSelectOption ; 86/E68B

	.al
	.autsiz
	.databank `aFullInventoryConvoyBuffer

	phx
	jsl $87A85F
	plx
	jsl rlProcEngineFreeProc
	jsl $858033
	jsl $8A8060
	jsl $8594C1
	jsl $879D57
	ldx $7E4F48
	jsl rlUnknown81BC3A
	rtl

