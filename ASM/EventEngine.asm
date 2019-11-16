
rsDoEventEngineCycle ; 8C/8000

	.al
	.xl
	.autsiz
	.databank ?

	php

	lda wEventEngineStatus,b
	bit #EventEngineActive
	beq +

	lda wEventEngineCycleType,b
	asl a
	clc
	adc wEventEngineCycleType,b
	tax

	lda aEventEngineCycleRoutines,x
	sta lR19
	lda aEventEngineCycleRoutines+1,x
	sta lR19+1

	jsl _Jump

	+
	plp
	rts

	_Jump
	jmp [lR19]

aEventEngineCycleRoutines ; 8C/8027
	.long rlUnknown8C8046
	.long rlUnknown8C806F
	.long rlUnknown8C81F3
	.long rlUnknown8C82A9
	.long rlUnknown8C82C0
	.long rlUnknown8C8323
	.long rlUnknown8C833F
	.long rlUnknown8C836E
	.long rlUnknown8C8381

rlDoEventEngineCycleWrapper ; 8C/8042

	.autsiz
	.databank ?

	jsr rsDoEventEngineCycle
	rtl

rlUnknown8C8046 ; 8C/8046

	.autsiz
	.databank ?

	php
	rep #$30
	lda #$0001
	sta wEventEngineCycleType,b

	jsl rlEventEngineClearActiveProcs

	lda #$0000
	sta lEventEngineUnitGroupPointer,b

	lda #$0008
	trb wEventEngineStatus,b

	lda wUnknown001791,b
	cmp #$000E
	beq +

	jsl $8593EB

	+
	plp
	jmp rlUnknown8C806F

rlUnknown8C806F ; 8C/806F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda wUnknown000302,b
	cmp #$0003
	bne +

	sta wUnknown001791,b

	lda #$0000
	sta wUnknown000302,b

	+
	jsr rsUnknown8C9E98
	jsr rsUnknown8C81BC
	bcs +

	jsr rsUnknown8C818F
	bcc +

	jsr rsEventEngineHandleEvent

	+
	plp
	plb
	rtl

rsEventEngineHandleEvent ; 8C/8097

	.al
	.xl
	.autsiz
	.databank ?

	; Store pointer to events

	lda lEventStartPointer+1,b
	sta lR22+1
	lda lEventStartPointer,b
	sta lR22
	ldy wEventExecutionOffset,b
	bra +

	_Loop

	; Save offset in events

	inc y
	sty wEventExecutionOffset,b
	phy

	; Handle event code and continue

	asl a
	tay
	lda <>aEventCodeTable,b,y
	ply
	sta lR23
	pea <>_Return - 1
	jmp (lR23)

	_Return
	bcc +
	sty wEventExecutionOffset,b
	bra _End

	+

	; Grab a byte, check if it's an end
	; code or a yield

	; Both types end execution but
	; yields save the offset in the events

	lda [lR22],y
	and #$00FF
	jsr rsEventEngineHandleEndCodes
	bcs _End

	and #$00FF
	cmp #(-4 & $FF) ; YIELD
	bne _Loop
	inc y
	sty wEventExecutionOffset,b

	_End
	rts

rsEventEngineHandleEndCodes ; 8C/80D7

	.al
	.xl
	.autsiz
	.databank ?

	pha
	phx
	phy
	pha

	; Check if event code is an end code

	lda #(`aEndEventCodeTable)<<8
	sta lR18+1
	lda #<>aEndEventCodeTable
	sta lR18
	pla
	jsl rsCheckEventEndCodeTable
	bcc +

	; If it is, handle it

	sta wEventEngineCycleType,b
	jsl $8593EB

	+
	ply
	plx
	pla
	rts

aEndEventCodeTable ; 8C/80F7
	.char -1 ; END1
	.byte $04

	.char -2 ; END2
	.byte $05

	.char -3 ; END3
	.byte $07

.byte $00
.byte $00

aEventCodeTable .include "../TABLES/EventCodeHandlerPointers.asm" ; 8C/80FF
.word $0000

rsUnknown8C818F ; 8C/818F

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineStatus,b
	bit #$0004
	beq _True

	jsr rsUnknown8C8435

	lda #EventEngineProcsInactive
	bit wEventEngineStatus,b
	beq _False

	ora #$0004
	trb wEventEngineStatus,b

	_True
	sec
	bra _End

	_False
	clc

	_End
	rts

rsUnknown8C81AD ; 8C/81AD

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl rlEventEngineCancelFading
	jsl $9580F3
	jsl $958127
	plp
	rts

rsUnknown8C81BC ; 8C/81BC

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineStatus,b
	bit #$2000 | $4000
	bne _False

	lda aUnknown0004BA,b
	bne _False

	lda wJoy1New
	bit #JoypadStart
	beq _False

	lda #$4000
	tsb wEventEngineStatus,b

	lda #$0002
	sta wEventEngineCycleType,b

	jsl rlEventEngineCancelFading

	lda wEventEngineStatus,b
	bit #$8000
	bne _True

	lda #$00E0
	jsl rlUnknown808C49

	_True
	sec
	rts

	_False
	clc
	rts

rlUnknown8C81F3 ; 8C/81F3

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$30
	lda wEventEngineStatus,b
	bit #$8000
	beq +

	jsl rlUnknown8C826C
	bra _End

	+

	; Typo?

	lda #wUnknown001791
	cmp #$000E
	beq ++

	lda wEventEngineStatus,b
	bit #$8000
	bne +

	lda bBuf_INIDISP
	and #$00FF
	beq +

	bit #INIDISP.ForcedBlank
	bne +

	sep #$20
	dec bBuf_INIDISP
	rep #$20
	bra _End

	+
	lda bDMAArrayFlag,b
	and #$00FF
	bne _End

	lda bDecompListFlag,b
	and #$00FF
	bne _End

	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	rep #$20

	jsl rlEventEngineClearActiveProcs

	lda #$0000
	jsl rlClearWMPortraitByIndex

	lda #$0001
	jsl rlClearWMPortraitByIndex

	lda #$0000
	jsl rsUnknown829B99

	lda #$0001
	jsl rsUnknown829B99

	jsl $85965A

	+
	lda #$0001
	sta wEventEngineCycleType,b

	_End
	plp
	rtl

rlUnknown8C826C ; 8C/826C

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$30

	lda wUnknown000302,b
	cmp #$000C
	bne +

	lda $7FFC57
	bit #$0080
	bne ++

	lda $7FE4B8
	bit #$0080
	beq +

	lda wUnknown001838,b
	cmp #$002D
	beq ++

	cmp #$002E
	beq ++

	+
	jsl $9BA4C6

	lda #$00E0
	jsl rlUnknown808C49

	lda #$0003
	sta wEventEngineCycleType,b

	+
	plp
	rtl

rlUnknown8C82A9 ; 8C/82A9

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$30

	jsl rlEventEngineClearActiveProcs
	jsl $9A9D67
	jsl $95800B

	lda #$0001
	sta wEventEngineCycleType,b

	plp
	rtl

rlUnknown8C82C0 ; 8C/82C0

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$30

	lda bBuf_INIDISP
	bit #INIDISP.ForcedBlank
	bne +

	lda aUnknown0004BA,b
	bne _End

	+
	jsl rlEventEngineClearActiveProcs

	lda #$0000
	sta wEventEngineCycleType,b

	stz wEventExecutionOffset,b

	lda lEventEngineEventDefinitionPointer,b
	beq +

	lda wEventEngineStatus,b
	pha
	stz wEventEngineStatus,b

	lda lEventEngineEventDefinitionPointer,b
	sta lR18
	lda lEventEngineEventDefinitionPointer+1,b
	sta lR18+1
	jsl rlUnknown8C9601

	pla
	and #$2000
	sta wR0
	lda wEventEngineStatus,b
	beq +

	ora wR0
	sta wEventEngineStatus,b
	bra _End

	+
	stz wEventEngineStatus,b

	jsl $95800B
	jsl $8593EB

	lda wUnknown001791,b
	cmp #$FFFF
	beq _End

	sta wUnknown000302,b
	stz wUnknown001791,b

	_End
	plp
	rtl

rlUnknown8C8323 ; 8C/8323

	.al
	.xl
	.autsiz
	.databank ?

	jsl $83A5B2

	cmp wCurrentMapMusic,b
	beq +

	lda #$00E0
	jsl rlUnknown808C7D

	+
	lda #$0000
	sta wEventEngineParameter1,b

	lda #$0006
	sta wEventEngineCycleType,b

rlUnknown8C833F ; 8C/833F

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineParameter1,b
	inc a
	sta wEventEngineParameter1,b

	cmp #$0020
	bcc ++

	jsl rlUnknown8CAC3A

	lda #$00E8
	jsl rlUnknown808C7D

	lda wUnknown001730,b
	bne +

	lda wUnknown000E23,b
	cmp #$0003
	beq +

	jsl $83A5A4

	+
	lda #$0004
	sta wEventEngineCycleType,b

	+
	rtl

rlUnknown8C836E ; 8C/836E

	.al
	.xl
	.autsiz
	.databank ?

	lda #$00E0
	jsl rlUnknown808C7D

	lda #$0000
	sta wEventEngineParameter1,b

	lda #$0006
	sta wEventEngineCycleType,b

rlUnknown8C8381 ; 8C/8381

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineParameter1,b
	inc a
	sta wEventEngineParameter1,b

	cmp #$0020
	blt +

	jsl rlUnknown8CAC3A

	lda #$00E8
	jsl rlUnknown808C7D

	lda #$0004
	sta wEventEngineCycleType,b

	+
	rtl

rlUnknown8C839F ; 8C/839F

	.al
	.xl
	.autsiz
	.databank ?

	phb

	lda wEventEngineStatus,b
	bne _True

	lda #$0000
	sta wEventEngineCycleType,b

	lda wUnknown000302,b
	beq +

	sta wUnknown001791,b

	lda #$0000
	sta wUnknown000302,b

	+
	lda lR18
	sta lEventStartPointer,b
	lda lR18+1
	sta lEventStartPointer+1,b

	stz wEventExecutionOffset,b
	stz lEventEngineUnitGroupPointer,b

	lda #$0009
	sta wEventEngineStatus,b
	clc
	bra _End

	_True
	sec

	_End
	plb
	rtl

rsUnknown8C83D5 ; 8C/83D5

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx

	ldx #size(aEventEngineActiveProcs) - 2

	-
	lda #$0000
	sta aEventEngineActiveProcs,b,x
	dec x
	dec x
	bpl -

	plx
	plp
	rts

rlEventEngineCreateProcAndSetActive ; 8C/83E7

	.al
	.xl
	.autsiz
	.databank ?

	php

	lda bBuf_INIDISP
	and #INIDISP.ForcedBlank
	bne +

	jsl rlProcEngineCreateProc
	tax
	lda #$0001
	sta aEventEngineActiveProcs,b,x

	lda #$0004
	tsb wEventEngineStatus,b

	+
	plp
	rtl

rlEventEngineDeleteProcAndClearActive ; 8C/8402

	.al
	.xl
	.autsiz
	.databank ?

	php
	ldx wProcIndex,b

	lda #$0000
	sta aEventEngineActiveProcs,b,x
	jsl rlProcEngineFreeProc

	plp
	rtl

rlEventEngineClearActiveProcs ; 8C/8412

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$30
	ldx #size(aEventEngineActiveProcs) - 2

	-
	lda aEventEngineActiveProcs,b,x
	beq +

	phx
	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	plx
	lda #$0000
	sta aEventEngineActiveProcs,b,x

	+
	dec x
	dec x
	bpl -

	jsl rlUnknown8C9E22
	plp
	rtl

rsUnknown8C8435 ; 8C/8435

	.al
	.xl
	.autsiz
	.databank ?

	lda #EventEngineProcsInactive
	tsb wEventEngineStatus,b


	ldx #size(aEventEngineActiveProcs) - 2

	_Loop
	lda aProcHeaderTypeOffset,b,x
	bne _ProcActive

	lda #$0000
	sta aEventEngineActiveProcs,b,x

	_ProcActive
	lda aEventEngineActiveProcs,b,x
	bne +

	lda #$0000
	sta aEventEngineActiveProcs,b,x

	_Next
	dec x
	dec x
	bpl _Loop
	rts

	+
	lda #EventEngineProcsInactive
	trb wEventEngineStatus,b
	bra _Next

rlEventEngineCancelFading ; 8C/8461

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlEventEngineCancelFadeIns
	jsl rlEventEngineCancelFadeOuts
	jsl rlEventEngineCancelFadeInClearJoypad
	clc
	rtl

rlEventEngineCancelFadeIns ; 8C/846F

	.al
	.xl
	.autsiz
	.databank ?

	php

	-
	lda #(`procFadeIn1)<<8
	sta lR43+1
	lda #<>procFadeIn1
	sta lR43
	jsl rlProcEngineFindProc
	bcc _8488

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra -

	_8488
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineFindProc
	bcc _84A0

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra _8488

	_84A0
	lda #(`procEventFadeIn)<<8
	sta lR43+1
	lda #<>procEventFadeIn
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra _84A0

	+
	lda #$FFFF
	sta wScreenBrightnessFlag,b
	plp
	rtl

rlEventEngineCancelFadeOuts ; 8C/84C0

	.al
	.xl
	.autsiz
	.databank ?

	php

	-
	lda #(`procFadeOut1)<<8
	sta lR43+1
	lda #<>procFadeOut1
	sta lR43
	jsl rlProcEngineFindProc
	bcc _84D9

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra -

	_84D9
	lda #(`procFadeOut2)<<8
	sta lR43+1
	lda #<>procFadeOut2
	sta lR43
	jsl rlProcEngineFindProc
	bcc _84F1

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra _84D9

	_84F1
	lda #(`procEventFadeOut)<<8
	sta lR43+1
	lda #<>procEventFadeOut
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex
	bra _84F1

	+
	lda #$FFFF
	sta wScreenBrightnessFlag,b
	plp
	rtl

rlEventEngineCancelFadeInClearJoypad ; 8C/8511

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #(`procFadeInClearJoypad)<<8
	sta lR43+1
	lda #<>procFadeInClearJoypad
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	+
	plp
	rtl

rsEventCodeHandler_YIELD_UNK ; 8C/852A

	.al
	.xl
	.autsiz
	.databank ?

	sty wEventExecutionOffset,b
	sec
	rts

rsEventCodeHandler_JUMP ; 8C/852F

	.al
	.xl
	.autsiz
	.databank ?

	; Get target offset

	lda [lR22],y

	; target - start = distance

	sec
	sbc lR22
	tay
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_JUMP_TRUE ; 8C/853A

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineTruthFlag,b
	bne _Jump

	; If not true, skip jumping

	inc y
	inc y
	bra _End

	_Jump

	; Get target offset

	lda [lR22],y

	; target - start = distance

	sec
	sbc lR22
	tay

	_End
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_JUMP_FALSE ; 8C/854E

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineTruthFlag,b
	beq _Jump

	; If true, skip jumping

	inc y
	inc y
	bra _End

	_Jump

	; Get target offset

	lda [lR22],y

	; target - start = distance

	sec
	sbc lR22
	tay

	_End
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_JUMP_DISTANCE ; 8C/8562

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	clc
	adc wEventExecutionOffset,b
	tay
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_JUMP_DISTANCE_TRUE ; 8C/856E

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineTruthFlag,b
	bne _Jump

	inc y
	inc y
	bra _End

	_Jump
	lda [lR22],y
	clc
	adc wEventExecutionOffset,b
	tay

	_End
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_JUMP_DISTANCE_FALSE ; 8C/8583

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineTruthFlag,b
	beq _Jump

	inc y
	inc y
	bra _End

	_Jump
	lda [lR22],y
	clc
	adc wEventExecutionOffset,b
	tay

	_End
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_CMP_BYTE_AT_LT ; 8C/8598

	.al
	.xl
	.autsiz
	.databank ?

	stz wEventEngineTruthFlag,b

	; Get pointer to data

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	; Get byte

	lda [lR22],y
	and #$00FF
	sta wR0

	lda [lR24]
	and #$00FF
	cmp wR0
	blt +

	; If byte is less than data

	inc wEventEngineTruthFlag,b

	+
	inc y
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_CMP_WORD_AT_LT ; 8C/85BF

	.al
	.xl
	.autsiz
	.databank ?

	stz wEventEngineTruthFlag,b

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta wR0
	lda [lR24]
	cmp wR0
	bcc +

	inc wEventEngineTruthFlag,b

	+
	inc y
	inc y
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_CMP_BYTE_AT_EQ ; 8C/85E1

	.al
	.xl
	.autsiz
	.databank ?

	stz wEventEngineTruthFlag,b

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	and #$00FF
	sta wR0

	lda [lR24]
	and #$00FF
	cmp wR0
	bne +

	inc wEventEngineTruthFlag,b

	+
	inc y
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_CMP_WORD_AT_EQ ; 8C/8608

	.al
	.xl
	.autsiz
	.databank ?

	stz wEventEngineTruthFlag,b

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta wR0

	lda [lR24]
	cmp wR0
	bne +

	inc wEventEngineTruthFlag,b

	+
	inc y
	inc y
	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_SET_FLAG ; 8C/862A

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	jsl rlSetEventFlag

	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNSET_FLAG ; 8C/8641

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	jsl rlUnsetEventFlag

	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_TEST_FLAG_SET ; 8C/8658

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda #$0000
	sta wEventEngineTruthFlag,b

	lda [lR22],y
	and #$00FF
	jsl rlTestEventFlagSet
	bcc +

	lda #$0001
	sta wEventEngineTruthFlag,b

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_STORE_BYTE ; 8C/867D

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	sep #$20
	lda [lR22],y
	sta [lR24]
	rep #$20

	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_STORE_WORD ; 8C/8696

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta [lR24]

	inc y
	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_STORE_LONG ; 8C/86AC

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta [lR24]

	inc y
	inc lR24
	lda [lR22],y
	sta [lR24]

	inc y
	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_STORE_BYTE_FROM ; 8C/86C9

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta lR25
	inc y

	lda [lR22],y
	sta lR25+1
	inc y
	inc y

	sep #$20
	lda [lR25]
	sta [lR24]
	rep #$20

	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_STORE_WORD_FROM ; 8C/86EC

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta lR25
	inc y

	lda [lR22],y
	sta lR25+1
	inc y
	inc y

	lda [lR25]
	sta [lR24]

	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_STORE_LONG_FROM ; 8C/870B

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR22],y
	sta lR25
	inc y

	lda [lR22],y
	sta lR25+1
	inc y
	inc y

	lda [lR25]
	sta [lR24]
	inc lR24
	inc lR25

	lda [lR25]
	sta [lR24]

	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_ADD_BYTE ; 8C/8732

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	sep #$20
	lda [lR24]
	clc
	clc
	adc [lR22],y
	sta [lR24]
	rep #$20

	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_ADD_WORD ; 8C/874F

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR24]
	clc
	clc
	adc [lR22],y
	sta [lR24]

	inc y
	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_ADD_LONG ; 8C/8769

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	sep #$20

	lda [lR24]
	clc
	clc
	adc [lR22],y
	sta [lR24]
	inc y
	inc lR24

	lda [lR24]
	clc
	adc [lR22],y
	sta [lR24]
	inc y
	inc lR24

	lda [lR24]
	clc
	adc [lR22],y
	sta [lR24]
	inc y

	rep #$20

	sty wEventExecutionOffset,b
	clc
	rts

rsEventCodeHandler_ORR_BYTE ; 8C/879A

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	sep #$20
	lda [lR24]
	ora [lR22],y
	sta [lR24]
	rep #$20

	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_ORR_WORD ; 8C/87B5

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	lda [lR24]
	ora [lR22],y
	sta [lR24]

	inc y
	inc y
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_ORR_LONG ; 8C/87CD

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR22],y
	sta lR24
	inc y

	lda [lR22],y
	sta lR24+1
	inc y
	inc y

	sep #$20
	lda [lR24]
	ora [lR22],y
	sta [lR24]
	inc y
	inc lR24

	lda [lR24]
	ora [lR22],y
	sta [lR24]
	inc y
	inc lR24

	lda [lR24]
	ora [lR22],y
	sta [lR24]
	inc y

	rep #$20
	sty wEventExecutionOffset,b

	clc
	rts

rsEventCodeHandler_CALL_ASM_SKIPPABLE ; 8C/87FA

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR19
	inc y

	lda [lR22],y
	sta lR19+1
	inc y
	inc y

	lda [lR22],y
	tax

	lda lR22
	pha
	lda lR22+1
	pha

	jsl _Goto_lR19

	pla
	sta lR22+1
	pla
	sta lR22

	+
	pla
	clc
	adc #$0005
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	_Goto_lR19
	txa
	jmp [lR19]

rsEventCodeHandler_CALL_ASM_LONG_SKIPPABLE ; 8C/8832

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR19
	inc y

	lda [lR22],y
	sta lR19+1
	inc y
	inc y

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1

	lda lR22
	pha
	lda lR22+1
	pha

	jsl _Goto_lR19

	pla
	sta lR22+1
	pla
	sta lR22

	+
	pla
	clc
	adc #$0006
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	_Goto_lR19
	jmp [lR19]

rsEventCodeHandler_CALL_ASM_LOOP ; 8C/886F

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	sta lR19
	inc y

	lda [lR22],y
	sta lR19+1
	inc y
	inc y

	lda [lR22],y
	tax

	lda lR22
	pha
	lda lR22+1
	pha

	jsl _Goto_lR19

	pla
	sta lR22+1
	pla
	sta lR22
	bcs +

	pla
	clc
	adc #$0005
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	+
	ply
	dec y

	plp
	sec
	rts

	_Goto_lR19
	txa
	jmp [lR19]

rsEventCodeHandler_UNK_28 ; 8C/88A6

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	phx
	lda #(`procUnknown828F09)<<8
	sta lR43+1
	lda #<>procUnknown828F09
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0006
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_29 ; 8C/88CC

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsl $87C851
	jsl $87C886
	jsl $95800B

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_2A ; 8C/88F6

	.al
	.xl
	.autsiz
	.databank ?

	phy
	jsl $87C893
	ply
	clc
	rts

rsEventCodeHandler_DIALOGUE ; 8C/88FE

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lEventEngineLongParameter,b
	inc y
	lda [lR22],y
	sta lEventEngineLongParameter+1,b

	phx
	lda #(`procDialogue)<<8
	sta lR43+1
	lda #<>procDialogue
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_DIALOGUE_ARRAY ; 8C/892F

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda #$0000
	sta wEventEngineTruthFlag,b

	lda [lR22],Y
	sta lR19
	inc y
	lda [lR22],Y
	sta lR19+1

	lda wEventEngineCharacterTarget,b
	sta wR0
	jsr rsFindQuoteTableEntry
	bcs +

	lda lR18
	sta lEventEngineLongParameter,b
	lda lR18+1
	sta lEventEngineLongParameter+1,b

	phx
	lda #(`procDialogue)<<8
	sta lR43+1
	lda #<>procDialogue
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive

	plx
	lda #$0001
	sta wEventEngineTruthFlag,b

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_2D ; 8C/897E

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	phx
	lda #(`procDialogueUnknown828A38)<<8
	sta lR43+1
	lda #<>procDialogueUnknown828A38
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0005
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_SET_MUSIC ; 8C/89A4

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$00FF
	cmp wCurrentMapMusic,b
	beq +

	sta wCurrentMapMusic,b
	sta aUnknown0004BA,b

	phx
	lda #(`procMusicEvent)<<8
	sta lR43+1
	lda #<>procMusicEvent
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	ply
	inc y
	sty wEventExecutionOffset,b

	plp
	sec
	rts

rsEventCodeHandler_UNK_32 ; 8C/89A4

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$00FF
	jsl rlUnknown808C87

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_NOP_33 ; 8C/89F5

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$00FF

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_PLAY_SOUND_BYTE ; 8C/8A10

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$00FF
	jsl rlUnknown808CDD

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_PLAY_SOUND_WORD ; 8C/8A2F

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	jsl rlUnknown808C7D

	+
	pla
	clc
	adc #$0002
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_RESET_PHASE_MUSIC ; 8C/8A4B

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsl $83A5A4

	phx
	lda #(`procMusicEvent)<<8
	sta lR43+1
	lda #<>procMusicEvent
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_2E ; 8C/8A75

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsl $95849C

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_2F ; 8C/8A97

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	jsl $9584C3

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_30 ; 8C/8ABA

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	jsl $9584D0

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_SCROLL_CAMERA_CHAR ; 8C/8ADD

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	jsl rlScrollCameraCharEffect

	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_SET_ACTIVE_COORDS ; 8C/8AF4

	.al
	.xl
	.autsiz
	.databank ?

	php

	lda @l wEventEngineXCoordinate
	cmp #$FFFF
	beq +

	lda @l wEventEngineYCoordinate
	cmp #$FFFF
	beq +

	lda @l wEventEngineXCoordinate
	sta wR0
	lda @l wEventEngineYCoordinate
	sta wR1
	jsl $83C181

	+
	plp
	clc
	rts

rsEventCodeHandler_SET_CAMERA ; 8C/8B1A

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	sta wEventEngineXCoordinate,b
	inc y

	lda [lR22],y
	and #$00FF
	sta wEventEngineYCoordinate,b

	jsr rsUnknown8C8B4C

	lda lR22
	pha
	lda lR22+1
	pha

	jsl rlUpdateUnitMapsAndFog

	pla
	sta lR22+1
	pla
	sta lR22
	pla

	clc
	adc #$0002
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsUnknown8C8B4C ; 8C/8B4C

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineXCoordinate,b
	sec
	sbc #$0008
	bge +

	lda #$0000

	+
	asl a
	asl a
	asl a
	asl a
	cmp wMapWidthPixels,b
	blt +

	lda wMapWidthPixels,b

	+
	sta wMapScrollWidthPixels,b

	lda wEventEngineYCoordinate,b
	sec
	sbc #$0008
	bge +

	lda #$0000

	+
	asl a
	asl a
	asl a
	asl a
	cmp wMapHeightPixels,b
	blt +

	lda wMapHeightPixels,b

	+
	sta wMapScrollHeightPixels,b
	rts

rsEventCodeHandler_UNK_3A ; 8C/8B83

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$003F
	sta wUnknown00033F,b

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_NOP_3B ; 8C/8BA1

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	lda wEventEngineStatus,b
	bit #$4000
	bne +

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_NOP_3C ; 8C/8BB7

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	and #$00FF
	inc y

	lda [lR22],y
	and #$00FF
	inc y

	lda [lR22],y
	and #$00FF

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_SCROLL_CAMERA_SPEED ; 8C/8BDE

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	sta wEventEngineXCoordinate,b
	inc y

	lda [lR22],y
	and #$00FF
	sta wEventEngineYCoordinate,b
	inc y

	lda [lR22],y
	and #$00FF
	sta wR2

	jsr rsUnknown8C8C20

	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_SET_CAMERA_SPEED ; 8C/8C08

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	and #$00FF
	sta wR2

	jsr rsUnknown8C8C20

	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsUnknown8C8C20 ; 8C/8C20

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineStatus,b
	bit #$4000
	beq +

	jsr rsUnknown8C8B4C
	bra ++

	+
	lda @l wEventEngineXCoordinate
	sta wR0

	lda @l wEventEngineYCoordinate
	sta wR1

	lda wR2
	sta wR3

	jsl rlUnknown81B495

	phx
	lda #(`procMapScroll)<<8
	sta lR43+1
	lda #<>procMapScroll
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	rts

rsEventCodeHandler_FADE_IN ; 8C/8C52

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsl rlEventEngineCancelFading

	phx
	lda #(`procEventFadeIn)<<8
	sta lR43+1
	lda #<>procEventFadeIn
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_FADE_OUT ; 8C/8C7C

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsl rlEventEngineCancelFading

	phx
	lda #(`procEventFadeOut)<<8
	sta lR43+1
	lda #<>procEventFadeOut
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0001
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_PAUSE_SKIPPABLE ; 8C/8CA6

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	phx
	lda #(`procEventPause)<<8
	sta lR43+1
	lda #<>procEventPause
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0002
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_PAUSE ; 8C/8CCC

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	phx
	lda #(`procEventPause)<<8
	sta lR43+1
	lda #<>procEventPause
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx
	pla
	clc
	adc #$0002
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_20 ; 8C/8CEA

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	rep #$30
	lda bBuf_INIDISP
	and #$0050
	bne +

	phx
	lda #(`procEventPauseUntilButton)<<8
	sta lR43+1
	lda #<>procEventPauseUntilButton
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_UNK_21 ; 8C/8D19

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	rep #$30
	phx
	lda #(`procEventPauseUntilTimeOrButton)<<8
	sta lR43+1
	lda #<>procEventPauseUntilTimeOrButton
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0002
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsUnknown8C8D41 ; 8C/8D41

	.autsiz
	.databank ?

	rep #$30

rsEventCodeHandler_HALT_UNTIL_BYTE ; 8C/8D43

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	inc y
	inc y

	sep #$20
	lda [lR22],y
	cmp [lR18]
	rep #$20
	bne +

	pla
	clc
	adc #$0004
	sta wEventExecutionOffset,b
	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsUnknown8C8D6B ; 8C/8D6B

	.autsiz
	.databank ?

	rep #$30

rsEventCodeHandler_HALT_UNTIL_WORD ; 8C/8D6D

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	inc y
	inc y

	lda [lR22],y
	cmp [lR18]
	bne +

	pla
	clc
	adc #$0005
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsUnknown8C8D91 ; 8C/8D91

	.autsiz
	.databank ?

	rep #$30

rsEventCodeHandler_HALT_UNTIL_BYTE_SKIPPABLE ; 8C/8D93

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	inc y
	inc y

	sep #$20
	lda [lR22],y
	cmp [lR18]
	rep #$20
	bne ++

	+
	pla
	clc
	adc #$0004
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsUnknown8C8DC3 ; 8C/8DC3

	.autsiz
	.databank ?

	rep #$30

rsEventCodeHandler_HALT_UNTIL_WORD_SKIPPABLE ; 8C/8DC5

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1
	inc y
	inc y

	lda [lR22],y
	cmp [lR18]
	bne ++

	+
	pla
	clc
	adc #$0005
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsEventCodeHandler_NOP_01 ; 8C/8DF1

	.al
	.xl
	.autsiz
	.databank ?

	clc
	rts

rsEventCodeHandler_MOVE_TEMPORARY ; 8C/8DF3

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsr rsUnknown8C8E3E
	jsr rsUnknown8C94D1
	bcs ++

	+
	pla
	clc
	adc #$0009
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsEventCodeHandler_MOVE_TEMPORARY_UNK ; 8C/8E16

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	jsr rsUnknown8C8E3E

	lda #$0001
	sta wR4
	jsr rsUnknown8C94D1
	bcs ++

	+
	pla
	clc
	adc #$0009
	sta wEventExecutionOffset,b
	tay
	plp
	clc
	rts

	+
	ply
	dec y
	plp
	sec
	rts

rsUnknown8C8E3E ; 8C/8E3E

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lR22
	pha
	lda lR22+1
	pha

	lda [lR22],y
	phy

	jsl rlEventGetMoveUnitTargetByCharacter

	ply
	pla
	sta lR22+1
	pla
	sta lR22

	lda $7E49F1
	sta wR1
	inc y
	inc y

	lda [lR22],y
	and #$00FF
	sta wR2
	inc y

	lda [lR22],y
	and #$00FF
	sta wR3
	inc y

	lda [lR22],y
	and #$000F
	asl a
	asl a
	asl a
	asl a
	sta wR5

	lda [lR22],y
	and #$00F0
	inc y

	lda [lR22],y
	and #$00FF
	tax
	lda _AllegianceTable,x
	and #$00FF
	sta wR0
	inc y

	lda [lR22],y
	sta lR18
	inc y
	lda [lR22],y
	sta lR18+1

	lda #$0000
	sta wR4

	lda #$0000
	sta wR6

	plp
	plb
	rts

	_AllegianceTable ; 8C/8EA4
		.byte Player
		.byte Enemy
		.byte NPC
		.byte Player
		.byte Player
		.byte Player

rsEventCodeHandler_MOVE_UNIT ; 8C/8EAA

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	beq +

	jsr rsUnknown8C8F31
	bcc _Continue

	phy
	lda lR22
	pha
	lda lR22+1
	pha

	sep #$20
	lda $7E49E9
	sta aBurstWindowCharacterBuffer.X,b
	rep #$20

	sep #$20
	lda $7E49EA
	sta aBurstWindowCharacterBuffer.Y,b
	rep #$20

	lda #aBurstWindowCharacterBuffer
	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83905C
	jsl rlUnknown8CA0C8
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $839041

	pla
	sta lR22+1
	pla
	sta lR22
	ply

	bra _Continue

	+
	jsr rsUnknown8C9E74
	bcs _Loop

	jsr rsUnknown8C8F31
	bcc _Continue

	lda $7E49F1
	sta wR0
	jsr rsUnknown8C9E33
	bcs _Loop

	lda $7E49F3
	bne +

	jsr rsUnknown8C91A3
	jsr rsUnknown8C920D
	bra _Continue

	+
	jsr rsUnknown8C921C

	_Continue
	pla
	clc
	adc #$000B
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

	_Loop
	ply
	dec y
	plp
	sec
	rts

rsUnknown8C8F31 ; 8C/8F31

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

	lda #$0000
	sta $7E49F3

	lda lR22
	pha
	lda lR22+1
	pha

	lda [lR22],y
	pha
	inc y
	inc y

	lda [lR22],y
	and #$00FF
	sta wR0
	inc y

	lda [lR22],y
	and #$00FF
	sta wR1
	inc y

	pla
	phy
	jsl rlEventMOVE_UNITGetTargetType

	ply
	pla
	sta lR22+1
	pla
	sta lR22

	bcc ++

	sep #$20
	lda [lR22],y
	sta $7E49E9
	rep #$20
	inc y

	sep #$20
	lda [lR22],y
	sta $7E49EA
	rep #$20
	inc y

	lda [lR22],y
	and #$000F
	asl a
	asl a
	asl a
	asl a
	sta $7E49F6
	inc y

	lda [lR22],y
	sta $7E49F3
	inc y

	lda [lR22],y
	sta $7E49F4
	inc y

	phy
	lda $7E49F3
	beq +

	jsl rsUnknown8C8FB0

	+
	ply
	inc y
	plx
	plp
	plb
	sec
	rts

	+
	plx
	plp
	plb
	clc
	rts

rsUnknown8C8FB0 ; 8C/8FB0

	.al
	.xl
	.autsiz
	.databank ?

	php

	lda $7E49F3
	sta lR18

	lda $7E49F3+1
	sta lR18+1

	jsl $8A9CC3

	sep #$20
	lda $7E49E7
	clc
	adc wR0
	sta $7E49E9

	lda $7E49E8
	clc
	adc wR1
	sta $7E49EA

	rep #$20
	plp
	rtl

rlEventMOVE_UNITGetTargetType ; 8C/8FDD

	.al
	.xl
	.autsiz
	.databank ?

	and #$FFFF
	beq _ByCoordinates

	cmp #$FFFF
	beq _ByActiveUnit

	jmp rlEventGetMoveUnitTargetByCharacter

	_ByCoordinates
	jmp rlEventGetMoveUnitTargetByCoordinates

	_ByActiveUnit
	jmp rlEventGetMoveUnitTargetByActiveUnit

rsEventCodeHandler_LOAD1 ; 8C/8FF0

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$01
	sta bEventEngineUnitLoadingFlag,b
	rep #$20
	bra rsEventLOADMain

rsEventCodeHandler_LOAD2 ; 8C/8FFB

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$00
	sta bEventEngineUnitLoadingFlag,b
	rep #$20

rsEventLOADMain ; 8C/9004

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda #$0000
	sta $7E49F6

	lda lEventEngineUnitGroupPointer,b
	bne +

	lda [lR22],y
	sta lEventEngineUnitGroupPointer,b
	inc y
	lda [lR22],y
	sta lEventEngineUnitGroupPointer+1,b

	+
	lda lEventEngineUnitGroupPointer+1,b
	sta lR18+1
	lda lEventEngineUnitGroupPointer,b
	sta lR18

	lda wEventEngineStatus,b
	bit #$4000
	beq +

	jsr rsUnknown8C94B4
	bcc _Loop
	bcs _Continue

	+
	ldy #$0000
	lda [lR18],y
	beq _Continue

	jsr rsUnknown8C9E74
	bcs _Loop

	ldy #$0000
	lda [lR18],y
	jsl $83941A

	lda $7E5138
	and #$00FF
	lda $7E5138
	and #$00FF
	sta wR0

	jsr rsUnknown8C9E33
	bcs _Loop

	jsr rsUnknown8C90DE
	bcs +

	jsr rsUnknown8C9151
	jsr rsUnknown8C91A3
	jsr rsUnknown8C91C0

	+
	lda lEventEngineUnitGroupPointer,b
	clc
	adc #$0014
	sta lEventEngineUnitGroupPointer,b
	bra _Loop

	_Continue
	stz lEventEngineUnitGroupPointer,b
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b
	tay
	plp
	clc
	rts

	_Loop
	ply
	dec y
	plp
	sec
	rts

rsEventCodeHandler_SCROLL_CAMERA_ADDRESS ; 8C/908E

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda [lR22],y
	sta lR18
	inc y

	lda [lR22],y
	sta lR18+1

	ldy #$0000
	lda [lR18],y
	and #$00FF
	sta wR0
	inc y

	lda [lR18],y
	and #$00FF
	sta wR1
	ora wR0
	beq +

	lda #$0004
	sta wR2
	sta wR3

	jsl rlUnknown81B495

	phx
	lda #(`procMapScroll)<<8
	sta lR43+1
	lda #<>procMapScroll
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	pla
	clc
	adc #$0003
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsUnknown8C90DE ; 8C/90DE

	.al
	.xl
	.autsiz
	.databank ?

	phx

	lda bEventEngineUnitLoadingFlag,b
	and #$00FF
	bne +

	ldy #$0004
	lda [lR18],y
	and #$00FF
	sta wR0

	ldy #$0005
	lda [lR18],y
	and #$00FF
	sta wR1

	jsl rlCheckTileOccupied
	bcs +++

	+
	lda lR18
	pha
	lda lR18+1
	pha

	lda #$0001
	jsl $839457
	bcs +

	lda aSelectedCharacterBuffer.TurnStatus,b
	ora #TurnStatusActing
	sta aSelectedCharacterBuffer.TurnStatus,b

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $839041

	lda #(`aSelectedCharacterBuffer)<<8
	sta lR18+1
	lda #<>aSelectedCharacterBuffer
	sta lR18

	lda #(`aBurstWindowCharacterBuffer)<<8
	sta lR19+1
	lda #<>aBurstWindowCharacterBuffer
	sta lR19

	lda #len(aSelectedCharacterBuffer)
	sta wR20
	jsl rlBlockCopy

	pla
	sta lR18+1
	pla
	sta lR18

	plx
	clc
	rts

	+
	pla
	sta lR18+1
	pla
	sta lR18

	+
	plx
	sec
	rts

rsUnknown8C9151 ; 8C/9151

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

	ldy #$0000
	lda [lR18],y
	and #$00FF
	sta $7E49ED

	lda aBurstWindowCharacterBuffer.Class,b
	and #$00FF
	sta $7E49EF

	lda aBurstWindowCharacterBuffer.SpriteInfo1,b
	and #$00FF
	sta $7E49F1

	ldy #$0002
	lda [lR18],y
	and #$00C0
	xba
	ora $7E49EF
	sta $7E49EF

	ldy #$0002
	lda [lR18],y
	and #$3F3F
	sta $7E49E7

	ldy #$0004
	lda [lR18],y
	and #$3F3F
	sta $7E49E9

	plx
	plp
	plb
	rts

rsUnknown8C91A3 ; 8C/91A3

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda #(`$7E49F8)<<8
	sta $7E49F4
	lda _aUnknown8C91B8,x
	sta $7E49F3
	plp
	plb
	rts

	_aUnknown8C91B8 ; 8C/91B8
		.word <>$7E49F8
		.word <>$7E4A78
		.word <>$7E4AF8
		.word <>$7E4B78

rsUnknown8C91C0 ; 8C/91C0

	.al
	.xl
	.autsiz
	.databank ?

	lda aBurstWindowCharacterBuffer.DeploymentNumber,b
	and #$00FF
	ora #$0400
	sta $7E49EB

	ora #$1000
	sta @l aUnknown0017BF,x

	lda $7E49E8
	xba 
	ora $7E49E7
	sta @l aUnknown0017C7,x

	lda $7E49F6
	sta @l aUnknown0017CF,x

	lda #$0020
	tsb wEventEngineStatus,b
	rts

rsUnknown8C91F0 ; 8C/91F0

	.al
	.xl
	.autsiz
	.databank ?

	lda aBurstWindowCharacterBuffer.DeploymentNumber,b
	and #$00FF
	ora #$0400
	sta $7E49EB

	ora #$1000
	sta @l aUnknown0017BF,x

	lda $7E49F6
	sta @l aUnknown0017CF,x

	rts

rsUnknown8C920D ; 8C/920D

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown8C91C0

	lda @l aUnknown0017BF,x
	ora #$0200
	sta @l aUnknown0017BF,x

	rts

rsUnknown8C921C ; 8C/921C

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown8C91F0

	lda @l aUnknown0017BF,x
	ora #$0200
	sta @l aUnknown0017BF,x

	rts

rlEventGetMoveUnitTargetByCharacter ; 8C/922B

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
	phy

	sta $7E49ED

	pha
	php

	jsl $83941A

	plp
	lda $7E5136
	and #$00FF
	sta $7E49EF

	lda $7E5138
	and #$00FF
	sta $7E49F1

	lda #$0000
	sta $7E49E7

	pla
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83976E
	and #$FFFF
	bne +

	lda aBurstWindowCharacterBuffer.Class,b
	and #$00FF
	sta $7E49EF

	lda aBurstWindowCharacterBuffer.SpriteInfo1,b
	and #$00FF
	sta $7E49F1

	lda aBurstWindowCharacterBuffer.X,b
	and #$00FF
	sta $7E49E7

	lda aBurstWindowCharacterBuffer.Y,b
	and #$00FF
	sta $7E49E8

	lda aBurstWindowCharacterBuffer.DeploymentNumber,b
	and #$00C0
	xba
	ora $7E49EF
	sta $7E49EF

	ply
	plx
	plp
	plb
	sec
	rtl

	+
	ply
	plx
	plp
	plb
	clc
	rtl

rlEventGetMoveUnitTargetByActiveUnit ; 8C/92AD

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
	phy

	lda #aSelectedCharacterBuffer
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83905C

	lda aBurstWindowCharacterBuffer.Character,b
	sta $7E49ED

	lda aBurstWindowCharacterBuffer.Class,b
	and #$00FF
	sta $7E49EF

	lda aBurstWindowCharacterBuffer.SpriteInfo1,b
	and #$00FF
	sta $7E49F1

	lda aBurstWindowCharacterBuffer.Class,b
	and #$00FF
	sta $7E49EF

	lda aBurstWindowCharacterBuffer.SpriteInfo1,b
	and #$00FF
	sta $7E49F1

	lda aBurstWindowCharacterBuffer.X,b
	and #$00FF
	sta $7E49E7

	lda aBurstWindowCharacterBuffer.Y,b
	and #$00FF
	sta $7E49E8

	lda aBurstWindowCharacterBuffer.DeploymentNumber,b
	and #Player | Enemy | NPC
	xba
	ora $7E49EF
	sta $7E49EF

	ply
	plx
	plp
	plb
	sec
	rtl

	+
	ply
	plx
	plp
	plb
	clc
	rtl

rlEventGetMoveUnitTargetByCoordinates ; 8C/931F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank ?

	phx

	jsl rlSetupMoveTargetByCoordinates
	bcc +

	lda aBurstWindowCharacterBuffer.Class,b
	and #$00FF
	sta $7E49EF

	lda aBurstWindowCharacterBuffer.SpriteInfo1,b
	and #$00FF
	sta $7E49F1

	lda aBurstWindowCharacterBuffer.X,b
	and #$00FF
	sta $7E49E7

	lda aBurstWindowCharacterBuffer.Y,b
	and #$00FF
	sta $7E49E8

	lda aBurstWindowCharacterBuffer.DeploymentNumber,b
	and #Player | Enemy | NPC
	xba 
	ora $7E49EF
	sta $7E49EF

	plx
	plp
	plb
	sec
	rtl

	+
	plx
	plp
	plb
	clc
	rtl

rlUnknown8C936B ; 8C/936B

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineStatus,b
	bit #$0020
	bne +

	jmp _End

	+
	lda $7E49EB
	sta wR0

	lda #<>aSelectedCharacterBuffer
	sta wR1

	jsl $83901C

	lda $7E49E7
	and #$00FF
	sta wR0

	lda $7E49E8
	and #$00FF
	sta wR1

	lda $7E49E9
	and #$00FF
	sta wR2

	lda $7E49EA
	and #$00FF
	sta wR3

	lda $7E49EF
	and #$00FF
	sta wR4

	lda $7E49F4
	sta lR18+1

	lda $7E49F3
	sta lR18

	jsl rlUnknown8C9418

	sep #$20
	lda wR0
	sta $7E49E9
	rep #$20

	sep #$20
	lda wR1
	sta $7E49EA
	rep #$20

	lda $7E49E7
	and #$00FF
	sta wR0

	lda $7E49E8
	and #$00FF
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	lda aVisibilityMap,x
	and #$00FF
	beq +

	sep #$20
	lda bBuf_INIDISP
	cmp #INIDISP.Brightness
	bne +

	lda [lR18]
	cmp #$00
	bne +

	lda #$0F
	sta [lR18]

	lda #$00
	ldy #$0001
	sta [lR18],y

	+
	rep #$20
	lda #$0020
	trb wEventEngineStatus,b

	_End
	rtl

rlUnknown8C9418 ; 8C/9418

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank ?

	lda wR0
	pha
	lda wR1
	pha
	lda wR0
	pha
	lda wR1
	pha

	lda wR2
	sta wR0
	lda wR3
	sta wR1

	pla
	sta wR3
	pla
	sta wR2

	jsl rlGetMapTileIndexByCoords
	tax
	lda aTerrainMap,x
	and #$00FF
	cmp #TerrainDoor
	bne +

	sep #$20
	lda #$FF
	sta aPlayerVisibleUnitMap,x
	sta aUnitMap,x
	rep #$20

	+
	jsl $8DB420
	jsl rlGetMapTileIndexByCoords
	tax
	sep #$20
	lda @l aSelectedCharacterBuffer.DeploymentNumber
	sta aPlayerVisibleUnitMap,x
	sta aUnitMap,x
	rep #$20

	pla
	sta wR3
	pla
	sta wR2

	lda wR0
	pha
	lda wR1
	pha

	lda wR0
	cmp wR2
	bne +

	lda wR1
	cmp wR3
	beq ++

	+
	lda wR2
	sta wR0
	lda wR3
	sta wR1

	jsl rlGetMapTileIndexByCoords
	tax
	sep #$20
	lda aPlayerVisibleUnitMap,x
	cmp @l aSelectedCharacterBuffer.DeploymentNumber
	bne +

	lda #$00
	sta aPlayerVisibleUnitMap,x
	sta aUnitMap,x

	+
	rep #$20
	pla
	sta wR1
	pla
	sta wR0
	plp
	plb
	rtl

rsUnknown8C94B4 ; 8C/94B4

	.al
	.xl
	.autsiz
	.databank ?

	lda lEventEngineUnitGroupPointer+1,b
	sta lR18+1
	lda lEventEngineUnitGroupPointer,b
	sta lR18
	lda [lR18]
	and #$00FF
	bne +

	jmp ++

	+
	lda #$0000
	jsl $839457

	+
	sec
	rts

rsUnknown8C94D1 ; 8C/94D1

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wR0
	pha
	jsr rsUnknown8C9E74

	pla
	sta wR0
	bcs +

	lda wR0
	pha
	lda wR1
	sta wR0
	jsr rsUnknown8C9E33

	pla
	sta wR0
	bcs +

	jsr rsUnknown8C94FA
	bcs +

	ply
	plp
	clc
	rts

	+
	ply
	plp
	sec
	rts

rsUnknown8C94FA ; 8C/94FA

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	lda wR6
	pha
	lda wR5
	pha
	lda lR18
	pha
	lda lR18+1
	pha

	jsl $8A8DC5

	-
	bcs -

	pla
	sta lR18+1
	pla
	sta lR18
	jsl $8A8FBC

	ply
	pla
	bcs +

	ora #$0100
	sta @l aUnknown0017BF,x
	tya
	sta @l aUnknown0017CF,x

	ply
	plp
	clc
	rts

	+
	ply
	plp
	sec
	rts

rsEventCodeHandler_WAIT_MOVE ; 8C/9530

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda wEventEngineStatus,b
	bit #$4000
	bne +

	lda #(`procUnitAction)<<8
	sta lR43+1
	lda #<>procUnitAction
	sta lR43
	jsl rlProcEngineFindProc
	bcs +

	jsl rlEventEngineCreateProcAndSetActive

	+
	pla
	clc
	adc #$0000
	sta wEventExecutionOffset,b

	tay
	plp
	clc
	rts

rsEventCodeHandler_WARP_UNIT ; 8C/955A

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy

	lda lR22
	pha
	lda lR22+1
	pha

	lda [lR22],y
	pha
	inc y
	inc y

	lda [lR22],y
	and #$00FF
	sta wR0
	inc y

	lda [lR22],y
	and #$00FF
	sta wR1
	inc y

	pla
	phy
	jsl rlEventMOVE_UNITGetTargetType

	ply
	pla
	sta lR22+1
	pla
	sta lR22

	bcc _Continue

	sep #$20
	lda [lR22],y
	sta $7E49E9

	rep #$20
	inc y
	sep #$20
	lda [lR22],y
	sta $7E49EA
	rep #$20
	inc y

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsr rsUnknown8CA02F

	sep #$20
	lda $7E49E9
	sta aBurstWindowCharacterBuffer.X,b
	rep #$20

	sep #$20
	lda $7E49EA
	sta aBurstWindowCharacterBuffer.Y,b
	rep #$20

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsr rsUnknown8CA04E

	_Continue
	pla
	clc
	adc #$0006
	sta wEventExecutionOffset,b
	tay
	plp
	clc
	rts

	_Loop
	ply
	dec y
	plp
	sec
	rts

rlUnknown8C95D3 ; 8C/95D3

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda wEventEngineStatus,b
	bne ++

	ldy #$0000

	-
	lda [lR18],y
	cmp #$FFFF
	beq ++

	jsr rsEventEngineHandleEventDefinition
	bcs +

	tya
	clc
	adc lR18
	sta lR18
	ldy #$0000
	bra -

	+
	plp
	plb
	sec
	rtl

	+
	ldy #$0000
	plp
	plb
	clc
	rtl

rlUnknown8C9601 ; 8C/9601

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lR18
	sta lEventEngineEventDefinitionPointer,b
	lda lR18+1
	sta lEventEngineEventDefinitionPointer+1,b
	jsl rlUnknown8C95D3
	bcc +

	lda lR18+1
	sta lEventEngineEventDefinitionPointer+1,b

	tya
	clc
	adc lR18
	sta lEventEngineEventDefinitionPointer,b

	jsr rsUnknown8C972F

	lda wEventEngineStatus,b
	beq +

	plp
	plb
	sec
	rtl

	+
	lda #$0000
	sta lEventEngineEventDefinitionPointer,b

	plp
	plb
	clc
	rtl

rlEventEngineGetTriggeredLocationEvents ; 8C/9637

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank ?

	ldy #$0000

	_Loop
	lda [lR18],y
	cmp #$FFFF
	beq _End

	jsr rsEventEngineHandleEventDefinition

	phy
	lda lR18
	pha
	lda lR18+1
	pha

	ldy #$0000
	lda [lR18],y
	and #$00FF
	cmp #$0021
	blt +

	jsl rlTestEventFlagSet
	bcc +

	jsr rsUnknown8C972F

	lda #$4000
	tsb wEventEngineStatus,b

	-
	jsl rlDoEventEngineCycleWrapper
	lda wEventEngineStatus,b
	bne -

	+
	pla
	sta lR18+1
	pla
	sta lR18

	ply
	tya
	clc
	adc lR18
	sta lR18

	ldy #$0000
	bra _Loop

	_End
	plp
	plb
	rtl

rlUnknown8C9689 ; 8C/9689

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown001730,b

	lda bBuf_INIDISP
	pha

	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	rep #$20

	jsl rlASMCDecompressChapterMapChanges

	pla
	sta bBuf_INIDISP

	jsr rsGetLocationEventDefinitionArrayPointer
	jsl rlEventEngineGetTriggeredLocationEvents
	jsl rlGetTriggeredRandomChests

	lda #$0000
	sta wUnknown001730,b

	lda #$00E8
	jsl rlUnknown808C7D

	rtl

eventEventDefinitionTestEvents ; 8C/96BA
	EVENT $01, $FFFFFF
		CHECK_CHARS2 Leif, Finn
		CHECK_COORDS [1, 2]
		CMP_BYTE $000000, $FF
		CMP_WORD $000000, $FFFF
		CMP_LONG $000000, $FFFFFF

rsEventEngineHandleEventDefinition ; 8C/96D8

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda #$0001
	sta lR19
	ldy #$0004

	-
	lda [lR18],y
	and #$00FF
	cmp #$00FF
	beq +

	inc y
	phy 
	asl a
	tay 
	lda <>aEventDefinitionTable,b,y
	ply
	sta lR23

	lda lR19
	pha
	pea <>_Return - 1
	jmp (lR23)

	_Return
	pla
	sta lR19
	bcs -

	lda #$0000
	sta lR19
	bra -

	+
	inc y
	cpy #$0005
	beq +

	lda lR19
	beq +

	phy
	ldy #$0000
	lda [lR18],y
	and #$00FF
	jsl rlTestEventFlagSet
	ply
	bcs +

	plp
	plb
	sec
	rts

	+
	plp
	plb
	clc
	rts

rsUnknown8C972F ; 8C/972F

	.al
	.xl
	.autsiz
	.databank ?

	phy

	lda lR18
	pha
	lda lR18+1
	pha

	jsr rsUnknown8C9757
	inc y

	lda [lR18],y
	sta wR0
	inc y

	lda [lR18],y
	sta lR18+1
	ora wR0
	beq +

	lda wR0
	sta lR18
	jsl rlUnknown8C839F

	+
	pla
	sta lR18+1
	pla
	sta lR18
	ply
	rts

rsUnknown8C9757 ; 8C/9757

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0000
	lda [lR18],y
	and #$00FF
	jsl rlSetEventFlag
	rts

aEventDefinitionTable ; 8C/9764
	.addr rsEventDefinitionHandler_CHECK_CHARS
	.addr rsEventDefinitionHandler_CHECK_CHARS
	.addr rsEventDefinitionHandler_CHECK_SINGLE
	.addr rsEventDefinitionHandler_CHECK_COORDS
	.addr rsEventDefinitionHandler_CMP_BITS
	.addr rsEventDefinitionHandler_CMP_BYTE
	.addr rsEventDefinitionHandler_CMP_WORD
	.addr rsEventDefinitionHandler_CMP_LONG
	.addr rsEventDefinitionHandler_CMP_WORD_FALSE
	.addr rsEventDefinitionHandler_CMP_BYTE_AT
	.addr rsEventDefinitionHandler_CMP_WORD_AT
	.addr rsEventDefinitionHandler_CMP_BYTE_RANGE
	.addr rsEventDefinitionHandler_CMP_WORD_RANGE
	.addr rsEventDefinitionHandler_TEST_FLAG_SET
	.addr rsEventDefinitionHandler_TEST_FLAG_UNSET
	.addr rsEventDefinitionHandler_RUN_ASM
	.addr rsEventDefinitionHandler_CMP_STATUS_SET
	.addr rsEventDefinitionHandler_CMP_STATUS_UNSET
	.addr rsEventDefinitionHandler_UNK_12
	.addr rsEventDefinitionHandler_UNK_13
	.addr rsEventDefinitionHandler_CHECK_CARRYING
	.addr rsEventDefinitionHandler_UNK_15
	.addr rsEventDefinitionHandler_CHECK_NUM_UNITS_LTE
	.addr rsEventDefinitionHandler_CHECK_NUM_UNITS_GTE
	.addr rsEventDefinitionHandler_ROLL_RNG
	.addr rsEventDefinitionHandler_CHECK_IF_RANDOM_CHEST
	.addr rsEventDefinitionHandler_CHECK_DEAD
	.addr rsEventDefinitionHandler_CHECK_KILLED_IN_BATTLE

rsEventDefinitionHandler_CHECK_CHARS ; 8C/979C

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y
	beq +

	cmp wEventEngineCharacterStructParameter,b
	bne _NoMatch

	+
	lda [lR18],y
	beq _End

	cmp wEventEngineCharacterTarget,b
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	inc y
	inc y
	rts

rsEventDefinitionHandler_CHECK_SINGLE ; 8C/97B7

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	beq +

	cmp wEventEngineCharacterStructParameter,b
	bne +

	lda wEventEngineCharacterStructParameter,b
	sta wEventEngineCharacterTarget,b
	bra ++

	+
	lda [lR18],y
	beq _End

	cmp wEventEngineCharacterTarget,b
	bne _NoMatch

	lda wEventEngineCharacterTarget,b
	sta wEventEngineCharacterStructParameter,b

	+
	sec
	bra _End

	_NoMatch
	clc

	_End
	inc y
	inc y
	rts

rsEventDefinitionHandler_CHECK_COORDS ; 8C/97DE

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	and #$00FF
	cmp wEventEngineXCoordinate,b
	bne _NoMatch

	lda [lR18],y
	and #$00FF
	cmp wEventEngineYCoordinate,b
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	inc y
	rts

rsEventDefinitionHandler_CMP_BITS ; 8C/97F9

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	inc y
	sta wR0

	lda lR19
	bit wR0
	beq _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_BYTE ; 8C/980D

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	and #$00FF
	sta wR0

	lda lR19
	and #$00FF
	cmp wR0
	bne _NoMatch
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_WORD ; 8C/9826

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	inc y
	sta wR0

	lda lR19
	cmp wR0
	bne _NoMatch
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_LONG ; 8C/983A

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	sta wR0

	lda [lR18],y
	inc y
	inc y
	sta wR1

	lda lR19
	cmp wR0
	bne _NoMatch

	lda lR19+1
	cmp wR1
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_WORD_FALSE ; 8C/9859

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	inc y
	sta wR0

	lda lR19
	cmp wR0
	beq _NoMatch
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_BYTE_AT ; 8C/986D

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	sta lR20

	lda [lR18],y
	inc y
	inc y
	sta lR20+1

	lda [lR20]
	and #$00FF
	sta wR0

	lda lR19
	and #$00FF
	cmp wR0
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_WORD_AT ; 8C/9890

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	inc y
	sta lR20

	lda [lR18],y
	inc y
	inc y
	sta lR20+1

	lda [lR20]
	cmp lR19
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_BYTE_RANGE ; 8C/98A9

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	and #$00FF
	sta wR0
	inc y

	lda [lR18],y
	and #$00FF
	sta wR1
	inc y

	lda lR19
	and #$00FF
	cmp wR0
	bcc _NoMatch

	lda lR19
	and #$00FF
	beq +

	dec a
	cmp wR1
	bcs _NoMatch

	+
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_WORD_RANGE ; 8C/98D6

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsEventDefinitionCopyComparisonData

	lda [lR18],y
	sta wR0
	inc y
	inc y

	lda [lR18],y
	sta wR1
	inc y
	inc y

	lda lR19
	cmp wR0
	bcc _NoMatch

	lda lR19
	beq +

	dec a
	cmp wR1
	bcs _NoMatch

	+
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_TEST_FLAG_SET ; 8C/98F9

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	and #$00FF
	jsl rlTestEventFlagSet
	bcc _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_TEST_FLAG_UNSET ; 8C/990A

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	and #$00FF
	jsl rlTestEventFlagSet
	bcs _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_RUN_ASM ; 8C/991B

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	sta lR19
	inc y

	lda [lR18],y
	sta lR19+1
	inc y
	inc y

	phy
	lda lR18
	pha
	lda lR18+1
	pha

	phk
	pea <>_Return - 1
	jmp [lR19]

	_Return
	pla
	sta lR18+1
	pla
	sta lR18
	ply
	rts

rsEventDefinitionHandler_CMP_STATUS_SET ; 8C/993C

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y
	sta wEventEngineCharacterTarget,b

	lda [lR18],y
	sta wEventEngineParameter1,b
	inc y
	inc y

	phy
	ldy lR18
	phy
	ldy lR18+1
	phy

	jsl rlASMCCheckUnitTurnStatusSet

	ply
	sty lR18+1
	ply
	sty lR18
	ply

	lda wEventEngineTruthFlag,b
	beq _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CMP_STATUS_UNSET ; 8C/9966

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y
	sta wEventEngineCharacterTarget,b

	lda [lR18],y
	sta wEventEngineParameter1,b
	inc y
	inc y

	phy
	ldy lR18
	phy
	ldy lR18+1
	phy

	jsl rlASMCCheckUnitTurnStatusSet

	ply
	sty lR18+1
	ply
	sty lR18
	ply

	lda wEventEngineTruthFlag,b
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_UNK_12 ; 8C/9990

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	and #$00FF
	sta wEventEngineCharacterTarget,b

	lda [lR18],y
	and #$00FF
	sta wEventEngineParameter1,b
	inc y

	phy
	ldy lR18
	phy
	ldy lR18+1
	phy

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne _NoMatch

	lda #aBurstWindowCharacterBuffer
	sta wR1
	lda wEventEngineParameter1,b
	jsl rlEventFindItemInInventory

	ply
	sty lR18+1
	ply
	sty lR18
	ply

	and #$FFFF
	beq _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_UNK_13 ; 8C/99D9

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	and #$00FF
	sta wEventEngineParameter1,b
	inc y

	phy
	ldy lR18
	phy
	ldy lR18+1
	phy

	lda #$0E6F
	sta wR1
	lda wEventEngineParameter1,b
	jsl rlEventFindItemInInventory

	ply
	sty lR18+1
	ply
	sty lR18
	ply

	and #$FFFF
	beq _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CHECK_CARRYING ; 8C/9A06

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	pha
	inc y
	inc y

	phy
	lda @l aSelectedCharacterBuffer.Rescue
	and #$00FF
	sta wR0
	beq +

	lda #aItemSkillCharacterBuffer
	sta wR1
	jsl $83901C

	ply
	pla

	sta wR0
	lda @l aItemSkillCharacterBuffer.Character
	cmp wR0
	bne _NoMatch

	sec
	bra _End

	+
	ply
	pla

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_UNK_15 ; 8C/9A33

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	sta wR0
	inc y
	inc y

	phy
	lda #aItemSkillCharacterBuffer
	sta wR1
	jsl $83976E
	and #$FFFF
	bne _NoMatch

	lda @l aBurstWindowCharacterBuffer.TurnStatus
	bit #TurnStatusRescued
	beq _NoMatch

	lda @l aItemSkillCharacterBuffer.Rescue
	and #$00FF
	and #Player | Enemy | NPC
	cmp #Enemy
	bne _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	ply
	rts

rsEventDefinitionHandler_CHECK_NUM_UNITS_LTE ; 8C/9A66

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y

	phy
	sta wEventEngineCharacterTarget,b
	jsl rlASMCCountAllUnitUncapturedAlive

	ply
	lda [lR18],y
	and #$00FF
	inc y
	cmp wEventEngineParameter1,b
	blt _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CHECK_NUM_UNITS_GTE ; 8C/9A83

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y

	phy
	sta wEventEngineCharacterTarget,b
	jsl rlASMCCountAllUnitUncapturedAlive

	ply
	lda [lR18],y
	and #$00FF
	inc y
	cmp wEventEngineParameter1,b
	beq +
	bge _NoMatch

	+
	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_ROLL_RNG ; 8C/9AA2

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	and #$00FF
	beq _NoMatch

	inc y
	pha
	lda #100
	jsl rlUnknown80B0E6

	sta wR0
	pla
	cmp wR0
	bcc _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CHECK_IF_RANDOM_CHEST ; 8C/9ABE

	.al
	.xl
	.autsiz
	.databank ?

	lda wCursorXCoord,b
	sta wR0

	lda wCursorYCoord,b
	sta wR1

	jsl rlCheckIfRandomChest
	cmp #$FFFF
	beq _NoMatch

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CHECK_DEAD ; 8C/9AD6

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y
	sta wEventEngineCharacterTarget,b

	phy
	ldy lR18
	phy
	ldy lR18+1
	phy

	jsl rlASMCCountAllUnitUncapturedAlive

	ply
	sty lR18+1
	ply
	sty lR18
	ply

	lda wEventEngineParameter1,b
	bne _NoMatch

	lda #$0002
	jsl rlSetEventFlag

	sec
	bra _End

	_NoMatch
	clc

	_End
	rts

rsEventDefinitionHandler_CHECK_KILLED_IN_BATTLE ; 8C/9B00

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	inc y
	inc y
	sta wEventEngineCharacterTarget,b

	jsl rlCheckIfBattlingUnitDied

	rts

rsEventDefinitionCopyComparisonData ; 8C/9B0C

	.al
	.xl
	.autsiz
	.databank ?

	lda [lR18],y
	sta lR20
	inc y

	lda [lR18],y
	sta lR20+1
	inc y
	inc y

	phy
	ldy #$0000
	lda [lR20],y
	sta lR19

	inc y
	lda [lR20],y
	sta lR19+1

	ply
	rts

rlSetEventFlag ; 8C/9B26

	.al
	.xl
	.autsiz
	.databank ?

	cmp #$0000
	beq +

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	ldx lR18
	phx
	ldx lR18+1
	phx

	jsr rsGetEventFlagOffset
	lda [lR18],y
	ora wR0
	sta [lR18],y

	plx
	stx lR18+1
	plx
	stx lR18

	ply
	plx
	plp
	plb

	+
	rtl

rsGetEventFlagOffset ; 8C/9B4B

	.al
	.xl
	.autsiz
	.databank ?

	sta wR0

	ldy #<>aPermanentFlagsInfo
	bit #$0080
	bne +

	ldy #<>aTemporaryFlagsInfo

	+
	lda structEventFlagsInfo.Offset,b,y
	sta lR18
	lda structEventFlagsInfo.Offset+1,b,y
	sta lR18+1

	lda structEventFlagsInfo.Count,b,y
	and #$00FF
	inc a
	sta wR1

	lda wR0

	-
	beq -

	and #$007F
	cmp wR1

	-
	bge -

	jsr rsGetEventFlagBit
	rts

aTemporaryFlagsInfo .dstruct structEventFlagsInfo, aTemporaryEventFlags, size(aTemporaryEventFlags) * 8

aPermanentFlagsInfo .dstruct structEventFlagsInfo, aPermanentEventFlags, size(aPermanentEventFlags) * 8

rsGetEventFlagBit ; 8C/9B82

	.al
	.xl
	.autsiz
	.databank ?

	dec a
	pha

	lsr a
	lsr a
	lsr a
	tay

	pla
	and #%00000111
	tax
	lda <>_aEventFlagBitTable,b,x

	and #$00FF
	sta wR0

	rts

	_aEventFlagBitTable ; 8C/9B96
		.byte (1 << 0)
		.byte (1 << 1)
		.byte (1 << 2)
		.byte (1 << 3)
		.byte (1 << 4)
		.byte (1 << 5)
		.byte (1 << 6)
		.byte (1 << 7)

rlUnsetEventFlag ; 8C/9B9E

	.al
	.xl
	.autsiz
	.databank ?

	cmp #$0000
	beq +

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	ldx lR18
	phx
	ldx lR18+1
	phx

	jsr rsGetEventFlagOffset

	lda wR0
	eor #$FFFF
	sta wR0

	lda [lR18],y
	and wR0
	sta [lR18],y

	plx
	stx lR18+1
	plx
	stx lR18

	ply
	plx
	plp
	plb

	+
	rtl

rlTestEventFlagSet ; 8C/9BCA

	.al
	.xl
	.autsiz
	.databank ?

	cmp #$0000
	beq _Unset

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	ldx lR18
	phx
	ldx lR18+1
	phx

	jsr rsGetEventFlagOffset

	lda [lR18],y
	and wR0
	sta wR0

	plx
	stx lR18+1
	plx
	stx lR18

	ply
	plx
	plp
	plb

	lda wR0
	bne _Set

	_Unset
	clc
	bra _End

	_Set
	sec

	_End
	rtl

rlTestLocationEventFlagSet ; 8C/9BF7

	.al
	.xl
	.autsiz
	.databank ?

	clc
	adc #$0021

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	ldx lR18
	phx
	ldx lR18+1
	phx

	jsr rsGetEventFlagOffset

	lda [lR18],y
	and wR0
	sta wR0

	plx
	stx lR18+1
	plx
	stx lR18

	ply
	plx
	plp
	plb

	lda wR0
	bne _Set

	clc
	bra _End

	_Set
	sec

	_End
	rtl

rlClearPermanentEventFlags ; 8C/9C23

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aPermanentEventFlags)<<8
	sta lR18+1
	lda #<>aPermanentEventFlags
	sta lR18

	lda #size(aPermanentEventFlags)
	sta lR19

	lda #$0000
	jsl rlBlockFillWord
	rtl

rlClearTemporaryEventFlags ; 8C/9C3A

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aTemporaryEventFlags)<<8
	sta lR18+1
	lda #<>aTemporaryEventFlags
	sta lR18

	lda #size(aTemporaryEventFlags)
	sta lR19

	lda #$0000
	jsl rlBlockFillWord
	rtl

rlUnknown8C9C51 ; 8C/9C51

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetTurnEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlUnknown8C9C59 ; 8C/9C59

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineCharacterStructParameter,b
	lda wR1
	sta wEventEngineCharacterTarget,b
	jsr rsGetTalkEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlUnknown8C9C6B ; 8C/9C6B

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetLocationEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlUnknown8C9C73 ; 8C/9C73

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetBeforeActionEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlUnknown8C9C7B ; 8C/9C7B

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetAfterActionEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlUnknown8C9C83 ; 8C/9C83

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetShopEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	rtl

rlEventEngineRunChapterOpeningEvents ; 8C/9C8B

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetOpeningEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	rtl

rlEventEngineRunChapterTurnEvents ; 8C/9C93

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetTurnEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	bcc +

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9CA3 ; 8C/9CA3

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineCharacterStructParameter,b
	lda wR1
	sta wEventEngineCharacterTarget,b

	jsr rsGetTalkEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	bcc +

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9CBD ; 8C/9CBD

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetLocationEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	bcc +

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9CCD ; 8C/9CCD

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetBeforeActionEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	bcc +

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9CDD ; 8C/9CDD

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetAfterActionEventDefinitionArrayPointer
	jsl rlUnknown8C9601
	bcc +

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9CED ; 8C/9CED

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineCharacterStructParameter,b

	lda wR1
	sta wEventEngineCharacterTarget,b

	lda #$0000
	sta lEventEngineLongParameter,b

	jsr rsGetBattleEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	bcc _End

	lda $7EA67F
	cmp #$0006
	beq +

	cmp #$0000
	bne _End

	+
	lda $7EA4DE
	cmp #$0003
	bcs _End

	jsr rsUnknown8C9757

	lda wEventEngineCharacterStructParameter,b
	sta wR0

	jsl rlGetBattleQuoteDialoguePointer

	lda lR18+1
	sta lEventEngineLongParameter+1,b
	lda lR18
	sta lEventEngineLongParameter,b

	lda wEventEngineCharacterStructParameter,b
	jsl rlGetPortraitIndex

	sta $7E4596

	_End
	rtl

rlUnknown8C9D3F ; 8C/9D3F

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineCharacterStructParameter,b

	jsl rlGetDeathQuoteDialoguePointer

	lda wEventEngineCharacterStructParameter,b
	jsl rlGetPortraitIndex

	sta $7E4596
	rtl

rlUnknown8C9D54 ; 8C/9D54

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineCharacterStructParameter,b

	jsl rlGetReleaseQuoteDialoguePointer
	bcs +

	lda #(`eventMapReleaseQuoteHandler)<<8
	sta lR18+1
	lda #<>eventMapReleaseQuoteHandler
	sta lR18
	jsl rlUnknown8C839F

	lda wEventEngineCharacterStructParameter,b
	jsl rlGetPortraitIndex

	sta $7E4596

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8C9D7F ; 8C/9D7F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	jsr rsGetShopEventDefinitionArrayPointer
	jsl rlUnknown8C95D3
	bcc +

	ldy #$0000
	inc y
	lda [lR18],y
	clc
	adc #$0002
	sta wR0

	inc y
	lda [lR18],y
	sta lR18+1

	lda wR0
	sta lR18

	+
	plp
	plb
	rtl

rsGetOpeningEventDefinitionArrayPointer ; 8C/9DA4

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.OpeningEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetTurnEventDefinitionArrayPointer ; 8C/9DA9

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.TurnEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetTalkEventDefinitionArrayPointer ; 8C/9DAE

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.TalkEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetLocationEventDefinitionArrayPointer ; 8C/9DB3

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.LocationEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetBeforeActionEventDefinitionArrayPointer ; 8C/9DB8

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.BeforeActionEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetShopEventDefinitionArrayPointer ; 8C/9DBD

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.ShopEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetBattleEventDefinitionArrayPointer ; 8C/9DC2

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.BattleEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetEndingEventPointer ; 8C/9DC7

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.EndingEvent
	bra rsGetEventPointerTableEntry

rsGetAfterActionEventDefinitionArrayPointer ; 8C/9DCC

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.AfterActionEventDefinitions
	bra rsGetEventPointerTableEntry

rsGetPrepGroupsPointer ; 8C/9DD1

	.al
	.xl
	.autsiz
	.databank ?

	lda #structChapterEventPointers.PrepGroups

rsGetEventPointerTableEntry ; 8C/9DD4

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	pha

	lda wCurrentChapter,b
	sta wR10

	lda #size(structChapterEventPointers)
	sta wR11

	jsl rlUnsignedMultiply16By16

	pla
	clc
	adc wR12
	adc #<>aChapterEventPointers
	tay

	lda $0000,b,y
	sta lR18
	lda $0001,b,y
	sta lR18+1

	plp
	plb
	rts

rlUnknown8C9DFC ; 8C/9DFC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	jsr rsGetPrepGroupsPointer

	lda lR18
	sta lEventEngineLongParameter,b
	lda lR18+1
	sta lEventEngineLongParameter+1,b

	jsl rlLoadPrepGroups

	plp
	plb
	rtl

rlUnknown8C9E14 ; 8C/9E14

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	jsr rsGetEndingEventPointer
	jsl rlUnknown8C839F

	plp
	plb
	rtl

rlUnknown8C9E22 ; 8C/9E22

	.al
	.xl
	.autsiz
	.databank ?

	ldx #$0006

	-
	lda @l aUnknown0017BF,x
	beq +

	jsr rsUnknown8C9EF4

	+
	dec x
	dec x
	bpl -

	rtl

rsUnknown8C9E33 ; 8C/9E33

	.al
	.xl
	.autsiz
	.databank ?

	lda bDecompListFlag,b
	bne _True

	lda wEventEngineStatus,b
	bit #$0020
	bne _True

	ldx #$0000

	-
	lda @l aUnknown0017BF,x
	bit #$1000
	bne _True

	inc x
	inc x
	cpx #$0008
	bcc -

	ldx #$0000

	-
	phx
	phy
	jsl $8A9C82
	ply
	plx
	bcc +

	lda @l aUnknown0017BF,x
	beq _False

	+
	inc x
	inc x
	cpx #$0008
	bcc -

	ldx #$FFFF

	_True
	sec
	rts

	_False
	clc
	rts

rsUnknown8C9E74 ; 8C/9E74

	.al
	.xl
	.autsiz
	.databank ?

	lda bDecompListFlag,b
	bne _False

	lda wEventEngineStatus,b
	bit #$0020
	bne _False

	ldx #$0000

	-
	lda @l aUnknown0017BF,x
	bit #$1000
	bne _False

	inc x
	inc x
	cpx #$0008
	bcc -

	clc
	rts

	_False
	sec
	rts

rsUnknown8C9E98 ; 8C/9E98

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	pha

	ldx #$0006

	-
	lda bDecompListFlag,b
	and #$00FF
	bne _Next

	lda bDMAArrayFlag,b
	and #$00FF
	bne _Next

	lda wBGUpdateFlags
	bne _Next

	lda @l aUnknown0017BF,x
	beq _Next

	jsr rsUnknown8C9F74
	bcs _Next

	phx
	phy
	lda #$00FF
	sta wR0
	jsl $8A9C82

	ply
	plx
	bcc +

	lda @l aUnknown0017BF,x
	cmp #$0100
	bne _Next

	lda #$0000
	sta @l aUnknown0017BF,x
	beq _Next

	+
	lda $7FAA4A,x
	bit #$0008
	bne _Next

	jsr rsUnknown8C9EF4

	_Next
	dec x
	dec x
	bpl -

	pla
	sta wR0
	rts

rsUnknown8C9EF4 ; 8C/9EF4

	.al
	.xl
	.autsiz
	.databank ?

	lda @l aUnknown0017BF,x
	and #$00FF
	sta wR0

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83901C

	lda @l aUnknown0017BF,x
	bit #$0200
	beq +

	lda @l aUnknown0017C7,x
	and #$00FF
	sta wR0

	lda @l aUnknown0017C7,x
	xba
	and #$00FF
	sta wR0

	lda #aSelectedCharacterBuffer
	sta wR2

	lda #$007C
	sta wR4

	phx
	jsl rlUnknown80E5FF
	plx

	+
	lda aSelectedCharacterBuffer.X,b
	and #$00FF
	cmp wMapWidth16,b
	bcs +

	lda aSelectedCharacterBuffer.Y,b
	and #$00FF
	cmp wMapHeight16,b
	bcs +

	lda @l aUnknown0017BF,x
	bit #$0400
	beq ++

	phx
	lda #aSelectedCharacterBuffer
	sta wR1
	jsr rsUnknown8CA04E
	plx

	+
	jsl $8A9013

	+
	phx
	jsl rlUpdateFogTiles

	lda #%0100
	sta wBGUpdateFlags

	plx
	lda #$0000
	sta @l aUnknown0017BF,x
	rts

rsUnknown8C9F74 ; 8C/9F74

	.al
	.xl
	.autsiz
	.databank ?

	lda @l aUnknown0017BF,x
	bit #$1000
	beq _False

	lda wEventEngineStatus,b
	bit #$0020
	bne _True

	jsr rsUnknown8C9F9F

	lda #$0000
	sta wR4
	jsr rsUnknown8C94FA

	lda @l aUnknown0017BF,x
	and #~$1000
	sta @l aUnknown0017BF,x

	_True
	sec
	rts

	_False
	clc
	rts

rsUnknown8C9F9F ; 8C/9F9F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`$7E49EB
	pha
	rep #$20
	plb

	.databank `$7E49EB

	phx
	phy

	lda @l $7E49EB
	and #$00FF
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $83901C

	sep #$20
	lda @l $7E49E9
	sta aBurstWindowCharacterBuffer.X,b
	rep #$20

	sep #$20
	lda @l $7E49EA
	sta aBurstWindowCharacterBuffer.Y,b
	rep #$20

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	ora #TurnStatusActing
	sta aBurstWindowCharacterBuffer.TurnStatus,b

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $839041

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsr rsUnknown8CA02F

	lda @l $7E49E7
	and #$00FF
	sta wR2

	lda @l $7E49E8
	and #$00FF
	sta wR3

	lda @l $7E49EF
	xba
	and #$00FF
	sta wR0

	lda @l $7E49F1
	and #$00FF
	sta wR1

	lda @l $7E49F6
	sta wR5

	lda @l $7E49EB
	sta wR6

	lda @l $7E49F4
	sta lR18+1

	lda @l $7E49F3
	sta lR18

	ply
	plx
	plp
	plb
	rts

rsUnknown8CA02F ; 8C/A02F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wR1
	pha
	rep #$20
	plb

	.databank ?

	ldy #structCharacterDataRAM.TurnStatus
	lda (wR1),y
	ora #TurnStatusActing
	sta (wR1),y

	jsl $839041
	jsl $8885D1

	plp
	plb
	rts

rsUnknown8CA04E ; 8C/A04E

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wR1
	pha
	rep #$20
	plb

	.databank ?

	phx
	phy

	ldy #structCharacterDataRAM.TurnStatus
	lda (wR1),y
	and #~TurnStatusGrayed
	and #~TurnStatusActing
	sta (wR1),y

	lda wR1
	pha

	sep #$20
	lda #$00
	ldy #structCharacterDataRAM.AI4
	sta (wR1),y
	ldy #structCharacterDataRAM.Unknown3E
	sta (wR1),y
	rep #$20
	jsl $839041

	pla
	sta wR1

	lda #$0000
	sta wR4

	jsl rlUnknown80E626
	jsl $839B37
	jsl $8885D1

	ply
	plx
	plp
	plb
	rts

rlASMCUnknown8CA097 ; 8C/A097

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	pha

	ldx #size(aUnknown0017BF) - 2

	-
	lda @l aUnknown0017BF,x
	bne +

	lda $7FAA1A,x
	beq +

	jsl $8A9013

	+
	dec x
	dec x
	bpl -

	pla
	sta wR0
	clc
	rtl

rlUnknown8CA0B6 ; 8C/A0B6

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000E25,b
	cmp #$0000
	beq rlASMCUnknown8CA0C0
	clc
	rtl

rlASMCUnknown8CA0C0 ; 8C/A0C0

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $8885D1
	plp
	clc
	rtl

rlUnknown8CA0C8 ; 8C/A0C8

	.al
	.xl
	.autsiz

	php
	phx
	phy

	lda $7E49F5
	and #$00FF
	cmp #$007E
	bne _End

	lda $7E49F4
	sta lR18+1

	lda $7E49F3
	sta lR18

	lda aSelectedCharacterBuffer.X,b
	and #$00FF
	sta wR0

	sta wR2
	lda aSelectedCharacterBuffer.Y,b
	and #$00FF
	sta wR1
	sta wR3

	lda aSelectedCharacterBuffer.Class,b
	and #$00FF
	sta wR4

	jsl $8DB420

	lda $7E49F4
	sta lR18+1
	lda $7E49F3
	sta lR18

	jsl $8A9CC3

	sep #$20
	lda aSelectedCharacterBuffer.X,b
	clc
	adc wR0
	sta aSelectedCharacterBuffer.X,b

	lda aSelectedCharacterBuffer.Y,b
	clc
	adc wR1
	sta aSelectedCharacterBuffer.Y,b
	rep #$20

	_End
	ply
	plx
	plp
	rtl

rlUnknown8CA12D ; 8C/A12D

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy
	ldx lR18
	phx
	ldx lR18+1
	phx
	ldx wR0
	phx

	ldx #$0006

	-
	lda @l aUnknown0017BF,x
	beq ++

	phx
	phy
	lda #$00FF
	sta wR0
	jsl $8A9C82
	ply
	plx
	bcc +

	lda @l aUnknown0017BF,x
	cmp #$0100
	bne ++

	lda #$0000
	sta @l aUnknown0017BF,x
	beq ++

	+
	jsr rsUnknown8C9EF4

	+
	dec x
	dec x
	bpl -

	plx
	stx wR0
	plx
	stx lR18+1
	plx
	stx lR18

	ply
	plx
	plp
	rtl

rlASMCChangeAllegianceToPlayer ; 8C/A177

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlASMCCountAllUnitUncapturedAlive2
	lda wEventEngineParameter1,b
	beq +

	lda wEventEngineCharacterTarget,b
	jsl $83A2BC

	+
	clc
	rtl

rlASMCChangeAllegianceToEnemy ; 8C/A189

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlASMCCountAllUnitUncapturedAlive
	lda wEventEngineParameter1,b
	beq +

	lda wEventEngineCharacterTarget,b
	jsl $83A35A

	+
	clc
	rtl

rlASMCChangeAllegianceToNPC ; 8C/A19B

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlASMCCountAllUnitUncapturedAlive
	lda wEventEngineParameter1,b
	beq +

	lda wEventEngineCharacterTarget,b
	jsl $83A349

	+
	clc
	rtl

rlASMCChangeAllegiance ; 8C/A1AD

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	sta wR0

	lda wEventEngineCharacterStructParameter,b
	sta wR1

	lda wEventEngineParameter2,b
	sta wR2

	lda wEventEngineParameter3,b
	sta wR3

	jsl $83AF77
	clc
	rtl

rlASMCChangeAllegianceToPlayerIfCaptured ; 8C/A1C7

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne _False

	lda @l aBurstWindowCharacterBuffer.TurnStatus
	bit #TurnStatusRescued
	beq _False

	lda wEventEngineCharacterTarget,b
	jsl $83A2BC

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra _End

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	_End
	clc
	rtl

rlASMCMount ; 8C/A1FA

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	jsl $83AED5
	clc
	rtl

rlASMCDismount ; 8C/A203

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	jsl $83AEFA
	clc
	rtl

rlASMCIsUnitRescued ; 8C/A20C

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne _False

	lda @l aBurstWindowCharacterBuffer.TurnStatus
	bit #TurnStatusRescued
	beq _False

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra _End

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	_End
	clc
	rtl

rlASMCIsUnitCaptured ; 8C/A238

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne _False

	lda @l aBurstWindowCharacterBuffer.TurnStatus
	bit #TurnStatusRescued
	beq _False

	lda @l aBurstWindowCharacterBuffer.Rescue
	and #$00FF
	bit #Enemy
	beq _False

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra _End

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	_End
	clc
	rtl

rlASMCClearRescue ; 8C/A270

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	ldy wR1
	phy
	jsl $83976E
	ply
	sty wR1
	and #$FFFF
	beq +
	clc
	rtl

	+
	phb
	php
	sep #$20
	lda #`aItemSkillCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aItemSkillCharacterBuffer

	lda wR1
	tay
	lda structCharacterDataRAM.Rescue,b,y
	and #$00FF
	beq +

	sta wR0
	phy
	phy

	lda #aItemSkillCharacterBuffer
	sta wR1

	jsl $83901C

	lda aItemSkillCharacterBuffer.TurnStatus,b
	and #~(TurnStatusRescued | TurnStatusRescuing)
	sta aItemSkillCharacterBuffer.TurnStatus,b

	ply
	lda structCharacterDataRAM.TurnStatus,b,y
	and #~(TurnStatusRescued | TurnStatusRescuing)
	sta structCharacterDataRAM.TurnStatus,b,y

	sep #$20
	lda #$00
	sta structCharacterDataRAM.Rescue,b,y
	sta aItemSkillCharacterBuffer.Rescue,b
	rep #$30

	lda #aItemSkillCharacterBuffer
	sta wR1
	jsl $839041

	pla
	sta wR1
	jsl $839041

	+
	plp
	plb
	clc
	rtl

rlASMCClearActiveUnitRescue ; 8C/A2E0

	.al
	.xl
	.autsiz
	.databank ?

	lda @l aSelectedCharacterBuffer.Rescue
	and #$00FF
	beq +

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83ACA8

	+
	clc
	rtl

rlASMCSetFlagIfRetreatingUnitByTable ; 8C/A2F4

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aSelectedCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aSelectedCharacterBuffer

	lda lEventEngineLongParameter+1,b
	sta lR18+1
	lda lEventEngineLongParameter,b
	sta lR18

	lda aSelectedCharacterBuffer.Character,b
	jsr rsCheckRetreatingUnitTableAndSetFlag
	bcs +

	lda aSelectedCharacterBuffer.Rescue,b
	and #$00FF
	beq +

	sta wR0
	lda #aItemSkillCharacterBuffer
	sta wR1

	jsl $83901C

	lda lEventEngineLongParameter+1,b
	sta lR18+1
	lda lEventEngineLongParameter,b
	sta lR18

	lda aItemSkillCharacterBuffer.Character,b
	jsr rsCheckRetreatingUnitTableAndSetFlag

	+
	plp
	plb
	clc
	rtl

rsCheckRetreatingUnitTableAndSetFlag ; 8C/A337

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlFindByteCharTableEntry
	bcc +

	jsl rlSetEventFlag
	sec

	+
	rts

rlASMCRemoveUnit ; 8C/A343

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83A42D
	jsl rlUpdateVisibilityMap
	jsl rlUpdateUnitMaps

	+
	plp
	clc
	rtl

rlASMCPromoteUnit ; 8C/A36B

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineParameter1,b
	jsl $8A8745
	plp
	clc
	rtl

rlASMCChangeUnitClass ; 8C/A376

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineParameter1,b
	jsl $87C778
	jsl $839A94
	plp
	clc
	rtl

rlASMCSetUnitPosition ; 8C/A385

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wUnknown001730,b
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0
	jsl $83976E
	ora #$0000
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR0

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $83905C

	sep #$20
	lda wEventEngineXCoordinate,b
	sta aTargetingCharacterBuffer.X,b
	rep #$20

	sep #$20
	lda wEventEngineYCoordinate,b
	sta aTargetingCharacterBuffer.Y,b
	rep #$20

	jsl rlPlaceLoadedUnit

	+
	plp
	clc
	rtl

rlASMCUpdateRetreatingUnitTurnStatus ; 8C/A3C7

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`$7E4FCF
	pha
	rep #$20
	plb

	.databank `$7E4FCF

	lda @l aSelectedCharacterBuffer.TurnStatus
	and #~TurnStatusCaptured
	ora #TurnStatusUnknown1 | TurnStatusActing
	ora #TurnStatusMovementStar
	sta @l aSelectedCharacterBuffer.TurnStatus

	lda #aSelectedCharacterBuffer
	sta wR1

	sep #$20
	lda #$10
	sta @l $7E4FCF
	rep #$20

	sep #$20
	lda aSelectedCharacterBuffer.DeploymentNumber,b
	sta @l $7E4FCE
	rep #$20
	plp
	plb
	clc
	rtl

rlEventDefinitionCheckRetreatCoordinates ; 8C/A400

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`$7E5142
	pha
	rep #$20
	plb

	.databank `$7E5142

	lda wCursorXCoord,b
	sta wR0

	lda wCursorYCoord,b
	sta wR1

	jsl rlGetMapTileIndexByCoords
	jsl rlFindObjectiveMarker
	bcc +

	plp
	plb
	sec
	rtl

	+
	plp
	plb
	clc
	rtl

rlASMCCopyRetreatingUnitDataToEventBuffer ; 8C/A424

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aSelectedCharacterBuffer)<<8
	sta lR18+1
	lda #<>aSelectedCharacterBuffer
	sta lR18
	lda #(`aEventCharacterBuffer)<<8
	sta lR19+1
	lda #<>aEventCharacterBuffer
	sta lR19
	lda #size(structExpandedCharacterDataRAM)
	sta wR20
	jsl rlBlockCopy
	clc
	rtl

rlASMCCopyRetreatingUnitDataFromEventBuffer ; 8C/A445

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aEventCharacterBuffer)<<8
	sta lR18+1
	lda #<>aEventCharacterBuffer
	sta lR18
	lda #(`aSelectedCharacterBuffer)<<8
	sta lR19+1
	lda #<>aSelectedCharacterBuffer
	sta lR19
	lda #size(structExpandedCharacterDataRAM)
	sta wR20
	jsl rlBlockCopy
	clc
	rtl

rlASMCSetUnitTurnStatus ; 8C/A464

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCSetUnitTurnStatusEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCSetUnitTurnStatusEffect
	sta lUnknown7EA4EC+1
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCSetUnitTurnStatusEffect ; 8C/A477

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.TurnStatus

	lda (wR1),y
	ora wEventEngineParameter1,b
	sta (wR1),y

	jsl $839041
	rtl

rlASMCUnsetUnitTurnStatus ; 8C/A486

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCUnsetUnitTurnStatusEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCUnsetUnitTurnStatusEffect
	sta lUnknown7EA4EC+1
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCUnsetUnitTurnStatusEffect ; 8C/A499

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.TurnStatus

	lda wEventEngineParameter1,b
	eor #$FFFF
	sta wEventEngineParameter1,b

	lda (wR1),y
	and wEventEngineParameter1,b
	sta (wR1),y

	jsl $839041
	rtl

rlASMCCheckUnitTurnStatusSet ; 8C/A4B1

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCCheckUnitTurnStatusSetEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCCheckUnitTurnStatusSetEffect
	sta lUnknown7EA4EC+1
	lda #$0000
	sta wEventEngineTruthFlag,b
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCCheckUnitTurnStatusSetEffect ; 8C/A4CA

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.TurnStatus
	lda (wR1),y
	and wEventEngineParameter1,b
	beq _Unset

	lda #$0001
	bra _End

	_Unset
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	rtl

rlASMCCheckUnitTurnStatusUnset ; 8C/A4E0

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCCheckUnitTurnStatusUnsetEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCCheckUnitTurnStatusUnsetEffect
	sta lUnknown7EA4EC+1
	lda #$0000
	sta wEventEngineTruthFlag,b
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCCheckUnitTurnStatusUnsetEffect ; 8C/A4F9

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.TurnStatus
	lda (wR1),y
	and wEventEngineParameter1,b
	bne _Set

	lda #$0001
	bra _End

	_Set
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	rtl

rlASMCCheckUnitStatusSet ; 8C/A50F

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCCheckUnitStatusSetEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCCheckUnitStatusSetEffect
	sta lUnknown7EA4EC+1
	lda #$0000
	sta wEventEngineTruthFlag,b
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCCheckUnitStatusSetEffect ; 8C/A528

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.Status
	lda (wR1),y
	and #$00FF
	cmp wEventEngineParameter1,b
	bne _Unset

	lda #$0001
	bra _End

	_Unset
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	rtl

rlASMCCheckUnitAvailableForDialogue ; 8C/A541

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCCheckUnitAvailableForDialogueEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCCheckUnitAvailableForDialogueEffect
	sta lUnknown7EA4EC+1
	lda #$0000
	sta wEventEngineTruthFlag,b
	jsl rlFindUnitAndRunTurnStatusEffect
	rtl

rlASMCCheckUnitAvailableForDialogueEffect ; 8C/A55A

	.al
	.xl
	.autsiz
	.databank ?

	ldy #structCharacterDataRAM.TurnStatus
	lda (wR1),y
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusActing | TurnStatusInvisible | TurnStatusCaptured
	bne _False

	ldy #structCharacterDataRAM.Status
	lda (wR1),y
	and #$00FF
	cmp #StatusSleep
	beq _False

	cmp #StatusBerserk
	beq _False

	cmp #StatusSilence
	beq _False

	cmp #StatusPetrify
	beq _False

	lda #$0001
	bra _End

	_False
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	rtl

rlFindUnitAndRunTurnStatusEffect ; 8C/A58C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aBurstWindowCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aBurstWindowCharacterBuffer

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E

	and #$FFFF
	bne _Return

	lda #aBurstWindowCharacterBuffer
	sta wR1

	ldy #structCharacterDataRAM.TurnStatus

	lda lUnknown7EA4EC
	sta lR18
	lda lUnknown7EA4EC+1
	sta lR18+1

	phk
	pea <>_Return - 1
	jmp [lR18]

	_Return
	plp
	plb
	clc
	rtl

rlASMCAllUnitsSetTurnStatus ; 8C/A5C8

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCAllUnitsSetTurnStatusEffect
	sta lR25
	lda #>`rlASMCAllUnitsSetTurnStatusEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	rtl

rlASMCAllUnitsSetTurnStatusEffect ; 8C/A5D6

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	ora wEventEngineParameter1,b
	sta aTargetingCharacterBuffer.TurnStatus,b

	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041
	rtl

rlASMCAllUnitsUnsetTurnStatus ; 8C/A5E9

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineParameter1,b
	eor #$FFFF
	sta wEventEngineParameter1,b

	lda #<>rlASMCAllUnitsUnsetTurnStatusEffect
	sta lR25
	lda #>`rlASMCAllUnitsUnsetTurnStatusEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	rtl

rlASMCAllUnitsUnsetTurnStatusEffect ; 8C/A600

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	and wEventEngineParameter1,b
	sta aTargetingCharacterBuffer.TurnStatus,b

	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041
	rtl

rlASMCActiveUnitSetTurnStatus ; 8C/A613

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCActiveUnitSetTurnStatusEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCActiveUnitSetTurnStatusEffect
	sta lUnknown7EA4EC+1
	jsl rlGetActiveUnitAndRunTurnStatusEffect
	rtl

rlASMCActiveUnitSetTurnStatusEffect ; 8C/A626

	.al
	.xl
	.autsiz
	.databank ?

	lda (wR1),y
	ora wEventEngineParameter1,b
	sta (wR1),y
	rtl

rlASMCActiveUnitUnsetTurnStatus ; 8C/A62E

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCActiveUnitUnsetTurnStatusEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCActiveUnitUnsetTurnStatusEffect
	sta lUnknown7EA4EC+1
	jsl rlGetActiveUnitAndRunTurnStatusEffect
	rtl

rlASMCActiveUnitUnsetTurnStatusEffect ; 8C/A641

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineParameter1,b
	eor #$FFFF
	sta wEventEngineParameter1,b

	lda (wR1),y
	and wEventEngineParameter1,b
	sta (wR1),y
	rtl


rlASMCActiveUnitTestTurnStatus ; 8C/A652

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlASMCActiveUnitTestTurnStatusEffect
	sta lUnknown7EA4EC
	lda #>`rlASMCActiveUnitTestTurnStatusEffect
	sta lUnknown7EA4EC+1
	jsl rlGetActiveUnitAndRunTurnStatusEffect
	rtl

rlASMCActiveUnitTestTurnStatusEffect ; 8C/A665

	.al
	.xl
	.autsiz
	.databank ?

	lda (wR1),y
	bit wEventEngineParameter1,b
	beq _Unset

	lda #$0001
	bra _End

	_Unset
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	rtl

rlGetActiveUnitAndRunTurnStatusEffect ; 8C/A678

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aSelectedCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aSelectedCharacterBuffer

	lda #aSelectedCharacterBuffer
	sta wR1

	ldy #structCharacterDataRAM.TurnStatus

	lda lUnknown7EA4EC
	sta lR18
	lda lUnknown7EA4EC+1
	sta lR18+1

	phk
	pea <>_Return - 1
	jmp [lR18]

	_Return
	plp
	plb
	clc
	rtl

rlCheckActiveUnitCarrying ; 8C/A6A1

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda @l aSelectedCharacterBuffer.Rescue
	and #$00FF
	sta wR0
	beq _False

	lda #aItemSkillCharacterBuffer
	sta wR1
	jsl $83901C

	lda @l aItemSkillCharacterBuffer.Character
	cmp wEventEngineParameter1,b
	bne _False

	lda #$0001
	bra _End

	_False
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	plp
	plb
	rtl

rlSetupMoveTargetByCoordinates ; 8C/A6D0

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aPlayerVisibleUnitMap
	pha
	rep #$20
	plb

	.databank `aPlayerVisibleUnitMap

	jsl rlCheckTileOccupied
	bcc _False

	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83901C

	plp
	plb
	sec
	rtl

	_False
	plp
	plb
	clc
	rtl

rlASMCCheckPartyAndConvoyForItem ; 8C/A6F3

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wEventEngineParameter3
	pha
	rep #$20
	plb

	.databank `wEventEngineParameter3

	lda #$0000
	sta wEventEngineParameter3,b

	lda #<>rlASMCCheckPartyAndConvoyForItemEffect
	sta lR25
	lda #>`rlASMCCheckPartyAndConvoyForItemEffect
	sta lR25+1
	jsr rsLoopThroughPlayerUnitsAndRunRoutine
	ldx #$0000

	-
	lda aConvoy,x
	beq ++

	and #$00FF
	cmp wEventEngineParameter1,b
	bne +

	inc wEventEngineParameter3,b

	+
	inc x
	inc x
	cpx #$0100
	bcc -

	+
	lda wEventEngineParameter3,b
	sta wEventEngineParameter1,b

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlASMCCheckPartyAndConvoyForItemEffect ; 8C/A740

	.al
	.xl
	.autsiz
	.databank ?

	lda #aTargetingCharacterBuffer
	sta wR1

	lda wEventEngineParameter1,b
	jsl rlEventFindItemInInventory
	and #$FFFF
	beq +

	inc wEventEngineParameter3,b

	+
	rtl

rlASMCCheckUnitForItem ; 8C/A755

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne _False

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineParameter1,b
	jsl rlEventFindItemInInventory
	and #$FFFF
	beq _False

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra _End

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	_End
	clc
	rtl

rlASMCGiveUnitItemSilent ; 8C/A789

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl rlSetGivenItemWithMaxDurability

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $839041

	+
	clc
	rtl

rlASMCCheckUnitExists ; 8C/A7B0

	.al
	.xl
	.autsiz
	.databank ?

	lda #aSelectedCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0
	jsl $83976E
	and #$FFFF
	beq _True

	lda #$0000
	bra _False

	_True
	lda #$0001

	_False
	sta wEventEngineTruthFlag,b
	clc
	rtl

rlASMCSaveActiveUnitDataChapterEnd ; 8C/A7D0

	.al
	.xl
	.autsiz
	.databank ?

	jsl $8593EB

rlASMCSaveActiveUnitData ; 8C/A7D4


	.al
	.xl
	.autsiz
	.databank ?

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $839041

	clc
	rtl

rlASMCRemoveItemFromUnit ; 8C/A7DF

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineParameter1,b
	jsl rlEventRemoveItemFromInventory

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $839041

	+
	clc
	rtl

rlASMCGiveUnitItemsToConvoy ; 8C/A809

	.al
	.xl
	.autsiz

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	bne +

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl rlEventMoveItemsToConvoy

	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $839041

	+
	clc
	rtl

rlEventFindItemInInventory ; 8C/A830

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wEventEngineParameter1
	pha
	rep #$20
	plb

	.databank `wEventEngineParameter1

	phx

	ldy wR1
	lda structCharacterDataRAM.TurnStatus,b,y
	bit #TurnStatusDead | TurnStatusCaptured
	bne +

	ldx #$0000

	-
	lda structCharacterDataRAM.Items,b,y
	and #$00FF
	cmp wEventEngineParameter1,b
	beq ++

	inc y
	inc y
	inc x
	inc x
	cpx #size(structCharacterDataRAM.Items)
	bcc -

	+
	lda #$0000

	+
	plx
	plp
	plb
	clc
	rtl

rlEventRemoveItemFromInventory ; 8C/A864

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wEventEngineParameter1
	pha
	rep #$20
	plb

	.databank `wEventEngineParameter1

	phx

	ldy wR1
	ldx #$0000

	-
	lda structCharacterDataRAM.Items,b,y
	and #$00FF
	cmp wEventEngineParameter1,b
	beq _Found

	inc y
	inc y
	inc x
	inc x
	cpx #size(structCharacterDataRAM.Items)
	bcc -
	bra _End

	_Found
	lda #$0000
	sta structCharacterDataRAM.Items,b,y
	bra +

	-
	lda structCharacterDataRAM.Items,b,y
	sta structCharacterDataRAM.Items-2,b,y

	+
	inc y
	inc y
	inc x
	inc x
	cpx #size(structCharacterDataRAM.Items)
	bcc -

	lda #$0000
	sta structCharacterDataRAM.Items-2,b,y

	_End
	plx
	plp
	plb
	clc
	rtl

rlEventMoveItemsToConvoy ; 8C/A8AC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`wR1
	pha
	rep #$20
	plb

	.databank `wR1

	phx

	ldy wR1
	ldx #$0000

	-
	lda structCharacterDataRAM.Items,b,y
	beq +

	phx
	phy
	jsl $85CC34
	ply
	plx

	lda #$0000
	sta structCharacterDataRAM.Items,b,y

	+
	inc y
	inc y
	inc x
	inc x
	cpx #size(structCharacterDataRAM.Items)
	bcc -

	plx
	plp
	plb
	clc
	rtl

rlASMCSetPopupGivenItemWithMaxDurability ; 8C/A8DD

	.al
	.xl
	.autsiz
	.databank ?

	lda #aSelectedCharacterBuffer
	sta wR1

rlSetGivenItemWithMaxDurability ; 8C/A8E2

	.al
	.xl
	.autsiz
	.databank ?

	lda #$FE00
	sta wR0
	bra rlEventSetPopupGivenItemMain

rlASMCSetPopupGivenItemWithExistingDurability ; 8C/A8E9

	.al
	.xl
	.autsiz
	.databank ?

	lda #aSelectedCharacterBuffer
	sta wR1
	lda #$0000
	sta wR0

rlEventSetPopupGivenItemMain ; 8C/A8F3

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aPlayerUnits
	pha
	rep #$20
	plb

	.databank `aPlayerUnits

	lda wUnknown001730,b
	bne _End

	lda wR1
	pha

	lda wEventEngineParameter1,b
	sta wProcInput0,b

	ora wR0
	sta wEventEngineParameter1,b

	jsl rlCopyItemDataToBuffer

	pla
	sta wR1

	lda wR1
	pha

	jsl $83A443

	pla
	sta wR1
	bcs +

	jsl $839041

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra _End

	+
	lda #$0000
	sta wEventEngineTruthFlag,b

	_End
	plp
	plb
	clc
	rtl

rlASMCSetRewardGivenItem ; 8C/A939

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda wEventEngineParameter1,b
	sta wProcInput0,b
	ora #$FE00

	jsl rlCopyItemDataToBuffer
	jsl $83AF1F
	jsl $85CC34

	plp
	plb
	clc
	rtl

rlASMCSetupGiveToConvoyIfInventoryFull ; 8C/A956

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001730,b
	bne +

	lda wEventEngineTruthFlag,b
	bne +

	lda wEventEngineParameter1,b

	jsl rlCopyItemDataToBuffer
	jsl $86E41A

	+
	clc
	rtl

rlASMCWaitWhileGiveToConvoyIfInventoryFull ; 8C/A96D

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`$86E475)<<8
	sta lR43+1
	lda #<>$86E475
	sta lR43
	jsl rlProcEngineFindProc
	plx
	rtl

rlASMCSetupGiveItemPopup ; 8C/A97E

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001730,b
	bne +

	lda wCursorXCoord,b
	sta wR0

	lda wCursorYCoord,b
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	lda aVisibilityMap,x
	and #$00FF
	beq +

	lda #$0011
	jsl rlUnknown808C87

	phx
	lda #(`$84E5A5)<<8
	sta lR43+1
	lda #<>$84E5A5
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx

	+
	clc
	rtl

rlASMCWaitWhileGiveItemPopup ; 8C/A9B4

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`$84E5A5)<<8
	sta lR43+1
	lda #<>$84E5A5
	sta lR43
	jsl rlProcEngineFindProc
	plx
	rtl

rlEventCheckIfWeaponEquippedByUnit ; 8C/A9C5

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1

	lda wEventEngineCharacterTarget,b
	sta wR0

	jsl $83976E
	and #$FFFF
	beq +

	lda #$0000
	sta wEventEngineTruthFlag,b
	clc
	rtl

	+
	lda #aBurstWindowCharacterBuffer
	sta wR1

rlEventCheckIfWeaponEquippedByBuffer ; 8C/A9E5

	.al
	.xl
	.autsiz
	.databank ?

	jsl $839705

	lda aItemDataBuffer.DisplayedWeapon,b
	and #$00FF
	beq +

	lda #$0001
	bra _End

	+
	lda #$0000

	_End
	sta wEventEngineTruthFlag,b
	clc
	rtl

rlEventDefinitionCheckMareetaShanamEquippedWeapons ; 8C/A9FE

	.al
	.xl
	.autsiz
	.databank ?

	lda aSelectedCharacterBuffer.Character,b
	cmp #Mareeta
	bne _False

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl rlEventCheckIfWeaponEquippedByBuffer

	lda wEventEngineTruthFlag,b
	beq _False

	lda #Shanam
	sta wEventEngineCharacterTarget,b
	jsl rlEventCheckIfWeaponEquippedByUnit

	lda wEventEngineTruthFlag,b
	beq _False

	sec
	rtl

	_False
	clc
	rtl

rlASMCAddGoldShortSilent ; 8C/AA27

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta lR18+1
	lda wEventEngineParameter1,b
	sta lR18
	jsl $83A52E
	clc
	rtl

rlASMCSubtractGoldShortSilent ; 8C/AA37

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta lR18+1
	lda wEventEngineParameter1,b
	sta lR18
	jsl $83A568
	clc
	rtl

rlASMCComparePlayerGoldGTE ; 8C/AA47

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta lR18+1
	lda wEventEngineParameter1,b
	sta lR18
	jsl $83A58A
	bcs _False

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra +

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	+
	clc
	rtl

rlSetActiveUnitTileToPlains ; 8C/AA67

	.al
	.xl
	.autsiz
	.databank ?

	lda aSelectedCharacterBuffer.X,b
	and #$00FF
	sta wR0

	lda aSelectedCharacterBuffer.Y,b
	and #$00FF
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	lda #TerrainPlains
	jsl $848BE6

	clc
	rtl

rlASMCStoreToUnitMapByCoords ; 8C/AA85

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineXCoordinate,b
	sta wR0

	lda wEventEngineYCoordinate,b
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	sep #$20
	lda wEventEngineParameter1,b
	sta aPlayerVisibleUnitMap,x
	sta aUnitMap,x

	plp
	clc
	rtl

rlUnknownMapChange8CAAA5 ; 8C/AAA5

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineXCoordinate,b
	and #$00FF
	sta wR0

	lda wEventEngineYCoordinate,b
	and #$00FF
	sta wR1

	jsl rlGetMapTileIndexByCoords

	asl a
	tax
	lda aMapMetatileMap,x
	pha
	jsl rlASMCSingleTileChangeByCoords

	pla
	lsr a
	lsr a
	lsr a
	sta @l wEventEngineUnknownTileChangeIndex

	clc
	rtl

rlUnknownMapChange8CAACE ; 8C/AACE

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineUnknownTileChangeIndex,b
	sta wEventEngineParameter1,b

	jsl rlASMCSingleTileChangeByCoords

	clc
	rtl

rlASMCSingleTileChangeByCoords ; 8C/AADA

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineXCoordinate,b
	and #$00FF
	sta wR0

	lda wEventEngineYCoordinate,b
	and #$00FF
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	lda wEventEngineParameter1,b
	asl a
	asl a
	asl a
	jsr rsGetSingleTileChangeNewTerrain
	jsr rsSetSingleTileChangeMetatileIndex
	lda wUnknown001730,b
	bne +

	jsl $83B476
	jsl $848B79
	jsl rlUpdateFogTiles

	lda #%0100
	sta wBGUpdateFlags

	+
	plp
	clc
	rtl

rlASMCSetTerrainTypeToDoorByCoords ; 8C/AB17

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineXCoordinate,b
	and #$00FF
	sta wR0

	lda wEventEngineYCoordinate,b
	and #$00FF
	sta wR1

	jsl rlGetMapTileIndexByCoords

	tax
	sep #$20
	lda #TerrainDoor
	sta aTerrainMap,x
	rep #$20
	plp
	clc
	rtl

rsGetSingleTileChangeNewTerrain ; 8C/AB3A

	.al
	.xl
	.autsiz
	.databank ?

	pha
	phx
	lsr a
	lsr a
	lsr a
	tax
	lda $7F2010,x

	plx
	phx
	sep #$20
	sta aTerrainMap,x

	rep #$20
	plx
	pla
	rts

rsSetSingleTileChangeMetatileIndex ; 8C/AB51

	.al
	.xl
	.autsiz
	.databank ?

	pha
	txa
	asl a
	tax
	pla
	sta aMapMetatileMap,x
	rts

rlASMCChapterEnd ; 8C/AB5B

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $83FB11
	jsl rlChapterEndResetCameraPosition
	jsl rlGetWorldMapEventPointer
	lda lR18
	beq +

	lda #<>rlChapterEndPrepareNextChapterWithWMEvents
	sta lUnknown7EA4EC
	lda #>`rlChapterEndPrepareNextChapterWithWMEvents
	sta lUnknown7EA4EC+1
	bra ++

	+
	lda #<>rlChapterEndPrepareNextChapter
	sta lUnknown7EA4EC
	lda #>`rlChapterEndPrepareNextChapter
	sta lUnknown7EA4EC+1

	+
	jsl rlUnknown809FE5
	jsl rlUnknown80C16D

	lda #$FFFF
	sta wUnknown001791,b
	plp
	clc
	rtl

rlChapterEndPrepareNextChapterWithWMEvents ; 8C/AB9B

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #<>rsUnknown80BF58
	sta wProcInput0,b
	phx

	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc

	plx
	lda #$FFFF
	sta wUnknown001791,b

	plp
	clc
	rtl

rlChapterEndPrepareNextChapter ; 8C/ABBB

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $888356

	lda #$FFFF
	sta wUnknown001791,b

	plp
	clc
	rtl

rlASMCFinalChapterEnd ; 8C/ABC9

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $83FB11
	jsl rlUnknown80C4AD

	lda #$FFFF
	sta wUnknown001791,b

	plp
	clc
	rtl

rlASMCSaveChapterAndTurncount ; 8C/ABDB

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $83FC8E
	plp
	clc
	rtl

rlChapterEndResetCameraPosition ; 8C/ABE3

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #$0001
	sta wR0

	lda #$0001
	sta wR1

	jsl $83C181

	lda #$0000
	sta wMapScrollWidthPixels,b

	lda #$0000
	sta wMapScrollHeightPixels,b

	plp
	rtl

rlUnknownChapterEnd8CAC00 ; 8C/AC00

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl rlChapterEndResetCameraPosition
	jsl rlUnknown809FE5
	jsl $83FB11
	jsl rlGetWorldMapEventPointer
	lda lR18
	beq +

	lda #<>rsUnknown80BF58
	sta wProcInput0,b
	phx

	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	bra ++

	+
	jsl $888356

	+
	lda #$FFFF
	sta wUnknown001791,b

	plp
	clc
	rtl

rlUnknown8CAC3A ; 8C/AC3A

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl rlUnknown8CA0B6

	lda wUnknown001730,b
	bne _False

	jsr rsUnknown8C81AD
	jsl rlEventEngineClearActiveProcs
	jsl rlUnknown809C9B
	jsl rlUnknown8CBC71

	lda bBuf_INIDISP
	and #INIDISP.ForcedBlank
	bne +

	lda wEventEngineStatus,b
	bit #$4000
	beq _False

	lda bBuf_INIDISP
	and #$00FF
	bne _True

	+
	lda #$0000
	sta @l wUnknown000E6D

	lda #$0000
	sta wMapScrollWidthPixels,b

	lda #$0000
	sta wMapScrollHeightPixels,b

	lda #<>rsUnknown809DBA
	sta wProcInput0,b
	phx

	lda #(`procUnknown82A272)<<8
	sta lR43+1
	lda #<>procUnknown82A272
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	_False
	plp
	clc
	rtl

	_True
	plp
	sec
	rtl

rlASMCEndWMEvents ; 8C/AC98

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #$00E0
	jsl rlUnknown808C7D

	lda #$2000
	tsb wEventEngineStatus,b

	jsl rlEventEngineCancelFading
	jsl $95800B
	jsl rlUnknown809FE5
	jsl rlChapterEndResetCameraPosition
	jsl rlChapterEndPrepareNextChapter

	lda #$FFFF
	sta wUnknown001791,b

	lda #$0000
	sta @l wUnknown000E6D

	lda #$FFFF
	sta wUnknown001791,b

	plp
	clc
	rtl

	plp
	sec
	rtl

rlASMCTileChangeByID ; 8C/ACD3

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda bDecompListFlag,b
	bne _True

	lda bDMAArrayFlag,b
	bne _True

	lda wEventEngineParameter1,b
	jsl $8492D5
	jsl $83B476
	jsl $848B79

	lda bBuf_INIDISP
	and #INIDISP.ForcedBlank
	bne _False

	jsl rlUpdateFogTiles

	lda #%0100
	sta wBGUpdateFlags
	jsl rlUpdateUnitMaps

	_False
	plp
	clc
	rtl

	_True
	plp
	sec
	rtl

rlASMCDecompressChapterMapChanges ; 8C/AD09

	.al
	.xl
	.autsiz
	.databank ?

	php
	jsl $849260
	plp
	clc
	rtl

rlCheckTileOccupied ; 8C/AD11

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsl rlGetMapTileIndexByCoords
	tax

	lda aPlayerVisibleUnitMap,x
	ora aUnitMap,x
	and #$00FF
	bne _True

	plx
	clc
	rtl

	_True
	plx
	sec
	rtl

rlASMCWriteUnitAtTileToBuffer ; 8C/AD2A

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wEventEngineXCoordinate,b
	sta wR0

	lda wEventEngineYCoordinate,b
	sta wR1

	jsl rlCheckTileOccupied
	bcc _False

	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83901C

	lda #$0001
	sta wEventEngineTruthFlag,b
	bra +

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b

	+
	plp
	clc
	rtl

rlASMCCheckIfUnitAtCoords ; 8C/AD57

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlASMCWriteUnitAtTileToBuffer
	lda wEventEngineTruthFlag,b
	beq +

	lda #$0000
	sta wEventEngineTruthFlag,b

	lda aBurstWindowCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #$0001
	sta wEventEngineTruthFlag,b

	+
	clc
	rtl

rlEventDefinitionCheckAlphan ; 8C/AD76

	.al
	.xl
	.autsiz
	.databank ?

	lda #Alphan
	sta wEventEngineCharacterTarget,b

	lda #15
	sta wEventEngineXCoordinate,b

	lda #15
	sta wEventEngineYCoordinate,b

	jsl rlASMCCheckIfUnitAtCoords

	lda wEventEngineTruthFlag,b
	beq _False
	sec
	bra +

	_False
	clc

	+
	rtl

rlCheckIfBattlingUnitDied ; 8C/AD96

	.al
	.xl
	.autsiz
	.databank ?

	lda @l $7EA67F
	cmp #$0000
	bne _False

	lda aActionStructUnit1.Character
	cmp wEventEngineCharacterTarget,b
	bne +

	lda aActionStructUnit1.CurrentHP
	and #$00FF
	beq _True

	+
	lda aActionStructUnit2.Character
	cmp wEventEngineCharacterTarget,b
	bne _False

	lda aActionStructUnit2.CurrentHP
	and #$00FF
	bne _False

	_True
	sec
	rtl

	_False
	clc
	rtl

rlUnknown8CADC7 ; 8C/ADC7

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
	phy

	lda lEventEngineLongParameter,b
	sta lR18
	lda lEventEngineLongParameter+1,b
	sta lR18+1

	-
	ldy #$0000
	lda [lR18],y
	beq _False

	ldy #$0004
	lda [lR18],y
	and #$00FF
	sta wR0

	ldy #$0005
	lda [lR18],y
	and #$00FF
	sta wR1

	jsl rlCheckTileOccupied
	bcc _True

	lda lEventEngineUnitGroupPointer,b
	clc
	adc #$0014
	sta lEventEngineUnitGroupPointer,b

	bra -

	_False
	lda #$0000
	sta wEventEngineTruthFlag,b
	ply
	plx
	plp
	plb
	clc
	rtl

	_True
	lda #$0001
	sta wEventEngineTruthFlag,b
	ply
	plx
	plp
	plb
	sec
	rtl

rlASMCLoadUnitGroup ; 8C/AE1C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aPlayerUnits
	pha
	rep #$20
	plb

	.databank `aPlayerUnits

	lda wUnknown001730,b
	bne _False

	lda lEventEngineUnitGroupPointer+1,b
	sta lR18+1
	lda lEventEngineUnitGroupPointer,b
	sta lR18

	lda [lR18]
	beq _False

	lda #aSelectedCharacterBuffer
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83905C

	lda lEventEngineUnitGroupPointer,b
	sta lR18
	lda lEventEngineUnitGroupPointer+1,b
	sta lR18+1

	lda #$0001
	jsl $839457
	bcs +

	lda #aSelectedCharacterBuffer
	sta wR1

	lda #$0000
	sta wR4

	jsl rlUnknown80E626

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $839041

	lda #aBurstWindowCharacterBuffer
	sta wR0

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83905C

	+
	lda lEventEngineUnitGroupPointer,b
	clc
	adc #$0014
	sta lEventEngineUnitGroupPointer,b

	plp
	plb
	sec
	rtl

	_False
	stz lEventEngineUnitGroupPointer,b
	plp
	plb
	clc
	rtl

rlLoadPrepGroups ; 8C/AE94

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank ?

	ldy #$0000

	-
	lda lEventEngineLongParameter,b
	sta lR19
	lda lEventEngineLongParameter+1,b
	sta lR19+1

	lda [lR19],y
	beq _End

	phy
	clc
	adc #$0002
	sta lR18
	inc y
	inc y

	sep #$20
	lda [lR19],y
	sta lR18+2
	rep #$20

	lda #$0000
	jsl $839457

	ply
	inc y
	inc y
	inc y
	bra -

	_End
	plp
	plb
	clc
	rtl

rlASMCPrepareCapturedUnitsForRescue ; 8C/AECB

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlPrepareCapturedUnitsForRescueEffect
	sta lR25
	lda #>`rlPrepareCapturedUnitsForRescueEffect
	sta lR25+1
	jsr rlApplyASMCLoadingEffect
	rtl

rlPrepareCapturedUnitsForRescueEffect ; 8C/AED9

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusInvisible
	beq +

	jmp _End

	+
	bit #TurnStatusCaptured
	bne +

	jmp _End

	+
	lda wCurrentChapter,b
	cmp #Chapter21x
	beq +

	lda aTargetingCharacterBuffer.CapturedChapter,b
	and #$00FF
	tax
	lda aCapturedUnitRescueChapterTable,x
	and #$00FF
	cmp wCurrentChapter,b
	bne _End

	+
	sep #$20
	lda aTargetingCharacterBuffer.Status,b
	cmp #StatusPetrify
	beq +

	lda #None
	sta aTargetingCharacterBuffer.Status,b

	+
	lda #$00
	sta aTargetingCharacterBuffer.Fatigue,b
	rep #$20

	lda #Leif
	sta aTargetingCharacterBuffer.Leader,b

	lda #$0000
	sta aTargetingCharacterBuffer.Item1ID,b
	sta aTargetingCharacterBuffer.Item2ID,b
	sta aTargetingCharacterBuffer.Item3ID,b
	sta aTargetingCharacterBuffer.Item4ID,b
	sta aTargetingCharacterBuffer.Item5ID,b
	sta aTargetingCharacterBuffer.Item6ID,b
	sta aTargetingCharacterBuffer.Item7ID,b

	lda lEventEngineLongParameter,b
	bne +

	lda #TurnStatusCaptured
	trb aTargetingCharacterBuffer.TurnStatus,b
	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041
	bra _End

	+
	lda lEventEngineLongParameter,b
	sta lR18
	lda lEventEngineLongParameter+1,b
	sta lR18+1

	lda [lR18]
	and #$00FF
	beq _End

	lda [lR18]
	sta aTargetingCharacterBuffer.Coordinates,b
	jsl rlPlaceLoadedUnitMain
	bcs _End

	inc lEventEngineLongParameter,b
	inc lEventEngineLongParameter,b

	_End
	rtl

rlASMCLoadPlayerUnitsByStartingPositions ; 8C/AF73

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlLoadPlayerUnitsByStartingPositionsEffect
	sta lR25
	lda #>`rlLoadPlayerUnitsByStartingPositionsEffect
	sta lR25+1
	jsr rlApplyASMCLoadingEffect
	rtl

rlASMCGetStartingPositionsArrayPointerAndLength ; 8C/AF81

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsGetStartingPositionArrayLength

	lda #$0000
	sta $7EA955
	rtl

rlLoadPlayerUnitsByStartingPositionsEffect ; 8C/AF8C

	.al
	.xl
	.autsiz
	.databank ?

	lda $7EA955
	cmp $7EA95C
	beq +

	lda $7EA959
	sta lR18

	lda $7EA95A
	sta lR18+1

	lda $7EA955
	asl a
	tay
	lda [lR18],y
	sta aTargetingCharacterBuffer.Coordinates,b

	jsl rlPlaceLoadedUnit
	bcs +

	inc <>$7EA955,b

	+
	rtl

rlApplyASMCLoadingEffect ; 8C/AFB7

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`aPlayerUnits
	pha
	rep #$20
	plb

	.databank `aPlayerUnits

	ldx lEventEngineUnitGroupPointer,b
	lda $838E98,x
	beq _True

	cmp #$FFFF
	beq _False

	tay
	lda $0000,b,y
	beq _True

	txa
	lsr a
	sta wR0

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $83901C

	phx
	phk
	pea <>_Return - 1
	jmp [lR25]

	_Return
	plx

	_True
	inc x
	inc x
	stx lEventEngineUnitGroupPointer,b

	plb
	plp
	sec
	rts

	_False
	stz lEventEngineUnitGroupPointer,b
	plb
	plp
	clc
	rts

rlPlaceLoadedUnit ; 8C/AFFB

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusInvisible | TurnStatusCaptured
	bne rlPlaceLoadedUnitMain._True

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusActing
	beq rlPlaceLoadedUnitMain._True

rlPlaceLoadedUnitMain ; 8C/B00B

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aPlayerUnits
	pha
	rep #$20
	plb

	.databank `aPlayerUnits

	lda #aTargetingCharacterBuffer
	sta wR0

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $83905C
	jsl $83AD0C

	sep #$20
	lda aSelectedCharacterBuffer.MaxHP,b
	sta aSelectedCharacterBuffer.CurrentHP,b
	rep #$20

	lda aSelectedCharacterBuffer.TurnStatus,b
	and #~(TurnStatusUnknown1 | TurnStatusActing | TurnStatusGrayed | TurnStatusCaptured)
	sta aSelectedCharacterBuffer.TurnStatus,b

	sep #$20
	lda #None
	sta aSelectedCharacterBuffer.Rescue,b
	rep #$20

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $848E5A

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $839041

	lda #$0000
	sta wR4
	jsl rlUnknown80E626

	plp
	plb
	clc
	bra +

	_True
	sec

	+
	rtl

rsGetStartingPositionArrayLength ; 8C/B065

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0015
	sta lR18

	lda wCurrentChapter,b
	jsl $848933

	lda lR18
	sta $7EA959
	lda lR18+1
	sta $7EA95A

	ldy #$0000

	-
	lda [lR18],y
	and #$00FF
	cmp #$00FF
	beq +

	inc y
	inc y
	bra -

	+
	tya
	lsr a
	sta $7EA95C
	rts

rlASMCAllUnitsSetCharacterDataByte ; 8C/B095

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlAllUnitsSetCharacterDataByteEffect
	sta lR25
	lda #>`rlAllUnitsSetCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlAllUnitsSetCharacterDataByteEffect ; 8C/B095

	.al
	.xl
	.autsiz
	.databank ?

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda wEventEngineParameter2,b
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041
	rtl

rlASMCSetCharacterDataByte ; 8C/B0CC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetCharacterDataByteEffect
	sta lR25
	lda #>`rlSetCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlSetCharacterDataByteEffect ; 8C/B0E7

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer,b
	cmp wEventEngineCharacterTarget,b
	bne +

	jsr rsEnsureNotSettingPlayerCharacterAIBytes
	bcc +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda wEventEngineParameter2,b
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rsEnsureNotSettingPlayerCharacterAIBytes ; 8C/B110

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.DeploymentNumber,b
	and #Player | Enemy | NPC
	cmp #Player
	bne _True

	lda wEventEngineParameter1,b
	cmp #structCharacterDataRAM.AI
	bge _False

	_True
	sec
	rts

	_False
	clc
	rts

rlASMCSetCharacterDataWord ; 8C/B127

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetCharacterDataWordEffect
	sta lR25
	lda #>`rlSetCharacterDataWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	plp
	plb
	clc
	rtl

rlSetCharacterDataWordEffect ; 8C/B142

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	jsr rsEnsureNotSettingPlayerCharacterAIBytes
	bcc +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay
	lda wEventEngineParameter2,b
	sta $0000,b,y

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCAddCharacterDataByte ; 8C/B167

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlAddCharacterDataByteEffect
	sta lR25
	lda #>`rlAddCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlAddCharacterDataByteEffect ; 8C/B182

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda wEventEngineParameter2,b
	clc
	adc $0000,b,y
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041

	+
	rtl

rlASMCSubtractCharacterDataByte ; 8C/B1AA

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSubtractCharacterDataByteEffect
	sta lR25
	lda #>`rlSubtractCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlSubtractCharacterDataByteEffect ; 8C/B1C5

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda $0000,b,y
	sec
	sbc wEventEngineParameter2,b
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041

	+
	rtl

rlASMCSetBitsCharacterDataWord ; 8C/B1ED

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetBitsCharacterDataWordEffect
	sta lR25
	lda #>`rlSetBitsCharacterDataWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	plp
	plb
	clc
	rtl

rlSetBitsCharacterDataWordEffect ; 8C/B208

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	jsr rsEnsureNotSettingPlayerCharacterAIBytes
	bcc +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay
	lda wEventEngineParameter2,b
	ora $0000,b,y
	sta $0000,b,y

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCUnsetBitsCharacterDataWord ; 8C/B230

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlUnsetBitsCharacterDataWordEffect
	sta lR25
	lda #>`rlUnsetBitsCharacterDataWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	plp
	plb
	clc
	rtl

rlUnsetBitsCharacterDataWordEffect ; 8C/B24B

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	jsr rsEnsureNotSettingPlayerCharacterAIBytes
	bcc +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay
	lda wEventEngineParameter2,b
	eor #$FFFF
	and $0000,b,y
	sta $0000,b,y

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCCheckBitsSetCharacterDataWord ; 8C/B276

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineTruthFlag,b

	lda #<>rlCheckBitsSetCharacterDataWordEffect
	sta lR25
	lda #>`rlCheckBitsSetCharacterDataWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	plp
	plb
	clc
	rtl

rlCheckBitsSetCharacterDataWordEffect ; 8C/B297

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay
	lda $0000,b,y
	bit wEventEngineParameter2,b
	beq +

	lda #$0001
	sta wEventEngineTruthFlag,b

	+
	rtl

rlASMCSetCharacterDataByteIfByte ; 8C/B2B6

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetCharacterDataByteIfByteEffect
	sta lR25
	lda #>`rlSetCharacterDataByteIfByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlSetCharacterDataByteIfByteEffect ; 8C/B2D1

	.al
	.xl
	.autsiz
	.databank ?

	ldx wEventEngineCharacterStructParameter,b
	lda @l aTargetingCharacterBuffer,x
	and #$00FF
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda wEventEngineParameter2,b
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCSetCharacterDataByteIfWord ; 8C/B2FC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetCharacterDataByteIfWordEffect
	sta lR25
	lda #>`rlSetCharacterDataByteIfWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlSetCharacterDataByteIfWordEffect ; 8C/B317

	.al
	.xl
	.autsiz
	.databank ?

	ldx wEventEngineCharacterStructParameter,b
	lda @l aTargetingCharacterBuffer,x
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda wEventEngineParameter2,b
	sta $0000,b,y
	rep #$20

	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCSetBitsCharacterDataIfWord ; 8C/B33F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlSetBitsCharacterDataIfWordEffect
	sta lR25
	lda #>`rlSetBitsCharacterDataIfWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlSetBitsCharacterDataIfWordEffect ; 8C/B35A

	.al
	.xl
	.autsiz
	.databank ?

	ldx wEventEngineCharacterStructParameter,b
	lda aTargetingCharacterBuffer,x
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	lda wEventEngineParameter2,b
	ora $0000,b,y
	sta $0000,b,y


	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCUnsetBitsCharacterDataIfWord ; 8C/B381

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlUnsetBitsCharacterDataIfWordEffect
	sta lR25
	lda #>`rlUnsetBitsCharacterDataIfWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	plp
	plb
	clc
	rtl

rlUnsetBitsCharacterDataIfWordEffect ; 8C/B39C

	.al
	.xl
	.autsiz
	.databank ?

	ldx wEventEngineCharacterStructParameter,b
	lda @l aTargetingCharacterBuffer,x
	cmp wEventEngineCharacterTarget,b
	bne +

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	lda wEventEngineParameter2,b
	eor #$FFFF
	and $0000,b,y
	sta $0000,b,y


	lda #aTargetingCharacterBuffer
	sta wR1

	jsl $839041

	+
	rtl

rlASMCCountAllUnitsWithCharacterDataByte ; 8C/B3C6

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter3,b

	lda #<>rlCountUnitsWithCharacterDataByteEffect
	sta lR25
	lda #>`rlCountUnitsWithCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter3,b
	sta wEventEngineParameter1,b

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitsWithCharacterDataByteEffect ; 8C/B3F8

	.al
	.xl
	.autsiz
	.databank ?

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	sep #$20
	lda $0000,b,y
	cmp wEventEngineParameter2,b
	bne +

	inc wEventEngineParameter3,b

	+
	rep #$20
	rtl

rlASMCCountPlayerUnitsWithCharacterDataByte ; 8C/B410

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter3,b

	lda #<>rlCountUnitsWithCharacterDataByteEffect
	sta lR25
	lda #>`rlCountUnitsWithCharacterDataByteEffect
	sta lR25+1
	jsr rsLoopThroughPlayerUnitsAndRunRoutine

	lda wEventEngineParameter3,b
	sta wEventEngineParameter1,b

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlASMCCountAllUnitsWithCharacterDataWord ; 8C/B442

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter3,b

	lda #<>rlCountUnitsWithCharacterDataWordEffect
	sta lR25
	lda #>`rlCountUnitsWithCharacterDataWordEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter3,b
	sta wEventEngineParameter1,b

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitsWithCharacterDataWordEffect ; 8C/B474

	.al
	.xl
	.autsiz
	.databank ?

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	lda $0000,b,y
	cmp wEventEngineParameter2,b
	bne +

	inc wEventEngineParameter3,b

	+
	rtl

rlASMCCountAllUnitsWithCharacterDataWordBitsSet ; 8C/B488

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter3,b

	lda #<>rlCountUnitsWithCharacterDataWordBitsSetEffect
	sta lR25
	lda #>`rlCountUnitsWithCharacterDataWordBitsSetEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter3,b
	sta wEventEngineParameter1,b

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitsWithCharacterDataWordBitsSetEffect ; 8C/B4BA

	.al
	.xl
	.autsiz
	.databank ?

	lda #aTargetingCharacterBuffer
	clc
	adc wEventEngineParameter1,b
	tay

	lda $0000,b,y
	bit wEventEngineParameter2,b
	beq +

	inc wEventEngineParameter3,b

	+
	rtl

rlASMCCountAllUnitUncapturedAlive ; 8C/B4CE

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveUncapturedEffect
	sta lR25
	lda #>`rlCountUnitAliveUncapturedEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlASMCCountPlayerUnitUncapturedAlive ; 8C/B4FA

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveUncapturedEffect
	sta lR25
	lda #>`rlCountUnitAliveUncapturedEffect
	sta lR25+1
	jsr rsLoopThroughPlayerUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlASMCCountEnemyUnitUncapturedAlive ; 8C/B526

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveUncapturedEffect
	sta lR25
	lda #>`rlCountUnitAliveUncapturedEffect
	sta lR25+1
	jsr rsLoopThroughEnemyUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlASMCCountNPCUnitUncapturedAlive ; 8C/B552

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveUncapturedEffect
	sta lR25
	lda #>`rlCountUnitAliveUncapturedEffect
	sta lR25+1
	jsr rsLoopThroughNPCUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitAliveUncapturedEffect ; 8C/B57E

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	beq +

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne _End

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusActing | TurnStatusInvisible | TurnStatusCaptured
	bne _End

	+
	inc wEventEngineParameter1,b

	_End
	rtl

rlASMCCountAllUnitUncapturedAlive2 ; 8C/B597

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveUncaptured2Effect
	sta lR25
	lda #>`rlCountUnitAliveUncaptured2Effect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitAliveUncaptured2Effect ; 8C/B5C3

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	beq +

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne _End

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	bne _End

	+
	inc wEventEngineParameter1,b

	_End
	rtl

rlASMCCountAllUnitUncapturedAliveByTable ; 8C/B5DC

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	-
	lda lEventEngineLongParameter,b
	sta lR18
	lda lEventEngineLongParameter+1,b
	sta lR18+1

	lda [lR18]
	beq ++

	sta wEventEngineCharacterTarget,b

	inc lEventEngineLongParameter,b
	inc lEventEngineLongParameter,b

	lda #<>rlCountUnitAliveUncapturedEffect
	sta lR25
	lda #>`rlCountUnitAliveUncapturedEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	bra -

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b

	+
	plp
	plb
	clc
	rtl

rlASMCCountAllUnitRescuedByPlayerOrNPCByTable ; 8C/B621

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	-
	lda lEventEngineLongParameter,b
	sta lR18
	lda lEventEngineLongParameter+1,b
	sta lR18+1

	lda [lR18]
	beq +

	sta wEventEngineCharacterTarget,b

	inc lEventEngineLongParameter,b
	inc lEventEngineLongParameter,b

	lda #<>rlCheckAllUnitRescuedByPlayerOrNPCEffect
	sta lR25
	lda #(rlCheckAllUnitRescuedByPlayerOrNPCEffect)>>8
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine
	bra -

	+

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b

	plp
	plb
	clc
	rtl

rlASMCCheckUnitRescuedByPlayerOrNPC ; 8C/B666

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCheckAllUnitRescuedByPlayerOrNPCEffect
	sta lR25
	lda #>`rlCheckAllUnitRescuedByPlayerOrNPCEffect
	sta lR25+1
	jsr rsLoopThroughPlayerUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCheckAllUnitRescuedByPlayerOrNPCEffect ; 8C/B692

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterTarget,b
	beq +

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne _End

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusActing | TurnStatusInvisible | TurnStatusCaptured
	beq +

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusRescued
	beq _End

	lda aTargetingCharacterBuffer.Rescue,b
	and #$00FF
	and #Player | Enemy | NPC
	cmp #Player
	beq +

	cmp #NPC
	bne _End

	+
	inc wEventEngineParameter1,b

	_End
	rtl

rlCheckOlwenDeadOrUnrecruited ; 8C/B6C6

	.al
	.xl
	.autsiz
	.databank ?

	lda #Olwen
	sta wR0
	bra +

rlCheckSchroffDeadOrUnrecruited ; 8C/B6CD

	.al
	.xl
	.autsiz
	.databank ?

	lda #Schroff
	sta wR0

	+
	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $83976E
	and #$FFFF
	bne +

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead
	bne +

	clc
	rtl

	+
	sec
	rtl

rlASMCCheckConomoreOnMap ; 8C/B6EC

	.al
	.xl
	.autsiz
	.databank ?

	lda #aBurstWindowCharacterBuffer
	sta wR1
	lda #Conomore
	sta wR0
	jsl $83976E
	and #$FFFF
	beq _True

	lda #$0000
	bra +

	_True
	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	clc
	rtl

rlASMCCheckAllUnitAlive ; 8C/B70C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #$0000
	sta wEventEngineParameter1,b

	lda #<>rlCountUnitAliveEffect
	sta lR25
	lda #>`rlCountUnitAliveEffect
	sta lR25+1
	jsr rsLoopThroughAllUnitsAndRunRoutine

	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b
	plp
	plb
	clc
	rtl

rlCountUnitAliveEffect ; 8C/B738

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.Character,b
	cmp wEventEngineCharacterTarget,b
	bne +

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusCaptured
	bne +

	lda aTargetingCharacterBuffer.DeploymentNumber,b
	and #Player | Enemy | NPC
	cmp #Player
	bne +

	inc wEventEngineParameter1,b

	+
	rtl

rsLoopThroughAllUnitsAndRunRoutine ; 8C/B757

	.al
	.xl
	.autsiz
	.databank ?

	lda #%00000111
	pha
	bit #%00000001
	beq +

	jsr rsLoopThroughPlayerUnitsAndRunRoutine

	+
	pla
	pha
	bit #%00000010
	beq +

	jsr rsLoopThroughEnemyUnitsAndRunRoutine

	+
	pla
	bit #%00000100
	beq +
	jsr rsLoopThroughNPCUnitsAndRunRoutine

	+
	rts

rsLoopThroughPlayerUnitsAndRunRoutine ; 8C/B777

	.al
	.xl
	.autsiz
	.databank ?

	lda #Player + 1
	bra +

rsLoopThroughEnemyUnitsAndRunRoutine ; 8C/B77C

	.al
	.xl
	.autsiz
	.databank ?

	lda #Enemy + 1
	bra +

rsLoopThroughNPCUnitsAndRunRoutine ; 8C/B781

	.al
	.xl
	.autsiz
	.databank ?

	lda #NPC + 1

	+
	jsl $839825
	rts

rlASMCSetUnitsLeftBehindAsCaptured ; 8C/B789

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlApplyLeftBehindCaptured
	sta lR25
	lda #>`rlApplyLeftBehindCaptured
	sta lR25+1
	lda #Player + 1
	jsl $839825

	plp
	plb
	clc
	rtl

rlApplyLeftBehindCaptured ; 8C/B7A8

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	bne +

	lda #aTargetingCharacterBuffer
	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83905C

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83ACA8

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83A272

	lda aSelectedCharacterBuffer.TurnStatus,b
	and #~TurnStatusRescued
	ora #TurnStatusActing | TurnStatusCaptured
	sta aSelectedCharacterBuffer.TurnStatus,b

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $839041

	+
	rtl

rlASMCSetUnitsLeftBehindCoordinates ; 8C/B7E6

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aTargetingCharacterBuffer
	pha
	rep #$20
	plb

	.databank `aTargetingCharacterBuffer

	lda #<>rlApplyLeftBehindCoordinates
	sta lR25
	lda #>`rlApplyLeftBehindCoordinates
	sta lR25+1
	lda #Player + 1
	jsl $839825

	plp
	plb
	clc
	rtl

rlApplyLeftBehindCoordinates ; 8C/B805

	.al
	.xl
	.autsiz
	.databank ?

	lda aTargetingCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	bne +

	lda #aTargetingCharacterBuffer
	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83905C

	lda #1 | (1 << 8)
	sta aSelectedCharacterBuffer.Coordinates,b

	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $839041

	+
	rtl

rlASMCCreateRandomChestItemArrayFromUnitInventories ; 8C/B82B

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aRandomizedItems
	pha
	rep #$20
	plb

	.databank `aRandomizedItems

	lda #(`aRandomizedItems)<<8
	sta lR18+1
	lda #<>aRandomizedItems
	sta lR18
	lda #size(aRandomizedItems)
	sta lR19
	lda #$0000
	jsl rlBlockFillWord

	lda #(`aRandomizedNumbers)<<8
	sta lR18+1
	lda #<>aRandomizedNumbers
	sta lR18
	lda #size(aRandomizedNumbers)
	sta lR19
	lda #$0000
	jsl rlBlockFillWord

	lda #(`aRandomizedItemCreationArray)<<8
	sta lR18+1
	lda #<>aRandomizedItemCreationArray
	sta lR18
	lda #size(aRandomizedItemCreationArray)
	sta lR19
	lda #$0000
	jsl rlBlockFillWord

	lda #<>rlStoreInventoryToRandomChestItemArray
	sta lR25
	lda #>`rlStoreInventoryToRandomChestItemArray
	sta lR25+1
	lda #Player + 1
	jsl $839825

	jsr rsAssignRandomItemsToChestNumbers

	plp
	plb
	clc
	rtl

rlStoreInventoryToRandomChestItemArray ; 8C/B88F

	.al
	.xl
	.autsiz
	.databank ?

	lda @l aTargetingCharacterBuffer.TurnStatus
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	bne _End

	ldx #$0000

	-
	lda @l aTargetingCharacterBuffer.Items,x
	beq +

	pha
	lda #$0000
	sta @l aTargetingCharacterBuffer.Items,x

	pla
	phx
	jsr rsStoreItemToRandomChestArray
	plx

	+
	inc x
	inc x
	cpx #size(structCharacterDataRAM.Items)
	bcc -

	lda #aTargetingCharacterBuffer
	sta wR1
	jsl $839041

	_End
	rtl

rsStoreItemToRandomChestArray ; 8C/B8C0

	.al
	.xl
	.autsiz
	.databank ?

	pha
	jsl rlCopyItemDataToBuffer
	jsl rlGetRandomItemWeight

	lda @l aItemDataBuffer.Cost
	bne +

	lda #$FFFF

	+
	sta wR1
	pla
	sta wR0

	ldx #$0000

	-
	lda aRandomizedItemCreationArray,x
	cmp wR1
	bge +

	inc x
	inc x
	cpx #2 * 16
	blt -

	+
	dec x
	dec x
	bmi ++

	stx wR2
	beq +

	ldx #$0000

	-
	lda aRandomizedItemCreationArray+2,x
	sta aRandomizedItemCreationArray,x

	lda aRandomizedItems+2,x
	sta aRandomizedItems,x

	inc x
	inc x
	cpx wR2
	bne -

	+
	ldx wR2
	lda wR0
	sta aRandomizedItems,x
	lda wR1
	sta aRandomizedItemCreationArray,x

	+
	rts

rsAssignRandomItemsToChestNumbers ; 8C/B919

	.al
	.xl
	.autsiz
	.databank ?

	lda #16
	sta wR0

	_Loop
	lda wR0
	pha
	jsl rlGetRandomNumber
	and #$000F
	clc
	adc #$0001
	sta wR1
	pla
	sta wR0

	-
	ldx #$0000

	-
	phx
	txa
	lsr a
	tax
	lda aRandomizedNumbers,x
	plx
	and #$00FF
	bne _NextItem

	dec wR1
	bpl _NextItem

	txa
	lsr a
	tax
	lda wR0
	dec a
	sep #$20
	sta aRandomizedNumbers,x
	rep #$20
	dec wR0
	bne _Loop
	bra _End

	_NextItem
	inc x
	inc x
	cpx #2 * 16
	bcc -
	bra --

	_End
	rts

rlASMCAddFixedItemsToRandomChestArray ; 8C/B964

	.al
	.xl
	.autsiz
	.databank ?

	lda #Rapier
	ora #$FE00
	jsr rsStoreItemToRandomChestArray

	lda #Javelin
	ora #$FE00
	jsr rsStoreItemToRandomChestArray

	lda #SteelSword
	ora #$FE00
	jsr rsStoreItemToRandomChestArray

	lda #Vulnerary
	ora #$FE00
	jsr rsStoreItemToRandomChestArray

	clc
	rtl

rlASMCCreateRandomChestTiles ; 8C/B98A

	phb
	php

	phk
	plb

	.databank `*

	; Probably supposed to be #0000

	ldx $00

	-
	lda aRandomizedItems,x
	beq +

	jsr rsCreateRandomChestTile

	+
	inc x
	inc x
	cpx #2 * 16
	bcc -

	plp
	plb
	clc
	rtl

rsCreateRandomChestTile ; 8C/B9A4

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
	txa
	lsr a
	jsl rlGetRandomChestCoordinates

	lda wR0
	sta wEventEngineXCoordinate,b

	lda wR1
	sta wEventEngineYCoordinate,b

	lda #$0027
	sta wEventEngineParameter1,b

	jsl rlASMCSingleTileChangeByCoords

	plx
	plp
	plb
	rts

rlASMCGetRandomChestItem ; 8C/B9C7

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda wCursorXCoord,b
	sta wR0

	lda wCursorYCoord,b
	sta wR1

	jsl rlCheckIfRandomChest

	pha
	pha
	clc
	adc #$0041
	jsl rlSetEventFlag

	pla
	jsl rlGetRandomChestCoordinates
	jsl rlSetRandomChestTileChange
	pla
	asl a
	tax
	lda aRandomizedItems,x
	sta wEventEngineParameter1,b
	jsl rlASMCSetPopupGivenItemWithExistingDurability
	plp
	plb
	clc
	rtl

rlSetRandomChestTileChange ; 8C/B9FE

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	sta wEventEngineXCoordinate,b

	lda wR1
	sta wEventEngineYCoordinate,b

	lda #$0026
	sta wEventEngineParameter1,b
	jsl rlASMCSingleTileChangeByCoords
	rtl

rlCheckIfRandomChest ; 8C/BA13

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

	lda wR0
	sta wR2
	lda wR1
	sta wR3

	ldx $00

	-
	lda aRandomizedItems,x
	beq _NextItem

	phx
	txa
	lsr a
	jsl rlGetRandomChestCoordinates

	plx
	lda wR0
	cmp wR2
	bne _NextItem

	lda wR1
	cmp wR3
	bne _NextItem

	txa
	lsr a
	bra +

	_NextItem
	inc x
	inc x
	cpx #2 * 16
	bcc -

	lda #$FFFF

	+
	ply
	plp
	plb
	rtl

rlGetRandomChestCoordinates ; 8C/BA4E

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda aRandomizedNumbers,x
	and #$00FF
	asl a
	tax
	lda eventChapter4Events._ChestPositionTable,x
	and #$00FF
	sta wR0

	lda eventChapter4Events._ChestPositionTable+1,x
	and #$00FF
	sta wR1
	rtl

rlGetTriggeredRandomChests ; 8C/BA6B

	.al
	.xl
	.autsiz
	.databank ?

	lda wCurrentChapter,b
	cmp #Chapter4
	bne _End

	jsl rlASMCCreateRandomChestTiles

	lda #$0000

	-
	pha
	clc
	adc #$0041
	jsl rlTestEventFlagSet
	pla
	bcc +

	pha
	jsl rlGetRandomChestCoordinates
	jsl rlSetRandomChestTileChange
	pla

	+
	inc a
	cmp #16
	bcc -

	jsl $83B476
	jsl $848B79

	_End
	rtl

rlASMCCheckForcedBlank ; 8C/BA9F

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda bBuf_INIDISP
	and #INIDISP.ForcedBlank
	sta @l wEventEngineTruthFlag
	plp
	clc
	rtl

rlScrollCameraCharEffect ; 8C/BAAC

	.al
	.xl
	.autsiz
	.databank ?

	sta wR0

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	lda #$0000
	sta @l wEventEngineXCoordinate
	sta @l wEventEngineYCoordinate

	lda wUnknown000E25,b
	cmp #$0006
	bne +

	lda aSelectedCharacterBuffer.Character,b
	cmp wR0
	bne +

	lda aSelectedCharacterBuffer.X,b
	and #$00FF
	sta @l wEventEngineXCoordinate

	lda aSelectedCharacterBuffer.Y,b
	and #$00FF
	sta @l wEventEngineYCoordinate

	lda #aSelectedCharacterBuffer
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83905C
	bra _End

	+
	lda #aBurstWindowCharacterBuffer
	sta wR1
	jsl $83976E
	and #$FFFF
	bne _End

	lda aBurstWindowCharacterBuffer.X,b
	and #$00FF
	sta @l wEventEngineXCoordinate

	lda aBurstWindowCharacterBuffer.Y,b
	and #$00FF
	sta @l wEventEngineYCoordinate

	_End
	ply
	plx
	plp
	plb
	rtl

rlUnknown8CBB19 ; 8C/BB19

	.al
	.xl
	.autsiz
	.databank ?

	lda lEventEngineLongParameter,b
	sta $7EF79E

	lda lEventEngineLongParameter+1,b
	sta $7EF79E+1

	lda #$00FF
	sta $7EF795

	lda #$000C
	sta $7EF797

	lda #$0040
	sta $7EF799

	lda #(`_aUnknown8CBB4C)<<8
	sta $7EF792+1
	lda #<>_aUnknown8CBB4C
	sta $7EF792

	bra rlUnknown8CBB8A

	_aUnknown8CBB4C ; 8C/BB4C
		.byte $01
		.long $7EF79E

rlUnknown8CBB50 ; 8C/BB50

	.al
	.xl
	.autsiz
	.databank ?

	php
	sta $7EF79B

	lda #$00FF
	sta $7EF795

	lda #$000F
	sta $7EF797

	lda #(`_aUnknown8CBB73)<<8
	sta $7EF792+1
	lda #<>_aUnknown8CBB73
	sta $7EF792
	bra rlUnknown8CBB8A

	_aUnknown8CBB73 ; 8C/BB73
		.byte $06
		.long $7EF79B

		.byte $02
		.long menutextUnknown8CBB7C

		.byte $08

menutextUnknown8CBB7C ; 8C/BB7C
	.enc "MenuText"
	.text "をてにいれた\n"

rlUnknown8CBB8A ; 8C/BB8A

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`$8EB441)<<8
	sta lR43+1
	lda #<>$8EB441
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx
	rtl

rlASMCFinalChapterMapChange ; 8C/BB9B

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`$949385)<<8
	sta lR43+1
	lda #<>$949385
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive
	plx
	clc
	rtl

rlASMCDialogueContinue ; 8C/BBAD

	.al
	.xl
	.autsiz
	.databank ?

	lda lEventEngineLongParameter,b
	sta lR18
	lda lEventEngineLongParameter+1,b
	sta lR18+1
	jsl $959125
	rtl

rlBeginDialoguePrompt ; 8C/BBBC

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wEventEngineTruthFlag,b

	lda wUnknown0017E9,b
	ora #$0040
	sta wUnknown0017E9,b
	rtl

rlDialoguePromptSelector ; 8C/BBCC

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

	lda wJoy1Input
	bit #JoypadA
	bne _APressed

	lda wJoy1Alt
	bit #JoypadDown | JoypadUp
	beq +

	lda wEventEngineTruthFlag,b
	eor #$0001
	sta wEventEngineTruthFlag,b

	+
	jsl rlDialoguePromptMain

	dec aUnknown00180A,b
	dec aUnknown00180A,b
	dec aUnknown00180A,b
	dec aUnknown00180A,b
	dec aUnknown00180A,b

	_APressed
	plx
	plp
	plb

	lda #$0001
	sta wUnknown0017EF,b
	sec
	rtl

rlDialoguePromptMain ; 8C/BC06

	.al
	.xl
	.autsiz
	.databank ?

	ldx wUnknown001808,b
	beq +

	ldx #$0004

	+
	lda <>_CoordinateTable,b,x
	sta wR0

	lda <>_CoordinateTable+2,b,x
	sta wR1

	lda wEventEngineTruthFlag,b
	eor #$0001
	asl a
	asl a
	asl a
	asl a
	clc
	adc wR1
	sta wR1
	jsl $859013

	rtl

	_CoordinateTable ; 8C/BC2C
		.word 24, 32
		.word 24, 184

rlUnknown8CBC34 ; 8C/BC34

	.al
	.xl
	.autsiz
	.databank ?

	tax
	phb
	php

	sep #$20
	lda #`aPlayerUnits
	pha
	rep #$20
	plb

	.databank `aPlayerUnits

	txa
	jsr rsUnknown8CBCB4
	bcc +

	lda aBurstWindowCharacterBuffer.Character,b
	sta wUnknown001832,b

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	ora #TurnStatusActing
	sta aBurstWindowCharacterBuffer.TurnStatus,b

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $839041
	jsl $8885D1

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83A89D
	jsl $8A8D9C

	+
	plp
	plb
	rtl

rlUnknown8CBC71 ; 8C/BC71

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001832,b
	beq ++

	sta wR0
	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83976E
	and #$FFFF
	bne _End

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	bne _End

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	bit #TurnStatusRescued
	bne +

	and #~TurnStatusActing
	sta aBurstWindowCharacterBuffer.TurnStatus,b

	+
	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $839041
	jsl $8885D1

	lda #$0000
	sta wUnknown001832,b

	+
	jsl $8A9013

	_End
	rtl

rsUnknown8CBCB4 ; 8C/BCB4

	.al
	.xl
	.autsiz
	.databank ?

	cmp wUnknown001834,b
	beq +

	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83976E
	and #$FFFF
	bne _False

	lda aBurstWindowCharacterBuffer.TurnStatus,b
	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
	beq _True

	_False
	clc
	rts

	+
	lda #aSelectedCharacterBuffer
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83905C

	_True
	sec
	rts

rlUnknown8CBCE3 ; 8C/BCE3

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterStructParameter,b
	sta wR0

	lda #aSelectedCharacterBuffer
	sta wR1

	jsl $83976E
	and #$FFFF
	bne _True

	lda #aSelectedCharacterBuffer
	sta wR0

	lda #<>aActionStructUnit1
	sta wR1

	jsl $83905C

	lda wEventEngineCharacterTarget,b
	sta wR0

	lda #aBurstWindowCharacterBuffer
	sta wR1

	jsl $83976E
	and #$FFFF
	bne _True

	lda #aBurstWindowCharacterBuffer
	sta wR0

	lda #<>aActionStructUnit2
	sta wR1

	jsl $83905C
	jsr rsUnknown8CBD30
	jsl $84B719

	clc
	rtl

	_True
	sec
	rtl

rsUnknown8CBD30 ; 8C/BD30

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta aActionStructUnit1.StartingCurrentHP

	lda #$0001
	sta aActionStructUnit2.StartingCurrentHP

	sep #$20
	lda #Rescue
	sta aActionStructUnit1.EquippedItemID1
	rep #$20

	sep #$20
	lda wEventEngineXCoordinate,b
	sta aActionStructUnit2.BattleAdjustedHit
	rep #$20

	sep #$20
	lda wEventEngineYCoordinate,b
	sta aActionStructUnit2.BattleHit
	rep #$20

	lda wEventEngineXCoordinate,b
	and #$00FF
	sta wEventEngineUnknownXTarget

	lda wEventEngineYCoordinate,b
	and #$00FF
	sta wEventEngineUnknownYTarget

	lda #(`$9A9029)<<8
	sta lUnknown7EA4EC+1
	lda #<>$9A9029
	sta lUnknown7EA4EC

	stz <>$7EA5D1,b
	stz <>$7EA5D3,b

	lda #$FFFF
	sta $7EA5D5
	rts

rlEventPetrifyCastingEffect ; 8CBD8E

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	sep #$20
	lda #`aActionStructUnit2
	pha
	rep #$20
	plb

	.databank `aActionStructUnit2

	sep #$20
	lda #StatusPetrify
	sta @l aActionStructUnit2.Status
	rep #$20

	lda #<>aActionStructUnit2
	sta wR1

	jsl $848E5A

	lda #<>aActionStructUnit2
	sta wR1
	jsl $839041

	plp
	plb
	rtl

rlASMCSetBattleQuoteMusic ; 8C/BDB7

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aBattleMusicTable)<<8
	sta lR18+1
	lda #<>aBattleMusicTable
	sta lR18
	lda wEventEngineCharacterStructParameter,b
	jsl rlFindWordCharTableEntry
	bcs +

	lda #$001E

	+
	sta aUnknown0004BA,b
	sta wCurrentMapMusic,b
	rtl

rlDialogueSilenceMusic ; 8C/BDD4

	.al
	.xl
	.autsiz
	.databank ?

	lda #$00E0
	jsl rlUnknown808C7D
	rtl

rlASMCGetChapterTurncount ; 8C/BDDC

	.al
	.xl
	.autsiz
	.databank ?

	php
	ldx #$0000

	-
	lda aTurncountsTable+structTurncountEntryRAM.Turncount,x
	beq ++

	lda aTurncountsTable+structTurncountEntryRAM.Chapter,x
	and #$00FF
	cmp wEventEngineParameter1,b
	beq +

	inc x
	inc x
	inc x
	bra -

	+
	lda aTurncountsTable+structTurncountEntryRAM.Turncount,x

	+
	sta wEventEngineParameter1,b
	lda wEventEngineParameter1,b
	beq +

	lda #$0001

	+
	sta wEventEngineTruthFlag,b

	plp
	rtl

rlUnknown8CBE0B ; 8C/BE0B

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

	stx wProcInput0,b
	sta wProcInput2,b

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
	bcs +

	jsl rlProcEngineCreateProc
	bcs +

	ply
	plp
	plb
	clc
	rtl

	+
	ply
	plp
	plb
	sec
	rtl

rlGetDialogueBoxGraphicsPointer ; 8C/BE43

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy

	lda #(`$F08960)<<8
	sta lR18+1
	lda #<>$F08960
	sta lR18

	ply
	plx
	plp
	rtl

rlGetDialogueBoxPalettePointer ; 8C/BE54

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy

	lda #(`$EADE60)<<8
	sta lR18+1
	lda #<>$EADE60
	sta lR18

	ply
	plx
	plp
	rtl

rlCopyDialogueBoxPalette ; 8C/BE65

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy

	jsl rlGetDialogueBoxPalettePointer

	lda #(`aBGPal0)<<8
	sta lR19+1
	lda #<>aBGPal0
	sta lR19
	lda #size(aBGPal0)
	sta wR20
	jsl rlBlockCopy

	ply
	plx
	plp
	rtl

rlLoadDialogueBGDialogueBoxGraphicsAndPalette ; 8C/BE83

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	pha

	jsl rlGetDialogueBoxGraphicsPointer
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList

	lda #$0800
	sta wR0

	lda #(`$7FB0F5)<<8
	sta lR18+1
	lda #<>$7FB0F5
	sta lR18
	lda #$2400
	sta wR1
	jsl rlDMAByPointer

	pla
	jsl rlCopyDialogueBoxPalette

	lda #$0000
	jsl rlUnknown829A4A

	lda #$0001
	jsl rlUnknown829A4A
	plp
	plb
	rtl

rlDialogueBGDrawDialogueBoxTails ; 8C/BEC8

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	jsl +

	lda #$0001

	+
	phb
	php

	phk
	plb

	.databank `*

	phx
	phy

	asl a
	tay

	asl a
	asl a
	sta wR2

	lda <>_aXCoordinateBase,b,y
	sta wR0

	lda <>_aYCoordinateBase,b,y
	sta wR1

	lda <>_aSpriteBase,b,y
	sta wR4

	lda <>_aAttributeBase,b,y
	sta wR5

	lda <>_aSpriteTable,b,y
	tay
	jsl rlPushToOAMBuffer

	ply
	plx
	plp
	plb
	rtl

	_aSpriteBase ; 8C/BEFF
		.word $0000
		.word $0000

	_aAttributeBase ; 8C/BF03
		.word $3E00
		.word $3E00

	_aXCoordinateBase ; 8C/BF07
		.word 80
		.word 144

	_aYCoordinateBase ; 8C/BF0B
		.word 64
		.word 152

	_aSpriteTable ; 8C/BF0F
		.addr _Sprite1
		.addr _Sprite2

	_Sprite1 .dstruct structSpriteArray, [[[0, 0], $42, true, $2A, 0, 0, false, false]]
	_Sprite2 .dstruct structSpriteArray, [[[0, 0], $42, true, $28, 0, 0, false, false]]

rlUnknown8CBF21 ; 8C/BF21

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

rlUnknown8CBF25 ; 8C/BF25

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0001
	sty wR1

rlUnknown8CBF2A ; 8C/BF2A

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

	cmp #$00FF
	bcc +

	lda #$0001

	+
	stx wProcInput0,b
	sta wProcInput2,b

	lda wR0
	sta wProcInput1,b

	lda wR1
	sta wProcInput3,b

	txa
	asl a
	tax
	lda #(`procPortrait0)<<8
	sta lR43+1
	lda @l _ProcTable,x
	sta lR43

	jsl rlProcEngineFindProc
	bcs +

	jsl rlProcEngineCreateProc
	bcs +

	ply
	plp
	plb
	clc
	rtl

	+
	ply
	plp
	plb
	sec
	rtl

	_ProcTable ; 8C/BF6B
		.word <>procPortrait0
		.word <>procPortrait1
		.word <>procPortrait2
		.word <>procPortrait3

rlUnknown8CBF73 ; 8C/BF73

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

	ldy #$0000
	sty wR1

	ldy #$0000
	sty wUnknown001836,b

	bra rlUnknown8CBF2A

rlUnknown8CBF84 ; 8C/BF84

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

	ldy #$0001
	sty wUnknown001836,b

	bra rlUnknown8CBF25

rlUnknown8CBF90 ; 8C/BF90

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

	ldy #$0000
	sty wUnknown001836,b

	bra rlUnknown8CBF25

rlDialogueLoadPortrait ; 8C/BF9C

	.al
	.xl
	.autsiz
	.databank ?

	stx wR0

	pha
	xba
	and #$00FF
	tax
	pla
	and #$00FF
	jsl rlUnknown8CBF25
	rtl

rlUnknown8CBFAD ; 8C/BFAD

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

rlGetPortraitGraphicsPointer ; 8C/BFB1

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy
	asl a
	asl a
	tax

	lda aPortraitTable,x
	sta lR18
	lda aPortraitTable+1,x
	sta lR18+1

	ply
	plx
	plp
	rtl

rlGetPortraitPalettePointer ; 8C/BFC7

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

rlGetPortraitPalettePointerByIndex ; 8C/BFCB

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy

	asl a
	asl a
	tax

	lda #(`$EAC000)<<8
	sta lR18+1
	lda aPortraitTable+3,x
	and #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	clc
	adc #<>$EAC000
	sta lR18

	ply
	plx
	plp
	rtl

rlUnknown8CBFEC ; 8C/BFEC

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlGetPortraitIndex

rlCopyPortraitToBuffer ; 8C/BFF0

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
	phy

	ldy wR1
	phy

	jsl rlGetPortraitGraphicsPointer

	pla
	asl a
	tay

	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda <>aPortraitBufferTable,b,y
	sta lR19
	jsl rlAppendDecompList

	ply
	plx
	plp
	plb
	rtl

aPortraitBufferTable ; 8C/C013
	.word <>$7FB0F5
	.word <>$7FB8F5
	.word <>$7FC0F5
	.word <>$7FC8F5

rlUnknown8CC01B ; 8C/C01B

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0000
	sty wR0
	bra rlDMAPortraitFromBuffer

rlUnknown8CC022 ; 8C/C022

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0001
	sty wR0

rlDMAPortraitFromBuffer ; 8C/C027

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
	phy
	pha
	pha

	lda wR0
	asl a
	asl a
	sta wR0

	pla
	clc
	adc wR0
	asl a
	tay
	lda <>_aVRAMTable,b,y
	sta wR1

	lda #(`$7FB0F5)<<8
	sta lR18+1

	pla
	asl a
	tay
	lda <>aPortraitBufferTable,b,y
	sta lR18

	lda #$0800
	sta wR0
	jsl rlDMAByPointer

	ply
	plx
	plp
	plb
	rtl

	_aVRAMTable ; 8C/C05B
		.word $B000 / 2
		.word $4000 / 2
		.word $4800 / 2
		.word $5000 / 2
		.word $3000 / 2
		.word $3800 / 2
		.word $0000 / 2
		.word $0800 / 2

rlCopyPortraitToVRAM ; 8C/C06B

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
	phy
	pha

	sta wR1
	lda wR0
	jsl rlCopyPortraitToBuffer

	pla
	jsl rlUnknown8CC01B

	ply
	plx
	plp
	plb
	rtl

rlUnknown8CC084 ; 8C/C084

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0001
	sty wR1
	bra +

rlCopyPortraitPaletteToBuffer ; 8C/C08B

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0000
	sty wR1

	+
	phb
	php

	phk
	plb

	.databank `*

	phx
	phy
	pha

	ldy wR1
	phy
	lda wR0
	jsl rlGetPortraitPalettePointer

	lda #(`aBGPaletteBuffer)<<8
	sta lR19+1
	lda #size(aBGPal0)
	sta wR20
	ply
	sty wR1
	pla
	jsl rlGetPortraitPaletteBufferPointer
	jsl rlBlockCopy

	ply
	plx
	plp
	plb
	rtl

rlUnknown8CC0BB ; 8C/C0BB

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
	phy

	asl a
	tay

	lda wR1
	beq +

	inc y
	inc y
	inc y
	inc y
	inc y
	inc y
	inc y
	inc y

	+
	lda <>_aVRAMTable,b,y
	sta wR1

	ply
	plx
	plp
	plb
	rtl

	_aVRAMTable ; 8C/C0D9
		.word $B000 / 2
		.word $4000 / 2
		.word $4800 / 2
		.word $5000 / 2
		.word $3000 / 2
		.word $3800 / 2
		.word $0000 / 2
		.word $0800 / 2

rlGetPortraitPaletteBufferPointer ; 8C/C0E9

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
	phy

	asl a
	tay

	lda #(`aBGPaletteBuffer)<<8
	sta lR19+1
	lda wR1
	beq +

	inc y
	inc y
	inc y
	inc y
	inc y
	inc y
	inc y
	inc y

	+
	lda <>_aPaletteTable,b,y
	sta lR19

	ply
	plx
	plp
	plb
	rtl

	_aPaletteTable ; 8C/C10C
		.word <>aBGPal1
		.word <>aBGPal2
		.word <>aBGPal3
		.word <>aBGPal4
		.word <>aOAMPal2
		.word <>aOAMPal3
		.word <>aOAMPal0
		.word <>aOAMPal1

rlCopyPortraitAndPalette ; 8C/C11C

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
	phy

	pha
	ldx wR0
	phx
	jsl rlCopyPortraitToVRAM

	plx
	stx wR0
	pla
	jsl rlCopyPortraitPaletteToBuffer

	ply
	plx
	plp
	plb
	rtl

rlUnknown8CC137 ; 8C/C137

	.al
	.xl
	.autsiz
	.databank ?

	sta wProcInput1,b
	lda wR0
	sta wProcInput0,b
	lda #(`procItemSelectPortrait)<<8
	sta lR43+1
	lda #<>procItemSelectPortrait
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rlRestoreMenuTextPalette ; 8C/C14E

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
	phy

	lda #(`$9E8260)<<8
	sta lR18+1
	lda #<>$9E8260
	sta lR18
	lda #(`aBGPal0)<<8
	sta lR19+1
	lda #<>aBGPal0
	sta lR19
	lda #size(aBGPal0)
	sta wR20
	jsl rlBlockCopy

	ply
	plx
	plp
	plb
	rtl

rlUnknown8CC176 ; 8C/C176

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
	pha

	lda wR0
	jsl $95812F

	clc
	adc #<>aBG1TilemapBuffer
	sta wR0

	lda wR0
	pha
	lda #(`$7ECA7C)<<8
	sta lR18+1
	lda #<>$7ECA7C
	sta lR18
	lda #$0200
	sta wR0
	lda #$7180
	sta wR1
	jsl rlDMAByPointer

	lda #$0000
	sta wR1
	pla
	sta wR0
	pla
	plx
	plp
	plb
	bra rlCopyPortraitBGTilemap

rlUnknown8CC1B1 ; 8C/C1B1

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta wR1
	lda #$0001
	bra rlCopyPortraitBGTilemap

rlUnknown8CC1BB ; 8C/C1BB

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta wR1
	lda #$0000
	bra rlCopyPortraitBGTilemap

rlUnknown8CC1C5 ; 8C/C1C5

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta wR1
	lda #$0002

rlCopyPortraitBGTilemap ; 8C/C1CD

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
	phy

	; Assuming this is the slot

	and #$0003
	asl a
	tay
	lda wR0
	pha

	; Select a tilemap and copy it

	lda #(`aLeftFacingPortraitTilemap)<<8
	sta lR18+1
	lda <>aPortraitSlotTilemaps,b,y
	sta lR18
	lda #(`$7FC0F5)<<8
	sta lR19+1
	lda #<>$7FC0F5
	sta lR19
	lda #size(aLeftFacingPortraitTilemap)
	sta wR20
	jsl rlBlockCopy

	; Add base tile index depending on slot

	lda #(`$7FC0F5)<<8
	sta lR18+1
	lda #<>$7FC0F5
	sta lR18
	lda #size(aLeftFacingPortraitTilemap)
	sta lR19
	lda <>aPortraitBaseTiles,b,y
	jsl rlBlockAddWord

	; Copy tilemap as a rectangle to dest

	lda #(`aPortraitTilemapInfo)<<8
	sta lUnknown000DDE+1,b
	lda #<>aPortraitTilemapInfo
	sta lUnknown000DDE,b
	plx
	jsl $87D4DD

	ply
	plx
	plp
	plb
	rtl

	aPortraitBaseTiles ; 8C/C224
		.word $6780
		.word $2800
		.word $2C40
		.word $3080

	aPortraitSlotTilemaps ; 8C/C22C
		.addr aRightFacingPortraitTilemap
		.addr aLeftFacingPortraitTilemap
		.addr aLeftFacingPortraitTilemap
		.addr aRightFacingPortraitTilemap

	aPortraitTilemapInfo ; 8C/C234
		.byte $06, $08
		.word $0000
		.word $007E
		.long $7FC0F5

	aLeftFacingPortraitTilemap .block ; 8C/C23D
		.word $0000
		.word $0001
		.word $0002
		.word $0003
		.word $0004
		.word $0005
		.word $0010
		.word $0011
		.word $0012
		.word $0013
		.word $0014
		.word $0015
		.word $0020
		.word $0021
		.word $0022
		.word $0023
		.word $0024
		.word $0025
		.word $0030
		.word $0031
		.word $0032
		.word $0033
		.word $0034
		.word $0035
		.word $0006
		.word $0007
		.word $0008
		.word $0009
		.word $000A
		.word $000B
		.word $0016
		.word $0017
		.word $0018
		.word $0019
		.word $001A
		.word $001B
		.word $0026
		.word $0027
		.word $0028
		.word $0029
		.word $002A
		.word $002B
		.word $0036
		.word $0037
		.word $0038
		.word $0039
		.word $003A
		.word $003B
		.bend

	aRightFacingPortraitTilemap .block ; 8C/C29D
		.word $0005
		.word $0004
		.word $0003
		.word $0002
		.word $0001
		.word $0000
		.word $0015
		.word $0014
		.word $0013
		.word $0012
		.word $0011
		.word $0010
		.word $0025
		.word $0024
		.word $0023
		.word $0022
		.word $0021
		.word $0020
		.word $0035
		.word $0034
		.word $0033
		.word $0032
		.word $0031
		.word $0030
		.word $000B
		.word $000A
		.word $0009
		.word $0008
		.word $0007
		.word $0006
		.word $001B
		.word $001A
		.word $0019
		.word $0018
		.word $0017
		.word $0016
		.word $002B
		.word $002A
		.word $0029
		.word $0028
		.word $0027
		.word $0026
		.word $003B
		.word $003A
		.word $0039
		.word $0038
		.word $0037
		.word $0036
		.bend

rlUnknown8CC2FD ; 8C/C2FD

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
	phy

	and #$0001
	asl a
	tay
	asl a
	asl a
	sta wR2
	lda wR0
	jsl $95812F

	clc
	adc #<>aBG1TilemapBuffer
	clc
	adc #$0100
	pha
	lda wR1
	asl a
	clc
	adc wR2
	tax
	lda #(`aUnknown8CC394)<<8
	sta lR18+1
	lda @l aUnknown8CC384,x
	sta lR18
	lda #(`$7FC0F5)<<8
	sta lR19+1
	lda #<>$7FC0F5
	sta lR19
	lda #$0018
	sta wR20
	jsl rlBlockCopy

	lda #(`$7FC0F5)<<8
	sta lR18+1
	lda #<>$7FC0F5
	sta lR18
	lda #$0018
	sta lR19
	lda <>aPortraitBaseTiles,b,y
	jsl rlBlockAddWord

	lda #(`aUnknown8CC424)<<8
	sta lUnknown000DDE+1,b
	lda #<>aUnknown8CC424
	sta lUnknown000DDE,b
	plx
	jsl $87D4DD

	lda #(`$7ECB7C)<<8
	sta lR18+1
	lda #<>$7ECB7C
	sta lR18
	lda #$0080
	sta wR0
	lda #$7200
	sta wR1
	jsl rlDMAByPointer

	ply
	plx
	plp
	plb
	rtl

aUnknown8CC384 ; 8C/C384
	.addr aUnknown8CC3DC
	.addr aUnknown8CC3DC
	.addr aUnknown8CC3F4
	.addr aUnknown8CC40C
	.addr aUnknown8CC394
	.addr aUnknown8CC394
	.addr aUnknown8CC3AC
	.addr aUnknown8CC3C4

aUnknown8CC394 ; 8C/C394
	.word $0006
	.word $0007
	.word $0008
	.word $0009
	.word $000A
	.word $000B
	.word $0016
	.word $0017
	.word $0018
	.word $0019
	.word $001A
	.word $001B

aUnknown8CC3AC ; 8C/C3AC
	.word $000C
	.word $000D
	.word $000E
	.word $000F
	.word $000A
	.word $000B
	.word $001C
	.word $001D
	.word $001E
	.word $001F
	.word $001A
	.word $001B

aUnknown8CC3C4 ; 8C/C3C4
	.word $002C
	.word $002D
	.word $002E
	.word $002F
	.word $000A
	.word $000B
	.word $003C
	.word $003D
	.word $003E
	.word $003F
	.word $001A
	.word $001B

aUnknown8CC3DC ; 8C/C3DC
	.word $000B
	.word $000A
	.word $0009
	.word $0008
	.word $0007
	.word $0006
	.word $001B
	.word $001A
	.word $0019
	.word $0018
	.word $0017
	.word $0016

aUnknown8CC3F4 ; 8C/C3F4
	.word $000B
	.word $000A
	.word $000F
	.word $000E
	.word $000D
	.word $000C
	.word $001B
	.word $001A
	.word $001F
	.word $001E
	.word $001D
	.word $001C

aUnknown8CC40C ; 8C/C40C
	.word $000B
	.word $000A
	.word $002F
	.word $002E
	.word $002D
	.word $002C
	.word $001B
	.word $001A
	.word $003F
	.word $003E
	.word $003D
	.word $003C

aUnknown8CC424 ; 8C/C424
	.byte $06, $02
	.long $7E0000
	.byte $00
	.long $7FC0F5

rlUnknown8CC430 ; 8C/C430

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000C16,b
	sta wR0
	lda #$0001
	bra rlUnknown8CC43F

rlUnknown8CC437 ; 8C/C437

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000C04,b
	sta wR0
	lda #$0000

rlUnknown8CC43F ; 8C/C43F

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
	phy

	and #$0001
	asl a
	tay
	lda #(`aUnknown8CC424)<<8
	sta lUnknown000DDE+1,b
	lda #<>aPortraitTilemapInfo
	sta lUnknown000DDE,b
	lda #(`$7FC0F5)<<8
	sta lR18+1
	lda #<>$7FC0F5
	sta lR18
	lda #$0060
	sta lR19
	lda <>aPortraitBaseTiles,b,y
	lda #$02FF
	jsl rlBlockFillWord

	lda wR0
	jsl $95812F

	clc
	adc #<>aBG1TilemapBuffer
	tax
	jsl $87D4DD

	lda #(`$7ECA7C)<<8
	sta lR18+1
	lda #<>$7ECA7C
	sta lR18
	lda #$0200
	sta wR0
	lda #$7180
	sta wR1
	jsl rlDMAByPointer

	ply
	plx
	plp
	plb
	rtl

rlDrawPortraitSprite ; 8C/C49B

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
	phy
	phy

	asl a
	tay
	asl a
	asl a
	sta wR2

	lda <>_aSpriteBase,b,y
	sta wR4

	lda <>_aAttributeBase,b,y
	sta wR5

	pla
	asl a
	clc
	adc wR2
	tay
	lda <>_aSpriteTable,b,y
	tay
	jsl rlPushToOAMBuffer

	ply
	plx
	plp
	plb
	rtl

	_aSpriteBase ; 8C/C4C5
		.word $0180
		.word $01C0
		.word $0000
		.word $0040

	_aAttributeBase ; 8C/C4CD
		.word $3400
		.word $3600
		.word $3000
		.word $3200

	_aSpriteTable ; 8C/C4D5
		.addr _Sprite4
		.addr _Sprite4
		.addr _Sprite5
		.addr _Sprite6
		.addr _Sprite1
		.addr _Sprite1
		.addr _Sprite2
		.addr _Sprite3
		.addr _Sprite4
		.addr _Sprite4
		.addr _Sprite5
		.addr _Sprite6
		.addr _Sprite1
		.addr _Sprite1
		.addr _Sprite2
		.addr _Sprite3

	_Sprite1 .dstruct structSpriteArray, [[[0, 0], $42, true, $00, 0, 0, false, false], [[16, 0], $42, true, $02, 0, 0, false, false], [[32, 0], $42, true, $04, 0, 0, false, false], [[0, 16], $42, true, $20, 0, 0, false, false], [[16, 16], $42, true, $22, 0, 0, false, false], [[32, 16], $42, true, $24, 0, 0, false, false], [[0, 32], $42, true, $06, 0, 0, false, false], [[16, 32], $42, true, $08, 0, 0, false, false], [[32, 32], $42, true, $0A, 0, 0, false, false], [[0, 48], $42, true, $26, 0, 0, false, false], [[16, 48], $42, true, $28, 0, 0, false, false], [[32, 48], $42, true, $2A, 0, 0, false, false]]
	_Sprite2 .dstruct structSpriteArray, [[[0, 0], $42, true, $00, 0, 0, false, false], [[16, 0], $42, true, $02, 0, 0, false, false], [[32, 0], $42, true, $04, 0, 0, false, false], [[0, 16], $42, true, $20, 0, 0, false, false], [[16, 16], $42, true, $22, 0, 0, false, false], [[32, 16], $42, true, $24, 0, 0, false, false], [[0, 32], $42, true, $0C, 0, 0, false, false], [[16, 32], $42, true, $0E, 0, 0, false, false], [[32, 32], $42, true, $0A, 0, 0, false, false], [[0, 48], $42, true, $26, 0, 0, false, false], [[16, 48], $42, true, $28, 0, 0, false, false], [[32, 48], $42, true, $2A, 0, 0, false, false]]
	_Sprite3 .dstruct structSpriteArray, [[[0, 0], $42, true, $00, 0, 0, false, false], [[16, 0], $42, true, $02, 0, 0, false, false], [[32, 0], $42, true, $04, 0, 0, false, false], [[0, 16], $42, true, $20, 0, 0, false, false], [[16, 16], $42, true, $22, 0, 0, false, false], [[32, 16], $42, true, $24, 0, 0, false, false], [[0, 32], $42, true, $2C, 0, 0, false, false], [[16, 32], $42, true, $2E, 0, 0, false, false], [[32, 32], $42, true, $0A, 0, 0, false, false], [[0, 48], $42, true, $26, 0, 0, false, false], [[16, 48], $42, true, $28, 0, 0, false, false], [[32, 48], $42, true, $2A, 0, 0, false, false]]
	_Sprite4 .dstruct structSpriteArray, [[[0, 0], $42, true, $04, 0, 0, true, false], [[16, 0], $42, true, $02, 0, 0, true, false], [[32, 0], $42, true, $00, 0, 0, true, false], [[0, 16], $42, true, $24, 0, 0, true, false], [[16, 16], $42, true, $22, 0, 0, true, false], [[32, 16], $42, true, $20, 0, 0, true, false], [[0, 32], $42, true, $0A, 0, 0, true, false], [[16, 32], $42, true, $08, 0, 0, true, false], [[32, 32], $42, true, $06, 0, 0, true, false], [[0, 48], $42, true, $2A, 0, 0, true, false], [[16, 48], $42, true, $28, 0, 0, true, false], [[32, 48], $42, true, $26, 0, 0, true, false]]
	_Sprite5 .dstruct structSpriteArray, [[[0, 0], $42, true, $04, 0, 0, true, false], [[16, 0], $42, true, $02, 0, 0, true, false], [[32, 0], $42, true, $00, 0, 0, true, false], [[0, 16], $42, true, $24, 0, 0, true, false], [[16, 16], $42, true, $22, 0, 0, true, false], [[32, 16], $42, true, $20, 0, 0, true, false], [[0, 32], $42, true, $0A, 0, 0, true, false], [[16, 32], $42, true, $0E, 0, 0, true, false], [[32, 32], $42, true, $0C, 0, 0, true, false], [[0, 48], $42, true, $2A, 0, 0, true, false], [[16, 48], $42, true, $28, 0, 0, true, false], [[32, 48], $42, true, $26, 0, 0, true, false]]
	_Sprite6 .dstruct structSpriteArray, [[[0, 0], $42, true, $04, 0, 0, true, false], [[16, 0], $42, true, $02, 0, 0, true, false], [[32, 0], $42, true, $00, 0, 0, true, false], [[0, 16], $42, true, $24, 0, 0, true, false], [[16, 16], $42, true, $22, 0, 0, true, false], [[32, 16], $42, true, $20, 0, 0, true, false], [[0, 32], $42, true, $0A, 0, 0, true, false], [[16, 32], $42, true, $2E, 0, 0, true, false], [[32, 32], $42, true, $2C, 0, 0, true, false], [[0, 48], $42, true, $2A, 0, 0, true, false], [[16, 48], $42, true, $28, 0, 0, true, false], [[32, 48], $42, true, $26, 0, 0, true, false]]

rlUnknown8CC669 ; 8C/C669

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0000
	jsr rsUnknown8CC6A8
	rtl

rlUnknown8CC670 ; 8C/C670

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0003
	jsr rsUnknown8CC6A8
	rtl

rlUnknown8CC677 ; 8C/C677

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0006
	jsr rsUnknown8CC6BA
	lda #(`$7EC9BC)<<8
	sta lR19+1
	lda #<>$7EC9BC
	sta lR19
	jsl rlAppendDecompList
	rtl

rlUnknown8CC68C ; 8C/C68C

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$0009
	jsr rsUnknown8CC6BA
	lda #(`$7ED9BC)<<8
	sta lR19+1
	lda #<>$7ED9BC
	sta lR19
	jsl rlAppendDecompList
	rtl

rlUnknown8CC6A1 ; 8C/C6A1

	.al
	.xl
	.autsiz
	.databank ?

	ldy #$000C
	jsr rsUnknown8CC6A8
	rtl

rsUnknown8CC6A8 ; 8C/C6A8

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown8CC6BA
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	rts

rsUnknown8CC6BA ; 8C/C6BA

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

	lda wEventEngineParameter1,b
	dec a
	asl a
	tay
	lda <>_aUnknown8CC6DC,b,y
	sta wR0

	pla
	clc
	adc wR0
	tay
	lda $0000,b,y
	sta lR18
	lda $0001,b,y
	sta lR18+1

	plp
	plb
	rts

	_aUnknown8CC6DC ; 8C/C6DC
		.addr _aUnknown8CC6E6
		.addr _aUnknown8CC6F5
		.addr _aUnknown8CC704
		.addr _aUnknown8CC713
		.addr _aUnknown8CC722

	_aUnknown8CC6E6 ; 8C/C6E6
		.long $F08DBF
		.long $F09E49
		.long $F0A57F
		.long $F0A6AE
		.long $F0A773

	_aUnknown8CC6F5 ; 8C/C6F5
		.long $F0A7F5
		.long $F0B31C
		.long $F0B899
		.long $F0BA58
		.long $F0BB0E

	_aUnknown8CC704 ; 8C/C704
		.long $F0BB7F
		.long $F0D14E
		.long $F0E95C
		.long $F0EAD0
		.long $F0EBD6

	_aUnknown8CC713 ; 8C/C713
		.long $BF8887
		.long $F09E49
		.long $BF9A2B
		.long $F0A6AE
		.long $BF9BD6

	_aUnknown8CC722 ; 8C/C722
		.long $F08DBF
		.long $F09E49
		.long $F0A57F
		.long $F0A6AE
		.long $F0A773

rlASMCPrepActiveUnitPortrait ; 8C/C731

	.al
	.xl
	.autsiz
	.databank ?

	lda aSelectedCharacterBuffer.Character,b
	jsl rlGetPortraitIndex

	sta $7E4596
	clc
	rtl

rlASMCFinalChapterFadeToWhite ; 8C/C73E

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`_aUnknown8CC778)<<8
	sta wProcInput0+1,b
	lda #<>_aUnknown8CC778
	sta wProcInput0,b
	phx
	lda #(`$8EEC55)<<8
	sta lR43+1
	lda #<>$8EEC55
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive

	plx
	lda #(`_aUnknown8CC782)<<8
	sta wProcInput0+1,b
	lda #<>_aUnknown8CC782
	sta wProcInput0,b
	phx
	lda #(`$8EEC55)<<8
	sta lR43+1
	lda #<>$8EEC55
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive

	plx
	clc
	rtl

	_aUnknown8CC778 ; 8C/C778
		.word $0000
		.word $B4F3
		.word $8090
		.word $4000
		.word $0000

	_aUnknown8CC782 ; 8C/C782
		.word $0080
		.word $B4F3
		.word $8090
		.word $4000
		.word $0000

rlASMCDialogueWithBGEndFadeOut ; 8C/C78C

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda #(`procDialogueWithBG)<<8
	sta lR43+1
	lda #<>procDialogueWithBG
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	+
	plx
	phx
	lda #(`aDialogueBoxHDMAInfo)<<8
	sta lR43+1
	lda #<>aDialogueBoxHDMAInfo
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	+
	plx
	phx
	lda #(`procPortrait0)<<8
	sta lR43+1
	lda #<>procPortrait0
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	+
	plx
	phx
	lda #(`procPortrait1)<<8
	sta lR43+1
	lda #<>procPortrait1
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	txa
	lsr a
	jsl rlProcEngineDeleteProcByIndex

	+
	plx
	jsl $958127
	lda #$0006
	jsl rlHDMAArrayEngineFreeEntryByIndex
	clc
	rtl

rlGetPortraitIndex ; 8C/C7F9

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
	phy

	ldx wR0
	phx
	ldx wR1
	phx

	jsl $83941A
	lda aCharacterDataBuffer.Portrait
	and #$00FF
	cmp #$00FF
	blt +

	lda #DefaultPortrait

	+
	cmp #Myrmidon10Portrait+1
	blt +

	lda #DefaultPortrait

	+
	plx
	stx wR1
	plx
	stx wR0

	ply
	plx
	plp
	plb
	rtl

rlGetActiveSpeakerAssociation ; 8C/C82B

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	pha

	lda #(`aActiveSpeakerAssociationTable)<<8
	sta lR18+1
	lda #<>aActiveSpeakerAssociationTable
	sta lR18
	pla
	jsl rlFindWordCharTableEntry

	plp
	plb
	rtl

.include "../TABLES/ActiveSpeakerAssociationTable.asm"

rlGetTilesetFadePalettePointer ; 8C/C9D2

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
	phy
	lda wCurrentChapter,b
	cmp #ChapterUnknown+1
	blt +

	lda #Chapter1

	+
	sta wR0
	asl a
	clc
	adc wR0
	tay
	lda <>aChapterTilesetFadePaletteTable,b,y
	sta lR18
	lda <>aChapterTilesetFadePaletteTable+1,b,y
	sta lR18+1
	ply
	plx
	plp
	plb
	rtl

.include "../TABLES/ChapterTilesetFadePaletteTable.asm"

rlGetWorldMapEventPointer ; 8C/CA65

	.al
	.xl
	.autsiz
	.databank ?

	lda wCurrentChapter,b

	phb
	php

	phk
	plb

	.databank `*

	phx
	phy
	ldx wR0
	phx
	sta wR0
	asl a
	clc
	adc wR0
	tax
	lda @l aWorldMapEventPointers,x
	sta lR18
	lda @l aWorldMapEventPointers+1,x
	sta lR18+1
	plx
	stx wR0
	ply
	plx
	plp
	plb
	rtl

rlUnknown8CCA8C ; 8C/CA8C

	.al
	.xl
	.autsiz
	.databank ?

	jsl $95800B

	lda #$2000
	sta wUnknown001804,b

	lda #$01DF
	sta wUnknown001802,b

	lda #$5000
	sta $7E45B8

	lda #$5C00
	sta $7E45BF

	lda #$6140
	sta $7E45D8

	lda #$061C
	sta $7E45C3

	lda #$061C
	sta $7E45DC

	lda #$E802
	sta $7E45BC

	lda #$ECC2
	sta $7E45D5

	lda #$0014
	sta wUnknown0017F7,b

	rtl

rlASMCWorldMapDialogue ; 8C/CAD4

	.al
	.xl
	.autsiz
	.databank ?

	lda lEventEngineLongParameter+1,b
	sta lR18+1
	lda lEventEngineLongParameter,b
	sta lR18

	lda lR18
	pha
	lda lR18+1
	pha

	jsl rlUnknown8CCA8C

	pla
	sta lR18+1
	pla
	sta lR18

	jsl $958141
	jsl $958109

	lda #$041E
	sta $7E45C3

	lda #$ED40
	sta $7E45BC

	lda #$0002
	sta wUnknown001800,b

	lda #$0180
	tsb wUnknown0017E9,b

	lda #$0000
	sta @l wUnknown001836

	lda #$02D0
	sta wUnknown001802,b

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, _BlankTile, size(_BlankTile), VMAIN_Setting(True), $CD00

	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0800
	sta lR19
	lda #$02D0
	jsl rlBlockFillWord
	rtl

	_BlankTile .fill $10

rlUnknown8CCB51 ; 8C/CB51

	.al
	.xl
	.autsiz
	.databank ?

	jsl $958233
	jsl $95882A
	jsl rlUpdateOnePositionDialogueArrow
	rtl

rlUpdateOnePositionDialogueArrow ; 8C/CB5E

	.al
	.xl
	.autsiz
	.databank ?

	lda #232
	sta wR0
	lda #208
	sta wR1
	bra rlUpdateDialogueArrow

rlUpdateTwoPositionDialogueArrow ; 8C/CB6A

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001808,b
	beq +

	lda #$0001

	+
	asl a
	asl a
	tax
	lda _aArrowCoordinateTable,x
	sta wR0
	lda _aArrowCoordinateTable+2,x
	sta wR1
	bra rlUpdateDialogueArrow

	_aArrowCoordinateTable ; 8C/CB83
		.word 120
		.word 64

		.word 120
		.word 216

rlUpdateDialogueArrow ; 8C/CB8B

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0004
	bit wUnknown0017E9,b
	beq +

	phx
	lda #(`$83CB78)<<8
	sta lR43+1
	lda #<>$83CB78
	sta lR43
	jsl rlProcEngineFindProc
	plx
	bcs ++

	jsl $83CB53
	bra ++

	+
	phx
	lda #(`$83CB78)<<8
	sta lR43+1
	lda #<>$83CB78
	sta lR43
	jsl rlProcEngineFindProc
	plx
	bcc +

	jsl $83CB94

	+
	rtl

rlUnknown8CCBC2 ; 8C/CBC2

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown8C9D3F

	lda lEventEngineLongParameter,b
	beq +

	lda #(`eventMapDeathQuoteHandler)<<8
	sta lR18+1
	lda #<>eventMapDeathQuoteHandler
	sta lR18
	jsl rlUnknown8C839F

	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlUnknown8CCBE0 ; 8C/CBE0

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown8C9CED
	lda lEventEngineLongParameter,b
	beq +

	lda #(`eventMapBattleQuoteHandler)<<8
	sta lR18+1
	lda #<>eventMapBattleQuoteHandler
	sta lR18
	jsl rlUnknown8C839F
	lda #$2000
	tsb wEventEngineStatus,b

	+
	rtl

rlGetDeathQuoteDialogue ; 8C/CBFE

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterStructParameter,b
	sta wR0
	jsl rlGetDeathQuoteDialoguePointer
	jsl $9590A1
	clc
	rtl

rlGetBattleQuoteDialogue ; 8C/CC0D

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterStructParameter,b
	sta wR0
	jsl rlGetBattleQuoteDialoguePointer
	jsl $9590A1
	clc
	rtl

rlGetReleaseQuoteDialogue ; 8C/CC1C

	.al
	.xl
	.autsiz
	.databank ?

	lda wEventEngineCharacterStructParameter,b
	sta wR0
	jsl rlGetReleaseQuoteDialoguePointer
	bcs +

	jsl $9590A1

	+
	clc
	rtl

rlUnknown8CCC2D ; 8C/CC2D

	.al
	.xl
	.autsiz
	.databank ?

	lda aSelectedCharacterBuffer.Character,b
	sta wEventEngineCharacterStructParameter,b
	lda wEventEngineCharacterStructParameter,b
	sta wR0
	lda lEventEngineLongParameter,b
	sta lR19
	lda lEventEngineLongParameter+1,b
	sta lR19+1
	jsr rsUnknown8CCC85
	clc
	rtl

rlGetDeathQuoteDialoguePointer ; 8C/CC47

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aDeathQuoteTable)<<8
	sta lR19+1
	lda #<>aDeathQuoteTable
	sta lR19
	jsr rsFindQuoteTableEntry

	lda lR18+1
	sta lEventEngineLongParameter+1,b
	lda lR18
	sta lEventEngineLongParameter,b
	rtl

rlGetBattleQuoteDialoguePointer ; 8C/CC5F

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aBattleQuoteTable)<<8
	sta lR19+1
	lda #<>aBattleQuoteTable
	sta lR19
	jsr rsFindQuoteTableEntry

	lda lR18+1
	sta lEventEngineLongParameter+1,b
	lda lR18
	sta lEventEngineLongParameter,b
	rtl

rlGetReleaseQuoteDialoguePointer ; 8C/CC77

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aReleaseQuoteTable)<<8
	sta lR19+1
	lda #<>aReleaseQuoteTable
	sta lR19
	jsr rsFindQuoteTableEntry
	rtl

rsUnknown8CCC85 ; 8C/CC85

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsFindQuoteTableEntry
	bcc +

	lda #(`dialogueUnknown8CCC99)<<8
	sta lR18+1
	lda #<>dialogueUnknown8CCC99
	sta lR18

	+
	jsl $9590A1
	rts

dialogueUnknown8CCC99 ; 8C/CC99
DIALOGUE_END_SCENE

rsFindQuoteTableEntry ; 8C/CC9A

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy

	lda #$0000
	sta lR18
	lda #$0000
	sta lR18+1

	ldy #$0000

	-
	lda [lR19],y
	sta wR1
	inc y
	inc y

	lda [lR19],y
	and #$00FF
	sta wR2
	inc y

	lda wR1
	beq _True
	cmp #$FFFF
	beq +

	cmp wR0
	bne _Next

	+
	lda wR2
	cmp #$00FF
	beq +

	cmp wCurrentChapter,b
	bne _Next

	+
	lda [lR19],y
	and #$00FF
	beq +

	jsl rlSetEventFlag

	+
	inc y
	lda [lR19],y
	beq _True

	sta lR18
	inc y
	lda [lR19],y
	sta lR18+1
	bra _False

	_Next
	inc y
	inc y
	inc y
	inc y
	bra -

	_True
	ply
	plx
	plp
	sec
	rts

	_False
	ply
	plx
	plp
	clc
	rts

rsCheckEventEndCodeTable ; 8C/CCFA

	.al
	.xl
	.autsiz
	.databank ?

	phy
	ldy wR0
	phy

	and #$00FF
	sta wR0

	ldy #$0000

	-
	lda [lR18],y
	and #$00FF
	bne +
	inc y

	lda [lR18],y
	and #$00FF
	beq _False
	dec y

	+
	cmp wR0
	bne _Next

	inc y
	lda [lR18],y
	and #$00FF
	sec
	bra _End

	_Next
	inc y
	inc y
	bra -

	_False
	clc

	_End
	ply
	sty wR0
	ply
	rtl

rlFindByteCharTableEntry ; 8C/CD2D

	.al
	.xl
	.autsiz
	.databank ?

	phy
	ldy wR0
	phy
	sta wR0

	ldy #$0000

	-
	lda [lR18],y
	bne +

	inc y
	inc y

	lda [lR18],y
	beq _False

	dec y
	dec y

	+
	cmp wR0
	bne _Next

	inc y
	inc y

	lda [lR18],y
	and #$00FF
	sec
	bra _End

	_Next
	inc y
	inc y
	inc y
	bra -

	_False
	clc

	_End
	ply
	sty wR0
	ply
	rtl

rlFindWordCharTableEntry ; 8C/CD5B

	.al
	.xl
	.autsiz
	.databank ?

	phy
	ldy wR0
	phy
	sta wR0

	ldy #$0000

	-
	lda [lR18],y
	bne +

	inc y
	inc y
	lda [lR18],y
	beq _False

	dec y
	dec y

	+
	cmp wR0
	bne _Next

	inc y
	inc y
	lda [lR18],y
	sec
	bra _End

	_Next
	inc y
	inc y
	inc y
	inc y
	bra -

	_False
	clc

	_End
	ply
	sty wR0
	ply
	rtl

rlASMCClearOlwenWinsLosses ; 8C/CD87

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda #Olwen
	jsl rlGetCharacterWinLossTableOffset
	bcs +

	tax
	sep #$20
	lda #$00
	sta aWinsTable,x
	sta aLossesTable,x

	+
	jsl rlUpdateSaveSlotLosses
	plp
	clc
	rtl

rlUnknown8CCDA5 ; 8C/CDA5

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, g4bppUnknown8CCDB9, size(g4bppUnknown8CCDB9), VMAIN_Setting(True), $2800

	plx
	lda #$4000
	bra rlUnknown8CCE1C

g4bppUnknown8CCDB9 .binary "../GFX/Unknown8CCDB9.4bpp" ; 8C/CDB9

rlUnknown8CCE19 ; 8C/CE19

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000

rlUnknown8CCE1C ; 8C/CE1C

	.al
	.xl
	.autsiz
	.databank ?

	ora #$000C
	sta wR2

	lda #$0000
	sta @l wUnknown0017DF

	lda @l wEventEngineXCoordinate
	sta wR3

	lda @l wEventEngineYCoordinate
	ora wR3
	beq _End

	lda wR2
	sta @l wUnknown0017DF

	lda wR1
	bne +

	lda @l wUnknown0017DF
	ora #$2000
	sta @l wUnknown0017DF

	+
	phb
	php

	phk
	plb

	.databank `*

	phx
	lda @l wEventEngineXCoordinate
	ldx #$0000
	jsr rsUnknown8CCE68

	lda @l wEventEngineYCoordinate
	ldx #$0002
	jsr rsUnknown8CCE68

	plx
	plp
	plb

	_End
	rtl

rsUnknown8CCE68 ; 8C/CE68

	.al
	.xl
	.autsiz
	.databank ?

	ldy wR0
	phy
	ldy wR1
	phy

	txy
	asl a
	asl a
	asl a
	asl a
	sta wR2
	sta @l aUnknown0017E1,x

	lda @l wUnknown0017DF
	bit #$2000
	bne +

	inc y
	inc y
	inc y
	inc y

	+
	lda @l wUnknown0017DF
	bit #$4000
	bne +

	lda <>_aUnknown8CCEDB,b,y
	sta @l aUnknown0017E1,x

	+
	lda <>_aUnknown8CCEDB,b,y
	sec
	sbc wR2
	php
	bpl +

	eor #$FFFF
	inc a

	+
	xba
	sta wR13
	lda #11
	sta wR14
	phx
	jsl rlUnsignedDivide16By16

	plx
	plp
	ror a
	ror a
	eor @l wUnknown0017DF
	bit #$4000
	beq +

	lda wR13
	eor #$FFFF
	inc a
	sta wR13

	+
	lda wR13
	sta @l aUnknown0017E5,x

	lda @l aUnknown0017E1,x
	xba
	sta @l aUnknown0017E1,x

	ply
	sty wR1
	ply
	sty wR0
	rts

	_aUnknown8CCEDB ; 8C/CEDB
		.word $0008
		.word $0008
		.word $0008
		.word $0098

rlUnknown8CCEE3 ; 8C/CEE3

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

	lda @l wUnknown0017DF
	beq _End

	lda @l aUnknown0017E1
	xba
	and #$00FF
	sta lR24

	lda @l aUnknown0017E1+2
	xba
	and #$00FF
	sta lR25

	jsr rlUnknown8CCF3C

	lda @l aUnknown0017E1
	clc
	adc @l aUnknown0017E5
	sta @l aUnknown0017E1

	lda @l aUnknown0017E1+2
	clc
	adc @l aUnknown0017E5+2
	sta @l aUnknown0017E1+2

	lda @l wUnknown0017DF
	and #$00FF
	dec a
	beq +

	sta wR0
	lda @l wUnknown0017DF
	and #$FF00
	ora wR0

	+
	sta @l wUnknown0017DF

	_End
	plx
	plp
	plb
	rtl

rlUnknown8CCF3C ; 8C/CF3C

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
	phy

	ldx #$0002
	jsr rsUnknown8CD091
	sta lR19

	ldx #$0000
	jsr rsUnknown8CD091
	sta lR18

	lda lR19
	cmp #$0005
	bcs +

	lda lR19
	sta lR18

	+
	lda lR24
	sta wR0

	lda lR25
	sta wR1

	ldy #<>aSpriteUnknown8CD03E
	jsr rsUnknown8CD076

	lda lR24
	clc
	adc lR18
	adc #$0008
	sta wR0

	lda lR25
	sta wR1

	ldy #<>aSpriteUnknown8CD045
	jsr rsUnknown8CD076

	lda lR24
	sta wR0

	lda lR25
	clc
	adc lR19
	adc #$0008
	sta wR1

	ldy #<>aSpriteUnknown8CD04C
	jsr rsUnknown8CD076

	lda lR24
	clc
	adc lR18
	adc #$0008
	sta wR0

	lda lR25
	clc
	adc lR19
	adc #$0008
	sta wR1

	ldy #<>aSpriteUnknown8CD053
	jsr rsUnknown8CD076

	ldy #<>aSpriteUnknown8CD05A
	lda lR24
	clc
	adc #$0008
	sta wR0

	lda lR25
	sta wR1

	lda lR18
	jsr rsUnknown8CD00E

	ldy #<>aSpriteUnknown8CD068
	lda lR24
	sta wR0

	lda lR25
	clc
	adc #$0008
	sta wR1

	lda lR19
	jsr rsUnknown8CD026

	ldy #<>aSpriteUnknown8CD061
	lda lR24
	clc
	adc #$0008
	sta wR0

	lda lR25
	clc
	adc lR19
	adc #$0008
	sta wR1

	lda lR18
	jsr rsUnknown8CD00E

	ldy #<>aSpriteUnknown8CD06F
	lda lR24
	clc
	adc lR18
	adc #$0008
	sta wR0

	lda lR25
	clc
	adc #$0008
	sta wR1

	lda lR19
	jsr rsUnknown8CD026

	ply
	plx
	plp
	plb
	rts

rsUnknown8CD00E ; 8C/D00E

	.al
	.xl
	.autsiz
	.databank ?

	beq _End

	lsr a
	lsr a
	lsr a

	-
	pha
	phy
	jsr rsUnknown8CD076
	ply
	lda wR0
	clc
	adc #$0008
	sta wR0
	pla
	dec a
	bpl -

	_End
	rts

rsUnknown8CD026 ; 8C/D026

	.al
	.xl
	.autsiz
	.databank ?

	beq _End

	lsr a
	lsr a
	lsr a

	-
	pha
	phy
	jsr rsUnknown8CD076
	ply
	lda wR1
	clc
	adc #$0008
	sta wR1
	pla
	dec a
	bpl -

	_End
	rts

aSpriteUnknown8CD03E .dstruct structSpriteArray, [[[0, 0], $00, false, $140, 0, 0, false, false]]
aSpriteUnknown8CD045 .dstruct structSpriteArray, [[[0, 0], $00, false, $140, 0, 0, true, false]]
aSpriteUnknown8CD04C .dstruct structSpriteArray, [[[0, 0], $00, false, $140, 0, 0, false, true]]
aSpriteUnknown8CD053 .dstruct structSpriteArray, [[[0, 0], $00, false, $140, 0, 0, true, true]]
aSpriteUnknown8CD05A .dstruct structSpriteArray, [[[0, 0], $00, false, $141, 0, 0, false, false]]
aSpriteUnknown8CD061 .dstruct structSpriteArray, [[[0, 0], $00, false, $141, 0, 0, false, true]]
aSpriteUnknown8CD068 .dstruct structSpriteArray, [[[0, 0], $00, false, $142, 0, 0, false, false]]
aSpriteUnknown8CD06F .dstruct structSpriteArray, [[[0, 0], $00, false, $142, 0, 0, true, false]]

rsUnknown8CD076 ; 8C/D076

	.al
	.xl
	.autsiz
	.databank ?

	lda lR18
	pha
	lda lR19
	pha
	lda #$0000
	sta wR4
	lda #$2000
	sta wR5
	jsl rlPushToOAMBuffer
	pla
	sta lR19
	pla
	sta lR18
	rts

rsUnknown8CD091 ; 8C/D091

	.al
	.xl
	.autsiz
	.databank ?

	lda @l wUnknown0017DF
	bit #$4000
	php
	lda @l wUnknown0017DF
	and #$00FF
	plp
	beq +

	sta wR0
	lda #13
	sec
	sbc wR0

	+
	sta wR10
	lda <>_aUnknown8CD0BF,b,x
	sta wR11
	phx
	jsl rlUnsignedMultiply16By16
	plx
	lda wR12
	xba
	and #$00FF
	rts

	_aUnknown8CD0BF ; 8C/D0BF
		.word $1400
		.word $0400

rlASMCDialogueWithBGStart ; 8C/D0C3

	.al
	.xl
	.autsiz
	.databank ?

	lda lR18
	sta wProcInput0,b
	lda lR18+1
	sta wProcInput1,b
	phx

	lda #(`procDialogueWithBG)<<8
	sta lR43+1
	lda #<>procDialogueWithBG
	sta lR43
	jsl rlEventEngineCreateProcAndSetActive

	plx
	lda #$0004
	trb wEventEngineStatus,b

	clc
	rtl

rlASMCDialogueWithBGEnd ;8C/D0E5

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0004
	tsb wEventEngineStatus,b
	clc
	rtl

rlASMCChangeMapMusic ; 8C/D0ED

	.al
	.xl
	.autsiz
	.databank ?

	lda lR18
	cmp wCurrentMapMusic,b
	beq +

	sta wCurrentMapMusic,b
	sta aUnknown0004BA,b

	+
	rtl

rlASMCDialogueWithBGSetup ; 8C/D0FB

	.al
	.xl
	.autsiz
	.databank ?

	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rlGetMapSpriteIndex ; 8C/D10D

	.al
	.xl
	.autsiz
	.databank ?

	; Index in A

	phb
	php

	phk
	plb

	.databank `*

	phx

	; Mounted sprites have their upper bit set

	bit #$0080
	beq _SkipMounted

	; Clear upper bit and add start of tall table

	and #$007F
	clc
	adc #($86E3F8 - $86E3AD)

	_SkipMounted

	; Get actual index

	tax
	lda $86E3AD,x
	and #$00FF
	plx
	plp
	plb
	rtl



