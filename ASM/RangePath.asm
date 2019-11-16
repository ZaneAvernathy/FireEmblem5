
rlUnknown80DE00 ; 80/DE00

	.autsiz
	.databank ?

	php
	sep #$20
	phb
	lda #`aRangeMap
	pha
	plb

	.databank `aRangeMap

	lda #$71
	sta bMovementCostCap,b
	rep #$30
	jmp rlFillMovementRangeArray

rlUnknown80DE12 ; 80/DE12

	.autsiz
	.databank ?

	php
	sep #$20
	phb
	lda #`aRangeMap
	pha
	plb

	.databank `aRangeMap

	lda #$71
	sta bMovementCostCap,b
	nop
	rep #$30
	nop
	jsl rlCopyTerrainMovementCostBuffer
	nop

rlFillMovementRangeArray ; 80/DE28

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	jsl rlSetupRangePathDirectionDistances

	; Get current tile index

	jsl rlGetMapTileIndexByCoords

	; Fill range map with FFFF

	sta wR1
	lda #(`aRangeMap)<<8
	sta lR18+1
	lda #<>aRangeMap
	sta lR18
	lda #$FFFF
	jsl rlFillMapByWord
	inc wR2
	stz wR0
	lda #aRangePathArray2 - aRangePathArray
	sta wR6
	lda #aRangePathArray1 - aRangePathArray
	sta wR5

	; wR1 has tile index of unit

	; wR7 + wR1 = tile up in unit map
	; wR8 + wR1 = tile down in unit map
	; wR9 + wR1 = tile left in unit map
	; wR10 + wR1 = tile right in unit map

	; Clear range map tile that they're on

	ldx wR1
	lda #$FF00
	sta aRangeMap,x

	; Store current tile to range path array

	txa
	ldy wR5
	sta aRangePathArray + structRangePathEntry.TargetTile,b,y
	lda #$0000
	sta aRangePathArray + structRangePathEntry.TargetCost,b,y
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,y
	lda #$FFFF
	sta aRangePathArray + size(structRangePathEntry) + structRangePathEntry.EndFlag,b,y

	-

	; Some kind of alternating flag

	lda wR0
	eor #$0001
	beq +

	sta wR0
	ldx #aRangePathArray1 - aRangePathArray
	stx wR6
	ldx #aRangePathArray2 - aRangePathArray
	stx wR5
	bra ++

	+
	sta wR0
	ldx #aRangePathArray2 - aRangePathArray
	stx wR6
	ldx #aRangePathArray1 - aRangePathArray
	stx wR5

	+
	ldx wR6
	lda aRangePathArray + structRangePathEntry.EndFlag,b,x
	cmp #$FFFF
	bne _Next

	jmp _End

	_Next
	ldx wR6
	lda aRangePathArray + structRangePathEntry.EndFlag,b,x
	cmp #$FFFF
	bne +

	jmp -

	+

	; Otherwise use TargetDirection to determine where to go

	and #$00FF
	tax
	lda _aDirectionTable,x
	sta lR20
	jmp (lR20)

	_aDirectionTable ; 80/DEB6
		.addr _WentAny
		.addr _WentUp
		.addr _WentRight
		.addr _WentDown
		.addr _WentLeft

	_WentAny ; 80/DEC0

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sep #$20
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	tdc

	; Check if unit in tile up

	lda (wR7),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+

	; Get terrain's movement cost

	rep #$20
	lda (wR11),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	; Add to path's running movement cost

	clc
	adc aRangeMap,y

	; Compare to the cost of moving up?

	cmp (wR15),y
	bcs +

	; Compare to unit's mov

	cmp wR2
	bcs +

	; Store cost to move up

	ldx wR5
	sta (wR15),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20

	; Store target tile index

	tya
	clc
	adc wR21
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x

	; Store direction?

	sep #$20
	lda #RangePathUp
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x

	; next path entry

	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same thing for tile down

	tdc
	lda (wR8),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR12),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR16),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR16),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x

	rep #$20
	tya
	clc
	adc wR22
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathDown
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for left

	tdc
	lda (wR9),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR13),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR17),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR17),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR23
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathLeft
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for right

	tdc
	lda (wR10),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR14),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR19),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR19),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR24
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathRight
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	jmp _CapPath

	_WentUp ; 80/DFFD

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sep #$20
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	tdc

	; Check if unit in tile up

	lda (wR7),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+

	; Get terrain's movement cost

	rep #$20
	lda (wR11),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	; Add to path's running movement cost

	clc
	adc aRangeMap,y

	; Compare to the cost of moving up?

	cmp (wR15),y
	bcs +

	; Compare to unit's mov

	cmp wR2
	bcs +

	; Store cost to move up

	ldx wR5
	sta (wR15),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20

	; Store target tile index

	tya
	clc
	adc wR21
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x

	; Store direction?

	sep #$20
	lda #RangePathUp
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x

	; next path entry

	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for left

	tdc
	lda (wR9),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR13),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR17),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR17),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR23
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathLeft
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for right

	tdc
	lda (wR10),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR14),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR19),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR19),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR24
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathRight
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	jmp _CapPath

	_WentRight ; 80/E0EC

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sep #$20
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	tdc

	; Check if unit in tile up

	lda (wR7),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+

	; Get terrain's movement cost

	rep #$20
	lda (wR11),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	; Add to path's running movement cost

	clc
	adc aRangeMap,y

	; Compare to the cost of moving up?

	cmp (wR15),y
	bcs +

	; Compare to unit's mov

	cmp wR2
	bcs +

	; Store cost to move up

	ldx wR5
	sta (wR15),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20

	; Store target tile index

	tya
	clc
	adc wR21
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x

	; Store direction?

	sep #$20
	lda #RangePathUp
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x

	; next path entry

	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same thing for tile down

	tdc
	lda (wR8),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR12),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR16),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR16),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x

	rep #$20
	tya
	clc
	adc wR22
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathDown
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for right

	tdc
	lda (wR10),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR14),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR19),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR19),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR24
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathRight
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	jmp _CapPath

	_WentDown ; 80/E1DB

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sep #$20
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same thing for tile down

	tdc
	lda (wR8),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR12),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR16),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR16),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x

	rep #$20
	tya
	clc
	adc wR22
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathDown
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for left

	tdc
	lda (wR9),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR13),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR17),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR17),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR23
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathLeft
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for right

	tdc
	lda (wR10),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR14),y
	and #$00FF
	tax
	sep #$20
	.as
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR19),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR19),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR24
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathRight
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	jmp _CapPath

	_WentLeft ; 80/E2CA

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sep #$20
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	tdc

	; Check if unit in tile up

	lda (wR7),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+

	; Get terrain's movement cost

	rep #$20
	lda (wR11),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	; Add to path's running movement cost

	clc
	adc aRangeMap,y

	; Compare to the cost of moving up?

	cmp (wR15),y
	bcs +

	; Compare to unit's mov

	cmp wR2
	bcs +

	; Store cost to move up

	ldx wR5
	sta (wR15),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20

	; Store target tile index

	tya
	clc
	adc wR21
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x

	; Store direction?

	sep #$20
	lda #RangePathUp
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x

	; next path entry

	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same thing for tile down

	tdc
	lda (wR8),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR12),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR16),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR16),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x

	rep #$20
	tya
	clc
	adc wR22
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathDown
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+
	ldx wR6
	ldy aRangePathArray + structRangePathEntry.TargetTile,b,x
	lda wR4
	beq +

	; Same for left

	tdc
	lda (wR9),y
	beq +

	and #Player | Enemy | NPC
	tax
	lda wPlayerUnitTargetFlag,x
	bne ++

	+
	rep #$20
	lda (wR13),y
	and #$00FF
	tax
	sep #$20
	lda aTerrainMovementCostBuffer,x
	bmi +

	clc
	adc aRangeMap,y
	cmp (wR17),y
	bcs +

	cmp wR2
	bcs +

	ldx wR5
	sta (wR17),y
	sta aRangePathArray + structRangePathEntry.TargetCost,b,x
	rep #$20
	tya
	clc
	adc wR23
	sta aRangePathArray + structRangePathEntry.TargetTile,b,x
	sep #$20
	lda #RangePathLeft
	sta aRangePathArray + structRangePathEntry.TargetDirection,b,x
	inc x
	inc x
	inc x
	inc x
	stx wR5

	+

	_CapPath ; 80/E3B6

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	rep #$20
	ldx wR5
	lda #$FFFF
	sta aRangePathArray + structRangePathEntry.EndFlag,b,x
	lda wR6
	clc
	adc #size(structRangePathEntry)
	sta wR6
	jmp _Next

	_End

	plb
	plp
	rtl

rlSetupRangePathDirectionDistances ; 80/E3CE

	.al
	.autsiz
	.databank ?

	lda #<>aTerrainMap
	sec
	sbc wMapRowSize,b
	sta wR11

	lda #<>aTerrainMap
	clc
	adc wMapRowSize,b
	sta wR12

	lda #<>aTerrainMap - 1
	sta wR13

	lda #<>aTerrainMap + 1
	sta wR14

	lda #<>aRangeMap
	sec
	sbc wMapRowSize,b
	sta wR15

	lda #<>aRangeMap
	clc
	adc wMapRowSize,b
	sta wR16

	lda #<>aRangeMap - 1
	sta wR17

	lda #<>aRangeMap + 1
	sta wR19

	lda #$0000
	sec
	sbc wMapRowSize,b
	sta wR21

	lda wMapRowSize,b
	sta wR22

	lda #$FFFF
	sta wR23

	lda #$0001
	sta wR24

	lda #<>aPlayerVisibleUnitMap
	sec
	sbc wMapRowSize,b
	sta wR7

	lda #<>aPlayerVisibleUnitMap
	clc
	adc wMapRowSize,b
	sta wR8

	lda #<>aPlayerVisibleUnitMap - 1
	sta wR9

	lda #<>aPlayerVisibleUnitMap + 1
	sta wR10
	rtl

rlCopyTerrainMovementCostBuffer ; 80/E43B

	.al
	.xl
	.autsiz
	.databank `aClassDataBuffer

	phb
	lda wR3
	jsl $8393E0
	lda aClassDataBuffer.MovementTypePointer
	tax
	ldy #<>aTerrainMovementCostBuffer
	lda #size(structTerrainEntry)
	mvn #$86,#`aTerrainMovementCostBuffer
	plb
	rtl

rlUnknown80E451 ; 80/E451

	.autsiz
	.databank ?

	php
	rep #$30
	jsl rlGetMapTileIndexByCoords
	sta wR2
	tax
	stz wR24
	sep #$20
	phb
	lda #`aRangeMap
	pha
	plb

	.databank `aRangeMap

	_Loop
	ldx wR2
	lda aRangeMap,x
	bne +

	jmp _End

	+
	rep #$20
	lda wR2
	clc
	adc wMapRowSize,b
	tay

	lda wR2
	sec
	sbc wMapRowSize,b
	tax

	sep #$20
	lda aRangeMap,x
	sta wR3

	lda aRangeMap,y
	sta wR4

	ldx wR2
	lda aRangeMap - 1,x
	sta wR4+1

	lda aRangeMap + 1,x
	sta wR3+1

	lda #$FE
	ldx #$0003

	-
	cmp wR3,x
	bcc +

	lda wR3,x

	+
	dec x
	bpl -

	ldy #$0008
	ldx #$0003

	-
	cmp wR3,x
	beq +

	stz wR3,x
	dec y
	dec y
	dec x
	bpl -

	bra ++

	+
	xba
	tya
	sta wR3,x
	xba
	dec x
	bpl -

	+
	tyx
	rep #$20
	lda _aUnknown80E4CB,x
	sta wR0
	jmp (wR0)

	_aUnknown80E4CB ; 80/E4CB
		.addr _Unknown80E4D5
		.addr _Unknown80E4FE
		.addr _Unknown80E4D9
		.addr _Unknown80E4E5
		.addr _Unknown80E4F2

	_Unknown80E4D5 ; 80/E4D5

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	jsl <>riBRK

	_Unknown80E4D9 ; 80/E4D9

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	lda #128
	jsl rlUnknown80B0E6
	and #$0001
	bra _Unknown80E501

	_Unknown80E4E5 ; 80/E4E5

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	lda #48
	jsl rlUnknown80B0E6
	lsr a
	lsr a
	lsr a
	lsr a
	bra _Unknown80E501

	_Unknown80E4F2 ; 80/E4F2

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	lda #128
	jsl rlUnknown80B0E6
	and #$0003
	bra _Unknown80E501

	_Unknown80E4FE ; 80/E4FE

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	lda #0

	_Unknown80E501 ; 80/E501

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	ldy #$0004
	tax
	sep #$20

	-
	dec y
	lda wR3,b,y
	beq -

	dec x
	bpl -

	tya
	ldx wR24
	sta $7EA6AD,x
	inc wR24
	rep #$20
	asl a
	and #$000F
	tax
	lda @l wPreviousMapTileRowAmount,x
	clc
	adc wR2
	sta wR2
	sep #$20
	jmp _Loop

	_End

	.as

	jsr rsUnknown80E533
	plb
	plp
	rtl

rsUnknown80E533 ; 80/E533

	.as
	.xl
	.autsiz
	.databank `aRangeMap

	ldx wR24
	dec x

	-
	lda @l $7EA6AD,x
	pha
	dec x
	bpl -

	ldx wR24
	lda #$00
	sta @l $7EA72D,x
	dec x

	-
	pla
	inc a
	sta @l $7EA72D,x
	dec x
	bpl -
	rts

rlUnknown80E551 ; 80/E551

	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`aRangeMap
	pha
	plb

	.databank `aRangeMap

	rep #$20
	lda wMapHeight16,b
	dec a
	sta wR1

	-
	lda wMapWidth16,b
	dec a
	sta wR0

	-
	lda wR1
	asl a
	tax
	lda @l aMapTileRowIndexes,x
	clc
	adc wR0
	tay
	sep #$20
	lda aRangeMap,y
	bpl +

	lda (wR15),y
	cmp bMovementCostCap,b
	bcs +

	lda bMovementCostCap,b
	sta aRangeMap,y

	+
	lda aRangeMap,y
	bpl +

	lda (wR19),y
	cmp bMovementCostCap,b
	bcs +

	lda bMovementCostCap,b
	sta aRangeMap,y

	+
	lda aRangeMap,y
	bpl +

	lda (wR16),y
	cmp bMovementCostCap,b
	bcs +

	lda bMovementCostCap,b
	sta aRangeMap,y

	+
	lda aRangeMap,y
	bpl +

	lda (wR17),y
	cmp bMovementCostCap,b
	bcs +

	lda bMovementCostCap,b
	sta aRangeMap,y

	+
	rep #$20
	dec wR0
	bne -

	dec wR1
	bne --

	inc bMovementCostCap,b
	plb
	plp
	rtl

rlUnknown80E5CD ; 80/E5CD

	.al
	.autsiz
	.databank ?

	pha
	lsr a
	lsr a
	lsr a
	lsr a
	and #$000F
	sta wR2
	lda #$0000
	sta wR4
	lda wR0
	pha
	lda wR1
	pha
	jsl rlUnknown80E662
	pla
	sta wR1
	pla
	sta wR0
	pla
	and #$000F
	dec a
	beq +

	sta wR2
	lda #$007C
	sta wR4
	jsl rlUnknown80E662

	+
	rtl

rlUnknown80E5FF ; 80/E5FF

	.al
	.xl
	.autsiz
	.databank `aAllegianceTargets

	ldy wR2
	lda structExpandedCharacterDataRAM.DeploymentNumber,b,y
	and #Player | Enemy | NPC
	jsl $83B296
	lda aAllegianceTargets,x
	and #$00FF
	cmp #$0000
	bne +

	jmp rlUnknown80E662._End

	+
	ldx #<>aVisibilityMap
	stx wR3
	lda $7E4F9E
	sta wR2
	bra rlUnknown80E662

	_End
	rtl

rlUnknown80E626 ; 80/E626

	.al
	.xl
	.autsiz
	.databank ?

	ldy wR1
	lda structExpandedCharacterDataRAM.DeploymentNumber,b,y
	and #Player | Enemy | NPC
	jsl $83B296
	lda aAllegianceTargets,x
	and #$00FF
	cmp #$0000
	bne +

	jmp rlUnknown80E662._End

	+
	ldx #<>aVisibilityMap
	stx wR3
	lda structExpandedCharacterDataRAM.X,b,y
	and #$00FF
	sta wR0
	lda structExpandedCharacterDataRAM.Y,b,y
	and #$00FF
	sta wR1
	lda structExpandedCharacterDataRAM.VisionBonus,b,y
	clc
	adc wVisionRange,b
	and #$00FF
	sta wR2

rlUnknown80E662 ; 80/E662

	.al
	.xl
	.autsiz
	.databank ?

	lda wR0
	beq rlUnknown80E5FF._End

	cmp wMapWidth16,b
	bcs rlUnknown80E5FF._End

	lda wR1
	beq rlUnknown80E5FF._End

	cmp wMapHeight16,b
	bcs rlUnknown80E5FF._End

	php
	sep #$20
	phb
	lda #`aRangeMap
	pha
	plb

	.databank `aRangeMap

	rep #$30
	jsl rlGetMapTileIndexByCoords
	sta wR8
	stz wR7
	lda wMapRowSize,b
	sta wR9
	lda wR2
	sta wR11
	sta wR12
	lda wR1
	clc
	adc wR2
	cmp wMapHeight16,b
	bcc +

	lda wMapHeight16,b
	sec
	sbc wR1
	sta wR12

	+
	sta wR6
	lda wR1
	sec
	sbc wR2
	bpl +

	tay
	clc
	adc wR0
	sta wR0
	tya
	eor #$FFFF
	inc a
	asl a
	sta wR7
	lda wR1
	sta wR11
	lda #$0000

	+
	sta wR5
	sta wR1
	jsl rlGetMapTileIndexByCoords
	clc
	adc wR3
	sta wR8
	ldy wR11
	beq +

	-
	jsr rsUnknown80E6FF
	inc wR7
	inc wR7
	dec wR0
	lda wR8
	clc
	adc wR9
	dec a
	sta wR8
	dec y
	bne -

	+
	ldy wR12

	-
	jsr rsUnknown80E6FF
	dec wR7
	dec wR7
	inc wR0
	lda wR8
	clc
	adc wR9
	inc a
	sta wR8
	dec y
	bpl -

	plb
	plp

	_End
	rtl

rsUnknown80E6FF ; 80/E6FF

	.al
	.autsiz
	.databank ?

	lda wR8
	sta wR13
	lda wR7
	sta wR15
	lda wR0
	bpl +

	lda wR8
	sec
	sbc wR0
	sta wR13
	lda wR0
	clc
	adc wR7
	sta wR15
	cmp wMapWidth16,b
	beq ++
	blt ++

	lda wMapWidth16,b
	sta wR15

	+
	lda wR0
	clc
	adc wR7
	cmp wMapWidth16,b
	blt +

	lda wMapWidth16,b
	sec
	sbc wR0
	sta wR15

	+
	ldx wR13
	lda #40
	sec
	sbc wR15
	sta wR16
	asl a
	clc
	adc wR16
	clc
	adc #<>_IncStart
	clc
	adc wR4
	sta wR10
	jmp (wR10)

	_IncStart ; 80/E751
	.for i=40, i>=0, i-=1
		inc i,b,x
	.next

	rts

	_DecStart ; 80/E7CD
	.for i=40, i>=0, i-=1
		dec i,b,x
	.next

	rts

rlFillMapByWord ; 80/E849

	.al
	.xl
	.autsiz
	.databank ?

	tay
	php
	phb
	sep #$20
	lda lR18+2
	pha
	plb
	rep #$30
	phy
	ldx lR18
	lda #size(aPlayerVisibleUnitMap)
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tay
	pla

	-
	.for i=0, i<32,i +=2
		sta i,b,x
	.next
	pha
	txa
	clc
	adc #32
	tax
	pla
	dec y
	bne -

	plb
	plp
	rtl

rlFillTilemapByWord ; 80/E89F

	.autsiz
	.databank ?

	tay
	php
	phb
	sep #$20
	lda #`aPlayerVisibleUnitMap
	pha
	plb

	.databank `aPlayerVisibleUnitMap

	rep #$30
	phy
	ldx wR0
	ldy #$0020
	pla

	-
	.for i=0, i<64, i+=2
		sta i,b,x
	.next
	pha
	txa
	clc
	adc #64
	tax
	pla
	dec y
	bne -

	plb
	plp
	rtl

rlFillTilemapRectByWord ; 80/E91F

	.xl
	.autsiz
	.databank ?

	tay
	php
	phb
	sep #$20
	lda #`aPlayerVisibleUnitMap
	pha
	rep #$20
	plb

	.databank `aPlayerVisibleUnitMap

	lda #$0020
	sec
	sbc wR1
	sta wR1
	asl a
	clc
	adc wR1
	clc
	adc #<>_FillStart
	sta wR1
	ldx wR0

	-
	tya
	jmp (wR1)

	_FillStart ; 80/E942
	.for i=64-2, i>=0, i-=2
		sta i,b,x
	.next
	txa
	clc
	adc #64
	tax
	dec wR2
	bne -

	plb
	plp
	rtl

rlDrawRangeTiles1RangeOnly ; 80/E9AF

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	php
	lda #<>aMovementMap
	sec
	sbc wMapRowSize,b
	sta wR0
	lda #<>aMovementMap
	clc
	adc wMapRowSize,b
	sta wR1
	lda wMapTileCount,b
	sec
	sbc wMapRowSize,b
	tay
	sep #$20

	-
	lda aRangeMap,y
	bmi +

	lda aPlayerVisibleUnitMap,y
	bne +

	lda #$01
	sta aMovementMap - 1,y
	sta aMovementMap + 1,y
	sta (wR0),y
	sta (wR1),y

	+
	dec y
	cpy wMapRowSize,b
	bne -

	plp
	rtl

rlDrawRangeTiles1To2Range ; 80/E9EA

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	php
	lda #<>aMovementMap
	sec
	sbc wMapRowSize,b
	sec
	sbc wMapRowSize,b
	sta wR0
	lda #<>aMovementMap
	sec
	sbc wMapRowSize,b
	sta wR2
	dec a
	sta wR1
	inc a
	inc a
	sta wR3
	lda #<>aMovementMap
	clc
	adc wMapRowSize,b
	sta wR5
	dec a
	sta wR4
	inc a
	inc a
	sta wR6
	lda #<>aMovementMap
	clc
	adc wMapRowSize,b
	clc
	adc wMapRowSize,b
	sta wR7
	lda wMapRowSize,b
	sta wR8
	ldy wMapTileCount,b
	sec
	sbc wMapRowSize,b
	sep #$20

	-
	lda aRangeMap,y
	bmi +

	lda aPlayerVisibleUnitMap,y
	bne +

	lda #$01
	sta aMovementMap - 2,y
	sta aMovementMap - 1,y
	sta aMovementMap + 1,y
	sta aMovementMap + 2,y
	sta (wR0),y
	sta (wR1),y
	sta (wR2),y
	sta (wR3),y
	sta (wR4),y
	sta (wR5),y
	sta (wR6),y
	sta (wR7),y

	+
	dec y
	cpy wR8
	bne -

	plp
	rtl

rlDrawRangeTiles2RangeOnly ; 80/EA62

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	php
	lda #<>aMovementMap
	sec
	sbc wMapRowSize,b
	sec
	sbc wMapRowSize,b
	sta wR0
	clc
	adc wMapRowSize,b
	dec a
	sta wR1
	inc a
	inc a
	sta wR2
	lda #<>aMovementMap
	clc
	adc wMapRowSize,b
	dec a
	sta wR3
	inc a
	inc a
	sta wR4
	clc
	adc wMapRowSize,b
	dec a
	sta wR5
	lda #<>aMovementMap
	clc
	adc wMapRowSize,b
	clc
	adc wMapRowSize,b
	sta wR7
	lda wMapRowSize,b
	sta wR8
	ldy wMapTileCount,b
	sec
	sbc wMapRowSize,b
	sep #$20

	-
	lda aRangeMap,y
	bmi +

	lda aPlayerVisibleUnitMap,y
	bne +

	lda #$01
	sta aMovementMap - 2,y
	sta aMovementMap + 2,y
	sta (wR0),y
	sta (wR1),y
	sta (wR2),y
	sta (wR3),y
	sta (wR4),y
	sta (wR5),y

	+
	dec y
	cpy wR8
	bne -

	plp
	rtl

rsUnknown80EAD0 ; 80/EAD0

	.al
	.xl
	.autsiz
	.databank `aRangeMap

	sta wEventEngineUnknownXTarget
	lda wMapWidth16,b
	dec a
	sta wR0
	lda wMapHeight16,b
	dec a
	sta wEventEngineUnknownYTarget
	ldy wMapRowSize,b
	sep #$20

	-
	lda aRangeMap,y
	bmi +

	lda aPlayerVisibleUnitMap,y
	bne +

	phy
	rep #$30
	lda #$0001
	sta wR1
	lda #<>aMovementMap
	sta wR3
	lda wEventEngineUnknownXTarget
	ldx wR0
	phx
	lda wEventEngineUnknownXTarget
	jsl rlUnknown80E5CD
	plx
	stx wR0
	lda wEventEngineUnknownYTarget
	sta wR1
	ldx wR0
	phx
	lda wEventEngineUnknownXTarget
	jsl rlUnknown80E5CD
	plx
	stx wR0
	ply
	sep #$20

	+
	dec wR0
	bne -

	rep #$30
	rts

