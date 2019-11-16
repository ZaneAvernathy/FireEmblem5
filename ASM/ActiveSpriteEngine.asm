
aActiveSpriteEngineMainActionTable ; 81/8000
	.addr rlActiveSpriteEngineReset
	.addr rlActiveSpriteEngineMainLoop
	.addr rlActiveSpriteEngineStub

rsUnknown818006 ; 81/8006

	.autsiz
	.databank ?

	rts

rlActiveSpriteEngineStub ; 81/8007

	.autsiz
	.databank ?

	rtl

rlActiveSpriteEngineSwap ; 81/8008

	.autsiz
	.databank ?

	; Swaps two entries using a whole lot of
	; pushing/pulling

	; Inputs:
	; X: Entry index
	; Y: Entry index

	; Outputs:
	; None

	php
	rep #$30

	; Push X, Y->X, pull into Y

	lda aUnknown00161B,b,x
	pha
	lda aUnknown00163B,b,x
	pha

	lda aUnknown00161B,b,y
	sta aUnknown00161B,b,x

	lda aUnknown00163B,b,y
	sta aUnknown00163B,b,x

	pla
	sta aUnknown00163B,b,y
	pla
	sta aUnknown00161B,b,y

	lda aActiveSpriteTypeOffset,b,x
	pha
	lda aActiveSpriteBanks,b,x
	pha
	lda aActiveSpriteRenderer,b,x
	pha
	lda aActiveSpriteUpdater,b,x
	pha
	lda aActiveSpriteOnCycle,b,x
	pha
	lda aActiveSpriteFrameTimer,b,x
	pha
	lda aActiveSpriteCodeOffset,b,x
	pha
	lda aActiveSpriteFrameOffset,b,x
	pha
	lda aUnknown000864,b,x
	pha
	lda aActiveSpritexCoordinate,b,x
	pha
	lda aUnknown0008A4,b,x
	pha
	lda aActiveSpriteyCoordinate,b,x
	pha
	lda aActiveSpriteSpriteBase,b,x
	pha
	lda aUnknown000904,b,x
	pha
	lda aActiveSpritePalette,b,x
	pha
	lda aUnknown000944,b,x
	pha
	lda aUnknown000964,b,x
	pha
	lda aUnknown000984,b,x
	pha
	lda aUnknown0009A4,b,x
	pha
	lda aUnknown0009C4,b,x
	pha
	lda aUnknown0009E4,b,x
	pha
	lda aUnknown000A04,b,x
	pha
	lda aUnknown000A24,b,x
	pha
	lda aUnknown000A44,b,x
	pha
	lda aUnknown000A64,b,x
	pha

	lda aActiveSpriteTypeOffset,b,y
	sta aActiveSpriteTypeOffset,b,x
	lda aActiveSpriteBanks,b,y
	sta aActiveSpriteBanks,b,x
	lda aActiveSpriteRenderer,b,y
	sta aActiveSpriteRenderer,b,x
	lda aActiveSpriteUpdater,b,y
	sta aActiveSpriteUpdater,b,x
	lda aActiveSpriteOnCycle,b,y
	sta aActiveSpriteOnCycle,b,x
	lda aActiveSpriteFrameTimer,b,y
	sta aActiveSpriteFrameTimer,b,x
	lda aActiveSpriteCodeOffset,b,y
	sta aActiveSpriteCodeOffset,b,x
	lda aActiveSpriteFrameOffset,b,y
	sta aActiveSpriteFrameOffset,b,x
	lda aUnknown000864,b,y
	sta aUnknown000864,b,x
	lda aActiveSpritexCoordinate,b,y
	sta aActiveSpritexCoordinate,b,x
	lda aUnknown0008A4,b,y
	sta aUnknown0008A4,b,x
	lda aActiveSpriteyCoordinate,b,y
	sta aActiveSpriteyCoordinate,b,x
	lda aActiveSpriteSpriteBase,b,y
	sta aActiveSpriteSpriteBase,b,x
	lda aUnknown000904,b,y
	sta aUnknown000904,b,x
	lda aActiveSpritePalette,b,y
	sta aActiveSpritePalette,b,x
	lda aUnknown000944,b,y
	sta aUnknown000944,b,x
	lda aUnknown000964,b,y
	sta aUnknown000964,b,x
	lda aUnknown000984,b,y
	sta aUnknown000984,b,x
	lda aUnknown0009A4,b,y
	sta aUnknown0009A4,b,x
	lda aUnknown0009C4,b,y
	sta aUnknown0009C4,b,x
	lda aUnknown0009E4,b,y
	sta aUnknown0009E4,b,x
	lda aUnknown000A04,b,y
	sta aUnknown000A04,b,x
	lda aUnknown000A24,b,y
	sta aUnknown000A24,b,x
	lda aUnknown000A44,b,y
	sta aUnknown000A44,b,x
	lda aUnknown000A64,b,y
	sta aUnknown000A64,b,x

	pla
	sta aUnknown000A64,b,y
	pla
	sta aUnknown000A44,b,y
	pla
	sta aUnknown000A24,b,y
	pla
	sta aUnknown000A04,b,y
	pla
	sta aUnknown0009E4,b,y
	pla
	sta aUnknown0009C4,b,y
	pla
	sta aUnknown0009A4,b,y
	pla
	sta aUnknown000984,b,y
	pla
	sta aUnknown000964,b,y
	pla
	sta aUnknown000944,b,y
	pla
	sta aActiveSpritePalette,b,y
	pla
	sta aUnknown000904,b,y
	pla
	sta aActiveSpriteSpriteBase,b,y
	pla
	sta aActiveSpriteyCoordinate,b,y
	pla
	sta aUnknown0008A4,b,y
	pla
	sta aActiveSpritexCoordinate,b,y
	pla
	sta aUnknown000864,b,y
	pla
	sta aActiveSpriteFrameOffset,b,y
	pla
	sta aActiveSpriteCodeOffset,b,y
	pla
	sta aActiveSpriteFrameTimer,b,y
	pla
	sta aActiveSpriteOnCycle,b,y
	pla
	sta aActiveSpriteUpdater,b,y
	pla
	sta aActiveSpriteRenderer,b,y
	pla
	sta aActiveSpriteBanks,b,y
	pla
	sta aActiveSpriteTypeOffset,b,y

	plp
	rtl

rlActiveSpriteEngineFindEntry ; 81/8187

	.xl
	.autsiz
	.databank ?

	; Finds an entry based on its type and bank

	; Inputs:
	; Long pointer to entry in ROM

	; Outputs:
	; Carry set if found, else clear
	; Index of found entry in X if found

	php
	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	rep #$20
	lda aActiveSpriteTypeOffset,b,x
	cmp lR43
	bne +

	sep #$20
	lda aActiveSpriteBanks,b,x
	cmp lR43+2
	rep #$20
	beq ++

	+
	dec x
	dec x
	bpl -

	plp
	clc
	rtl

	+
	plp
	sec
	rtl

rlActiveSpriteEngineReset ; 81/81A9

	.xl
	.autsiz
	.databank ?

	; Clears and resets the active sprite engine

	; Inputs:
	; None

	; Outputs:
	; None

	rep #$20
	ldx #size(aActiveSpriteTypeOffset) - 2
	lda #$0000

	-
	sta aActiveSpriteTypeOffset,b,x
	sta aActiveSpriteSpriteBase,b,x
	sta aUnknown000904,b,x
	sta aActiveSpritePalette,b,x
	dec x
	dec x
	bpl -

	sta wActiveSpriteFlag,b
	sta wUnknownSpriteArraySize,b
	sta wUnknownSpriteArrayCount,b
	lda #(`rlPushToOAMBuffer)<<8
	sta lSpriteRendererPointer+1,b
	lda #<>rlPushToOAMBuffer
	sta lSpriteRendererPointer,b
	rtl

rlEnableActiveSpriteEngine ; 81/81D7

	.autsiz
	.databank ?

	php
	rep #$20
	lda #ActiveSpriteEngineEnabled
	tsb wActiveSpriteFlag,b
	plp
	rtl

rlDisableActiveSpriteEngine ; 81/81E2

	.autsiz
	.databank ?

	php
	rep #$20
	lda #ActiveSpriteEngineEnabled
	trb wActiveSpriteFlag,b
	plp
	rtl

rlActiveSpriteEngineRenderOnScreenOnly ; 81/81ED

	.autsiz
	.databank ?

	php
	rep #$20
	lda #ActiveSpriteEngineRenderOnScreenOnly
	tsb wActiveSpriteFlag,b
	plp
	rtl

rlActiveSpriteEngineRenderAll ; 81/81F8

	.autsiz
	.databank ?

	php
	rep #$20
	lda #ActiveSpriteEngineRenderOnScreenOnly
	trb wActiveSpriteFlag,b
	plp
	rtl

rlUnknown818203 ; 81/8203

	.autsiz
	.databank ?

	php
	rep #$20
	lda #$2000
	tsb wActiveSpriteFlag,b
	plp
	rtl

rlUnknown81820E ; 81/820E

	.autsiz
	.databank ?

	php
	rep #$20
	lda #$2000
	trb wActiveSpriteFlag,b
	plp
	rtl

rlActiveSpriteEngineClearAllSprites ; 81/8219

	.xl
	.autsiz
	.databank ?

	; Frees all active sprite entries

	; Inputs:
	; None

	; Outputs:
	; None

	phx
	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	stz aActiveSpriteTypeOffset,b,x
	dec x
	dec x
	bpl -

	plx
	rtl

rlActiveSpriteEngineClearSpriteByIndex ; 81/8226

	.al
	.autsiz
	.databank ?

	; Given an entry index in X, frees the entry.

	; Inputs:
	; X: Entry index

	; Outputs:
	; None

	lda #$0000
	sta @l aActiveSpriteTypeOffset,x
	rtl

rlUnknown81822E ; 81/822E

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	lda @l aActiveSpriteTypeOffset,x
	bne +

	jmp rlUnknown8182C7

	+
	dec x
	dec x
	bne -

	plx
	ply
	plb
	sec
	rtl

rlUnknown81824B ; 81/824B

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	ldx #$0002

	-
	lda @l aActiveSpriteTypeOffset,x
	beq rlUnknown8182C7

	inc x
	inc x
	cpx #size(aActiveSpriteTypeOffset)
	bmi -

	plx
	ply
	plb
	sec
	rtl

rlUnknown818268 ; 81/8268

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	tax
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	lda @l aActiveSpriteTypeOffset,x
	beq rlUnknown8182C7

	plx
	ply
	plb
	sec
	rtl

rlUnknown81827C ; 81/827C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	lda @l aActiveSpriteTypeOffset,x
	beq rlUnknown8182CD
	dec x
	dec x
	bpl -

	plx
	ply
	plb
	sec
	rtl

rlUnknown818296 ; 81/8296

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	ldx #$0000

	-
	lda @l aActiveSpriteTypeOffset,x
	beq rlUnknown8182CD
	inx
	inx
	cpx #size(aActiveSpriteTypeOffset)
	bmi -

	plx
	ply
	plb
	sec
	rtl

rlUnknown8182B3 ; 81/82B3

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phy
	phx
	tax
	lda lR43+1
	pha
	plb
	plb

	.databank ?

	lda @l aActiveSpriteTypeOffset,x
	beq rlUnknown8182CD

	plx
	ply
	plb
	sec
	rtl

rlUnknown8182C7 ; 81/82C7

	.al
	.xl
	.autsiz
	.databank ?

	lda lR43
	stz lR43
	bra rlCreateActiveSpriteMain

rlUnknown8182CD ; 81/82CD

	.al
	.xl
	.autsiz
	.databank ?

	lda lR43

rlCreateActiveSpriteMain ; 81/82CF

	.al
	.xl
	.autsiz
	.databank ?

	; Creates an active sprite entry

	; Inputs:
	; A: Offset of data
	; lR43: Uppermost byte should be data's bank

	; Outputs:
	; None

	; Store pointer to sprite info

	sta @l aActiveSpriteTypeOffset,x
	tay

	; Store index

	txa
	sta @l wActiveSpriteIndex

	; Store bank of type and renderer

	lda @l lR43+1
	and #$FF00
	sta @l lActiveSpriteCodePointer+1
	xba
	ora #(`rlPushToOAMBuffer)<<8
	sta @l aActiveSpriteBanks,x

	; Store rest of default renderer

	lda #<>rlPushToOAMBuffer
	sta @l aActiveSpriteRenderer,x

	; Store sprite coordinates

	pla
	sta @l aActiveSpritexCoordinate,x
	pla
	sta @l aActiveSpriteyCoordinate,x

	lda $0002,b,y
	clc
	adc lR43
	sta @l aActiveSpriteOnCycle,x
	lda #$0001
	sta @l aActiveSpriteFrameTimer,x
	lda $0004,b,y
	clc
	adc lR43
	sta @l aActiveSpriteCodeOffset,x
	lda #$0000
	sta @l aActiveSpriteFrameOffset,x
	lda #$0000
	sta @l aUnknown000864,x
	sta @l aUnknown0008A4,x
	sta @l aActiveSpriteUpdater,x
	sta @l aActiveSpriteSpriteBase,x
	sta @l aUnknown000904,x
	sta @l aActiveSpritePalette,x
	sta @l aUnknown000944,x
	sta @l aUnknown000964,x
	sta @l aUnknown000984,x
	sta @l aUnknown0009A4,x
	sta @l aUnknown0009C4,x
	sta @l aUnknown0009E4,x
	sta @l aUnknown000A04,x
	sta @l aUnknown000A24,x
	sta @l aUnknown000A44,x
	sta @l aUnknown000A64,x
	sta @l aUnknown00153A,x
	sta @l aUnknown00155A,x

	; Check for init code and run

	lda $0000,b,y
	clc
	adc lR43
	sta @l lActiveSpriteCodePointer
	bpl +

	phk
	pea <>(+)-1
	jmp [lActiveSpriteCodePointer]

	+
	plb
	clc
	rtl

rlActiveSpriteSetRenderer ; 81/8380

	.al
	.xl
	.autsiz
	.databank ?

	; Sets an active sprite's renderer

	; Inputs:
	; X: Active sprite index
	; lR18: Long pointer to renderer

	; Outputs:
	; None

	phx
	lda wR0
	pha

	; Save type's bank

	lda @l aActiveSpriteBanks,x
	and #$00FF
	sta wR0

	; Combine with new renderer's bank

	lda lR18+1
	and #$FF00
	ora wR0

	; Store

	sta @l aActiveSpriteBanks,x

	lda lR18
	sta @l aActiveSpriteRenderer,x

	pla
	sta wR0
	plx
	rtl

rlActiveSpriteEngineMainLoop ; 81/83A3

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	bit wActiveSpriteFlag,b
	bpl _Disabled

	; Check to see if we're actively updating sprites

	lda wActiveSpriteFlag,b
	bit #ActiveSpriteEngineInactive
	bne ++

	; Loop through all active sprites and update them

	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	stx wActiveSpriteIndex,b
	lda aActiveSpriteTypeOffset,b,x
	beq +

	jsr rlRunActiveSpriteOnCycleAndCode

	ldx wActiveSpriteIndex,b

	+
	dec x
	dec x
	bpl -

	+

	; Next check if we're only rendering sprites onscreen

	lda wActiveSpriteFlag,b
	bit #ActiveSpriteEngineRenderOnScreenOnly
	beq _OnScreen

	jsr rsActiveSpriteEngineRenderSprites

	lda wActiveSpriteFlag,b
	bit #$2000
	beq _ProcessUnknown

	; This routine probably used to have more to it
	; but now it just calls the rlProcessUnknownSpriteArray
	; routine.

	jsl rlCallProcessUnknownSpriteArray

	stz wUnknown000C6B,b
	plb
	plp
	rtl

	_OnScreen ; 81/83E8

	.al
	.xl
	.autsiz
	.databank `rlActiveSpriteEngineMainLoop

	jsr rsActiveSpriteEngineRenderSpritesOnScreen

	lda wActiveSpriteFlag,b
	bit #$2000
	beq _ProcessUnknown

	jsl rlCallProcessUnknownSpriteArray

	stz wUnknown000C6B,b
	plb
	plp
	rtl

	_ProcessUnknown ; 81/83FD

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlProcessUnknownSpriteArray

	stz wUnknown000C6B,b
	plb
	plp
	rtl

	_Disabled ; 81/8407

	.al
	.xl
	.autsiz
	.databank ?

	stz wUnknownSpriteArraySize,b
	stz wUnknownSpriteArrayCount,b
	stz wUnknown000C6B,b
	plb
	plp
	rtl

rlRunActiveSpriteOnCycleAndCode ; 81/8413

	.al
	.xl
	.autsiz
	.databank ?

	lda aActiveSpriteBanks-1,b,x
	pha
	plb
	plb

	.databank ?

	; First run the active sprite's on cycle

	jsl rlRunActiveSpriteOnCycle

	ldx wActiveSpriteIndex,b

	; We run the code if the timer has ticked down
	; to 0

	dec aActiveSpriteFrameTimer,b,x
	bne +

	; Next fetch the next code instruction

	ldy aActiveSpriteCodeOffset,b,x
	bpl +

	-
	lda $0000,b,y
	and #$00FF
	asl a
	phx
	tax
	lda aUnknown818455,x
	sta lActiveSpriteCodePointer,b
	plx
	inc y
	pea <>(-)-1

	jmp (<>lActiveSpriteCodePointer)

	+
	rts

rlRunActiveSpriteOnCycle ; 81/8443

	.al
	.xl
	.autsiz
	.databank ?

	lda aActiveSpriteBanks-1,b,x
	sta lActiveSpriteCodePointer+1,b

	lda aActiveSpriteOnCycle,b,x
	sta lActiveSpriteCodePointer,b
	bpl +

	jmp [<>lActiveSpriteCodePointer]

	+
	rtl

aUnknown818455 ; 81/8455
	.addr rsUnknown8187EF
	.addr rsUnknown818825
	.addr rsUnknown8188B0
	.addr rsUnknown8189BD
	.addr rsUnknown818A1A
	.addr rsUnknown818A1E
	.addr rsUnknown818A2E
	.addr rsUnknown818A48
	.addr rsUnknown818A53
	.addr rsUnknown818954
	.addr rsUnknown818960
	.addr rsUnknown818A5E
	.addr rsUnknown818A72
	.addr rsUnknown818A86
	.addr rsUnknown818A8B
	.addr rsUnknown81896C
	.addr rsUnknown818ACF
	.addr rsUnknown818AD6
	.addr rsUnknown81882A
	.addr rsUnknown81883E
	.addr rsUnknown81884B
	.addr rsUnknown81888C
	.addr rsUnknown818891
	.addr rsUnknown81885B
	.addr rsUnknown818808
	.addr rsUnknown818979
	.addr rsUnknown818AE9
	.addr rsUnknown818AF9
	.addr rsUnknown818B00
	.addr rsUnknown8189A3
	.addr rsUnknown8189B5
	.addr rsUnknown8188A7
	.addr rsUnknown8188BF
	.addr rsUnknown8188ED
	.addr rsUnknown81875B
	.addr rsUnknown81876D
	.addr rsUnknown818781
	.addr rsUnknown818793
	.addr rsUnknown8187B7
	.addr rsUnknown8187D4
	.addr rsUnknown8187E0
	.addr rsUnknown81871D
	.addr rsUnknown818727
	.addr rsUnknown8186FE

rsActiveSpriteEngineRenderSpritesOnScreen ; 81/84AD

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	lda aActiveSpriteTypeOffset,b,x
	beq ++

	ldy aActiveSpriteFrameOffset,b,x
	cpy #$0000
	beq ++

	lda aActiveSpritexCoordinate,b,x
	and #$00FF
	sta wR0

	lda aActiveSpriteYCoordinate,b,x
	and #$00FF
	sta wR1

	lda aActiveSpriteSpriteBase,b,x
	sta wR4

	lda aUnknown000904,b,x
	sta wR6

	lda aActiveSpritePalette,b,x
	xba
	asl a
	sta wR5

	lda aActiveSpriteBanks,b,x
	sep #$20
	phb
	pha
	plb

	.databank ?

	rep #$20

	phk
	pea <>(+) - 1

	lda aActiveSpriteBanks,b,x
	sta lSpriteRendererPointer+1,b

	lda aActiveSpriteRenderer,b,x
	sta lSpriteRendererPointer,b

	jmp [<>lSpriteRendererPointer]

	+
	plb

	+
	dec x
	dec x
	bpl -

	plb
	plp
	rts

rsActiveSpriteEngineRenderSprites ; 81/8505

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	ldx #size(aActiveSpriteTypeOffset) - 2

	-
	lda aActiveSpriteTypeOffset,b,x
	beq ++

	ldy aActiveSpriteFrameOffset,b,x
	cpy #$0000
	beq ++

	lda aActiveSpriteXCoordinate,b,x
	sta wR0

	lda aActiveSpriteYCoordinate,b,x
	sta wR1

	lda aActiveSpriteSpriteBase,b,x
	sta wR4

	lda aUnknown000904,b,x
	sta wR6

	lda aActiveSpritePalette,b,x
	xba
	asl a
	sta wR5

	lda aActiveSpriteBanks,b,x
	sep #$20
	phb
	pha
	plb

	.databank ?

	rep #$20
	phk
	pea <>(+) - 1

	lda aActiveSpriteBanks,b,x
	sta lSpriteRendererPointer+1,b

	lda aActiveSpriteRenderer,b,x
	sta lSpriteRendererPointer,b

	jmp [<>lSpriteRendererPointer]

	+
	plb

	+
	dec x
	dec x
	bpl -

	plb
	plp
	rts

rlCreateUnknownSpriteArrayEntry ; 81/8557

	.xl
	.autsiz
	.databank ?

	php
	sep #$20
	phb
	pla
	rep #$20

	ldx wUnknownSpriteArraySize,b
	and #$00FF
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListBank,b,x
	tya
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListOffset,b,x
	lda wR0
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.X,b,x
	lda wR1
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.Y,b,x
	lda wR4
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteBase,b,x
	lda wR5
	sta aUnknownSpriteArray+structUnknownSpriteEntryRAM.AttributeBase,b,x
	txa
	clc
	adc #size(structUnknownSpriteEntryRAM)
	sta wUnknownSpriteArraySize,b
	inc wUnknownSpriteArrayCount,b
	plp
	rtl

rlProcessUnknownSpriteArray ; 81/858C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	lda wUnknownSpriteArrayCount,b
	beq _End

	lda #$0000

	-
	tax
	phx
	ldy aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListOffset,b,x
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.X,b,x
	sta wR0
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.Y,b,x
	sta wR1
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteBase,b,x
	sta wR4
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.AttributeBase,b,x
	sta wR5
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListBank,b,x
	sep #$20
	phb
	pha
	plb
	rep #$20
	jsl rlPushToOAMBuffer
	plb
	pla
	dec wUnknownSpriteArrayCount,b
	beq +

	clc
	adc #size(structUnknownSpriteEntryRAM)
	cmp wUnknownSpriteArraySize,b
	blt -

	+
	stz wUnknownSpriteArraySize,b
	stz wUnknownSpriteArrayCount,b

	_End
	plb
	rtl

rlCallProcessUnknownSpriteArray ; 81/85D4

	.autsiz
	.databank ?

	jmp rlProcessUnknownSpriteArray

rlUnknown8185D7 ; 81/85D7

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phk
	plb

	.databank `*

	lda wUnknownSpriteArrayCount,b
	beq _End

	ldy #size(aUnknown81863A) - 2

	-
	lda aUnknown81863A,y

	sta wR6
	lda #$0000

	-
	tax
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.Y,b,x
	and #$00F0
	cmp wR6
	bne +

	phx
	phy
	ldy aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListOffset,b,x
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.X,b,x
	sta wR0
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.Y,b,x
	sta wR1
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteBase,b,x
	sta wR4
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.AttributeBase,b,x
	sta wR5
	lda aUnknownSpriteArray+structUnknownSpriteEntryRAM.SpriteListBank,b,x
	sep #$20
	phb
	pha
	plb
	rep #$20
	jsl rlPushToOAMBuffer
	plb
	ply
	plx
	dec wUnknownSpriteArrayCount,b
	beq ++

	+
	txa
	clc
	adc #size(structUnknownSpriteEntryRAM)
	cmp wUnknownSpriteArraySize,b
	bcc -

	dec y
	dec y
	bpl --

	+
	stz wUnknownSpriteArraySize,b
	stz wUnknownSpriteArrayCount,b

	_End
	plb
	rtl

aUnknown81863A .block ; 81/863A
	.word $0000
	.word $0010
	.word $0020
	.word $0030
	.word $0040
	.word $0050
	.word $0060
	.word $0070
	.word $0080
	.word $0090
	.word $00A0
	.word $00B0
	.word $00C0
	.word $00D0
	.word $00E0
	.word $00F0
	.word $0100
.bend

rlUnknownPushToOAMBuffer ; 81/865C

	.al
	.xl
	.autsiz
	.databank ?

	; A copy of the normal rlPushToOAMBuffer?

	; Return if there are no sprites to push

	phy
	phx
	dec wR1
	lda structSpriteArray.SpriteCount,b,y
	bne +
	plx
	ply
	rtl

	+
	sta wR2
	inc y
	inc y
	ldx wNextFreeSpriteOffs,b
	clc

	-
	lda structSpriteEntry.X,b,y ; X, unk, size
	clc
	adc wR0
	sta aSpriteBuf,b,x
	bit #$0100
	beq +

	; If X negative, get bit

	lda aOAMSizeBitTable,x
	sta wR3
	lda (wR3)
	ora aOAMUpperXBitTable,x
	sta (wR3)

	+
	clc
	lda structSpriteEntry.Y,b,y
	bit #$0080
	bne _YNegative

	; Strip sprite index off of y

	and #$007F
	bra +

	_YNegative ; s8 -> s16
	ora #$FF80

	+
	clc
	adc wR1
	sta aSpriteBuf+1,b,x
	clc
	adc #16
	cmp #256
	blt +

	; Move down if offscreen

	lda #240
	sta aSpriteBuf+1,b,x

	+
	clc
	lda structSpriteEntry.X,b,y ; uppermost bit is size
	bpl +

	; Get large bit if large

	lda aOAMSizeBitTable,x
	sta wR3
	lda (wR3)
	ora aOAMUpperXBitTable+2,x
	sta (wR3)

	+
	lda structSpriteEntry.Index,b,y

	; AND doesn't set the carry flag
	; so this doesn't do anything?

	pha
	and #$01FF
	pla
	bcc ++

	pha
	and #$00FF
	pla
	bcs +

	clc
	adc wR4
	bra ++

	+
	clc
	adc wR6

	+

	; Back to doing things

	ora wR5
	sta aSpriteBuf+2,b,x
	txa
	adc #size(structPPUOAMEntry)
	and #$01FF
	tax
	tya
	adc #size(structSpriteEntry)
	tay
	dec wR2 ; sprite count
	beq +

	jmp -

	+
	stx wNextFreeSpriteOffs,b
	plx
	ply
	rtl

rsUnknown8186FE ; 81/86FE

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda $0000,b,y
	sta wR0
	lda aActiveSpriteXCoordinate,b,x
	sta wR1
	jsl $8E8601
	inc y
	inc y
	plx
	rts

rlUnknown818711 ; 81/8711

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsr rsUnknown81876D
	plx
	rtl

rlUnknown818717 ; 81/8717

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsr rsUnknown81871D
	plx
	rtl

rsUnknown81871D ; 81/871D

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001619,b
	ora #$8000
	sta wUnknown001619,b
	rts

rsUnknown818727 ; 81/8727

	.al
	.xl
	.autsiz
	.databank ?

	jsl $8E8879
	bcs _81874A

	lda wUnknown001619,b
	and #$7FFF
	cmp #$000F
	bne _818741

	lda wUnknown001619,b
	bpl _818744

	stz wUnknown001619,b
	rts

	_818741
	inc wUnknown001619,b

	_818744
	dec y
	inc aActiveSpriteFrameTimer,b,x
	pla
	rts

	_81874A
	lda wUnknown001619,b
	and #$7FFF
	cmp #$000F
	bne _818744

	lda wUnknown001619,b
	bpl _818744

	rts

rsUnknown81875B ; 81/875B

	.al
	.xl
	.autsiz
	.databank ?

	phy
	lda aUnknown000944,b,x
	tax
	lda #$0000
	jsl $84E254
	ldx wActiveSpriteIndex,b
	ply
	pla
	rts

rsUnknown81876D ; 81/876D

	.al
	.xl
	.autsiz
	.databank ?

	phx
	phy
	lda wUnknown001617,b
	cmp #$0002
	bne +

	jmp ++

	+
	jsl $8EAF43

	+
	ply
	plx
	rts

rsUnknown818781 ; 81/8781

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001617,b
	cmp #$0000
	beq +

	-
	jsr rsUnknown8187BC
	pla
	rts

	+
	jsr rsUnknown81879D
	bra -

rsUnknown818793 ; 81/8793

	.al
	.xl
	.autsiz
	.databank ?

	jsl $8E8879
	bcs +

	jsr rsUnknown81879D

	+
	rts

rsUnknown81879D ; 81/879D

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown001617,b
	lda wActiveSpriteIndex,b
	pha
	ldx wActiveSpriteIndex,b
	phy
	phx
	jsl $948000
	plx
	ply
	pla
	sta wActiveSpriteIndex,b
	rts

rsUnknown8187B7 ; 81/87B7

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown8187BC
	pla
	rts

rsUnknown8187BC ; 81/87BC

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown001617,b
	cmp #$0003
	bne +

	tya
	sta aActiveSpriteCodeOffset,b,x
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	rts

	+
	dec y
	inc aActiveSpriteFrameTimer,b,x
	rts

rsUnknown8187D4 ; 81/87D4

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta aUnknown000A24,b,x
	dec y
	inc aActiveSpriteFrameTimer,b,x
	pla
	rts

rsUnknown8187E0 ; 81/87E0

	.al
	.xl
	.autsiz
	.databank ?

	lda aUnknown000A44,b,x
	bne +

	dec y
	inc aActiveSpriteFrameTimer,b,x
	pla
	rts

	+
	dec aUnknown000A44,b,x
	rts

rsUnknown8187EF ; 81/87EF

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	and #$00FF
	sta aActiveSpriteFrameTimer,b,x
	lda $0001,b,y
	sta aActiveSpriteFrameOffset,b,x
	tya
	clc
	adc #$0003
	sta aActiveSpriteCodeOffset,b,x
	pla
	rts

rsUnknown818808 ; 81/8808

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	and #$00FF
	sta aActiveSpriteFrameTimer,b,x
	lda $0001,b,y
	clc
	adc aActiveSpriteTypeOffset,b,x
	sta aActiveSpriteFrameOffset,b,x
	tya
	clc
	adc #$0003
	sta aActiveSpriteCodeOffset,b,x
	pla
	rts

rsUnknown818825 ; 81/8825

	.al
	.xl
	.autsiz
	.databank ?

	stz aActiveSpriteTypeOffset,b,x
	pla
	rts

rsUnknown81882A ; 81/882A

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	and #$00FF
	sta aActiveSpriteFrameTimer,b,x
	inc y
	pla
	rts

rsUnknown818836 ; 81/8836

	.al
	.xl
	.autsiz
	.databank ?

	dec y
	dec y
	tya
	sta aActiveSpriteCodeOffset,b,x
	pla
	rts

rsUnknown81883E ; 81/883E

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aActiveSpriteFrameTimer,b,x
	inc y
	tya
	sta aActiveSpriteCodeOffset,b,x
	pla
	rts

rsUnknown81884B ; 81/884B

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aActiveSpriteOnCycle,b,x
	inc y
	inc y
	rts

rsUnknown818854 ; 81/8854

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rsUnknown818006
	sta aActiveSpriteOnCycle,b,x
	rts

rsUnknown81885B ; 81/885B

	.al
	.xl
	.autsiz
	.databank ?

	lda aActiveSpriteBanks-1,b,x
	sta lActiveSpriteCodePointer+1,b
	lda $0000,b,y
	sta lActiveSpriteCodePointer,b
	inc y
	inc y
	phx
	phk
	pea <>(+)-1
	jmp [<>lActiveSpriteCodePointer]

	+
	plx
	rts

rsUnknown818873 ; 81/8873

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta lActiveSpriteCodePointer,b
	lda $0001,b,y
	sta lActiveSpriteCodePointer+1,b
	inc y
	inc y
	inc y
	phx
	phk
	pea <>(+)-1
	jmp [<>lActiveSpriteCodePointer]

	+
	plx
	rts

rsUnknown81888C ; 81/888C

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	tay
	rts

rsUnknown818891 ; 81/8891

	.al
	.xl
	.autsiz
	.databank ?

	dec y
	lda $0000,b,y
	and #$FF00
	xba
	bpl +

	ora #$FF00

	+
	pha
	tya
	sec
	adc #$01,s
	sta #$01,s
	ply
	rts

rsUnknown8188A7 ; 81/88A7

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aActiveSpriteUpdater,b,x
	inc y
	inc y
	rts

rsUnknown8188B0 ; 81/88B0

	.al
	.xl
	.autsiz
	.databank ?

	dec aActiveSpriteUpdater,b,x
	bne rsUnknown81888C

	inc y
	inc y
	rts

rsUnknown8188B8 ; 81/88B8

	.al
	.xl
	.autsiz
	.databank ?

	dec aActiveSpriteUpdater,b,x
	bne rsUnknown818891

	inc y
	rts

rsUnknown8188BF ; 81/88BF

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phx
	lda $0000,b,y
	tax
	sep #$20
	lda $0002,b,y
	pha
	rep #$20
	plb
	lda $0000,b,x
	and #$00FF
	bne +

	inc y
	inc y
	inc y
	inc y
	bra ++

	+
	plb
	lda $0003,b,y
	tay
	plx
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla
	rts

	+
	plx
	plb
	rts

rsUnknown8188ED ; 81/88ED

	.al
	.xl
	.autsiz
	.databank ?

	phx
	phb
	lda $0000,b,y
	tax
	sep #$20
	lda $0002,b,y
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,x
	beq +

	inc y
	inc y
	inc y
	inc y
	inc y
	bra ++

	+
	plb
	lda $0003,b,y
	tay
	plx
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla
	rts

	+
	plb
	plx
	rts

rsUnknown818919 ; 81/8919

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phx
	lda $0000,b,y
	tax
	sep #$20
	lda $0002,b,y
	pha
	rep #$20
	lda $0003,b,y
	plb

	.databank ?

	sta $0000,b,x
	inc y
	inc y
	inc y
	inc y
	inc y
	plx
	plb
	rts

rsUnknown818936 ; 81/8936

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phx
	lda aUnknown0009A4,b,x
	beq +

	inc y
	inc y
	inc y

	+
	lda $0000,b,y
	tax
	sep #$20
	lda $0002,b,y
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,x
	tay
	plx
	plb
	rts

rsUnknown818954 ; 81/8954

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phx
	tay
	lda aUnknown0009A4,b,x
	beq +

	tay

	+
	plx
	plb
	rts

rsUnknown818960 ; 81/8960

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phx
	tay
	lda aUnknown0009A4,b,x
	beq +

	tay

	+
	plx
	plb
	rts

rsUnknown81896C ; 81/896C

	.al
	.xl
	.autsiz
	.databank ?

	dec y
	tya
	sta aActiveSpriteCodeOffset,b,x
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla
	rts

rsUnknown818979 ; 81/8979

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	xba
	and #$FF00
	bpl +

	ora #$00FF

	+
	xba
	clc
	adc aActiveSpriteXCoordinate,b,x
	sta aActiveSpriteXCoordinate,b,x
	lda $0000,b,y
	and #$FF00
	bpl +

	ora #$00FF

	+
	xba
	clc
	adc aActiveSpriteYCoordinate,b,x
	sta aActiveSpriteYCoordinate,b,x
	inc y
	inc y
	rts

rsUnknown8189A3 ; 81/89A3

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda aActiveSpriteXCoordinate,b,x
	tax
	sta wR0
	lda $0000,b,y
	and #$00FF
	ora wR0
	inc y
	plx
	rts

rsUnknown8189B5 ; 81/89B5

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	and #$00FF
	inc y
	rts

rsUnknown8189BD ; 81/89BD

	.al
	.xl
	.autsiz
	.databank ?

	phy
	phx
	lda aUnknown000964,b,x
	asl a
	clc
	adc aUnknown000964,b,x
	tax
	sta lR18
	sta lR18+1
	lda $0000,b,y
	and #$00FF
	asl a
	tay
	lda [lR18],y
	sta wR2
	ldx wActiveSpriteIndex,b
	lda aUnknown000944,b,x
	asl a
	tax
	sta wR3
	lda #(`$7FB0F5)<<8
	sta lR18+1
	lda #<>$7FB0F5
	clc
	adc #$1000
	adc wR2
	adc wR3
	sta lR18
	ldx wActiveSpriteIndex,b
	lda aUnknown000964,b,x
	sta wR0
	ldx wActiveSpriteIndex,b
	lda aUnknown000944,b,x
	asl a
	tax
	sta wR2
	lda bBuf_OBSEL
	and #($C000 >> 14)
	asl a
	asl a
	asl a
	asl a
	asl a
	xba
	clc
	adc wR2
	sta wR1
	plx
	ply
	inc y
	rts

rsUnknown818A1A ; 81/8A1A

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	rts

rsUnknown818A1E ; 81/8A1E

	.al
	.xl
	.autsiz
	.databank ?

	beq +

	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla
	bra ++

	+
	lda #$0001

	+
	rts

rsUnknown818A2E ; 81/8A2E

	.al
	.xl
	.autsiz
	.databank ?

	beq +

	stx wR0
	cmp wR0
	beq ++

	cmp wR0
	beq ++

	lda #$0000
	bra ++

	+
	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts

rsUnknown818A48 ; 81/8A48

	.al
	.xl
	.autsiz
	.databank ?

	bne +

	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts

rsUnknown818A53 ; 81/8A53

	.al
	.xl
	.autsiz
	.databank ?

	bne +

	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts

rsUnknown818A5E ; 81/8A5E

	.al
	.xl
	.autsiz
	.databank ?

	sta lR18
	sta lR18+1
	lda aUnknown0009A4,b,x
	beq +

	sta lR18
	sta lR18+1

	+
	lda [lR18],y
	clc
	adc lR18
	tay
	rts

rsUnknown818A72 ; 81/8A72

	.al
	.xl
	.autsiz
	.databank ?

	sta lR18
	sta lR18+1
	lda aUnknown0009A4,b,x
	beq +

	sta lR18
	sta lR18+1

	+
	lda [lR18],y
	clc
	adc lR18
	tay
	rts

rsUnknown818A86 ; 81/8A86

	.al
	.xl
	.autsiz
	.databank ?

	phy
	phx
	plx
	ply
	rts

rsUnknown818A8B ; 81/8A8B

	.al
	.xl
	.autsiz
	.databank ?

	phx
	phy
	sty wR0
	sta lR18
	sta lR18+1
	sta lR19+1
	lda aUnknown0009A4,b,x
	beq +

	sta lR18
	sta lR18+1
	sta lR19+1

	+
	lda [lR18],y
	clc
	adc lR18
	sta lR19
	ldy wR0
	lda $0001,b,y
	and #$00FF
	asl a
	tay
	lda [lR19],y
	clc
	adc lR18
	sta aActiveSpriteFrameOffset,b,x
	ldy wR0
	lda $0000,b,y
	and #$00FF
	sta aActiveSpriteFrameTimer,b,x
	pla
	clc
	adc #$0002
	sta aActiveSpriteCodeOffset,b,x
	plx
	pla
	rts

rsUnknown818ACF ; 81/8ACF

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	lda #$0000
	rts

rsUnknown818AD6 ; 81/8AD6

	.al
	.xl
	.autsiz
	.databank ?

	beq +

	lda #$0000
	lda #$0001
	bra ++

	+
	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts

rsUnknown818AE9 ; 81/8AE9

	.al
	.xl
	.autsiz
	.databank ?

	beq +

	lda #$0000
	bra ++

	+
	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts

rsUnknown818AF9 ; 81/8AF9

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	lda #$0000
	rts

rsUnknown818B00 ; 81/8B00

	.al
	.xl
	.autsiz
	.databank ?

	beq +

	lda #$0000
	lda #$0001
	bra ++

	+
	dec y
	lda #$0001
	sta aActiveSpriteFrameTimer,b,x
	pla

	+
	rts
