
rlHandlePossibleHDMA ; 80/AC95

	.autsiz
	.databank ?

	; Checks to see if there's any HDMA
	; to handle this frame.
	; You shouldn't call this yourself.

	; Inputs:
	; None

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	lda bUnknown000341,b
	sta MDMAEN,b
	stz bUnknown000341,b

	; Check for vblank

	lda @l HVBJOY
	bit #HVBJOY.VBLankFlag
	beq _End

	; Handle HDMA?

	lda bBuf_HDMAEN
	ora bHDMAPendingChannels,b
	sta bBuf_HDMAEN

	jsl rlHDMAArrayEngineProcessHDMAArray

	lda bBuf_HDMAEN
	sta HDMAEN,b

	stz bBuf_HDMAEN
	stz bHDMAPendingChannels,b

	_End
	plp
	plb
	rtl

rlProcessDMAStructArray ; 80/ACC4

	.autsiz
	.databank ?

	; Handles entries in the DMA array

	; Inputs:
	; None

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20

	; Check if there is anything
	; to DMA

	lda bDMAArrayFlag,b
	beq _End

	; Clear flag, DMA status

	stz bDMAArrayFlag,b
	stz MDMAEN,b
	stz HDMAEN,b

	rep #$30
	stz wNextDMAArrayStructOffs,b
	ldy #$0000

	_DMALoop
	cpy #size(aDMAStructArray)
	blt _BelowLimit

	; I'd bet some bounds checking would be better
	; than simply hanging. Might be hard because the
	; entries can have different sizes?

	_Hang
	bra _Hang

	_BelowLimit

	; Grab the transfer type

	lda aDMAStructArray,b,y
	and #$00FF
	asl a
	tax
	jmp (_DMARoutineTable,x)

	_DMARoutineTable ; 80/ACF2

		; These correspond to the types in the
		; different DMA structs

		.addr _End
		.addr _ToCGRAM
		.addr _ToVRAM
		.addr _FromVRAM
		.addr _InputDest

	_End ; 80/ACFC

	.al
	.xl
	.autsiz
	.databank `rlProcessDMAStructArray

	; Nothing to transfer

	sep #$20
	stz aDMAStructArray,b
	plp
	plb
	rtl

	_ToCGRAM ; 80/AD04

	.al
	.xl
	.autsiz
	.databank `rlProcessDMAStructArray

	sep #$20
	lda aDMAStructArray+structDMAToCGRAMEntry.Source,b,y
	sta A1T7,b
	lda aDMAStructArray+structDMAToCGRAMEntry.Source+1,b,y
	sta A1T7+1,b
	lda aDMAStructArray+structDMAToCGRAMEntry.Source+2,b,y
	sta A1T7+2,b
	lda aDMAStructArray+structDMAToCGRAMEntry.Count,b,y
	sta DAS7,b
	lda aDMAStructArray+structDMAToCGRAMEntry.Count+1,b,y
	sta DAS7+1,b
	lda aDMAStructArray+structDMAToCGRAMEntry.Start,b,y
	sta CGADD,b
	stz DMAP7,b
	lda #CGDATA - PPU_REG_BASE
	sta BBAD7,b
	lda #MDMAEN_Setting(False, False, False, False, False, False, False, True)
	sta MDMAEN,b
	rep #$20
	tya
	clc
	adc #size(structDMAToCGRAMEntry)
	tay
	jmp _DMALoop

	_ToVRAM ; 80/AD42

	.al
	.xl
	.autsiz
	.databank `rlProcessDMAStructArray

	sep #$20
	lda aDMAStructArray+structDMAToVRAMEntry.Source,b,y
	sta A1T7,b
	lda aDMAStructArray+structDMAToVRAMEntry.Source+1,b,y
	sta A1T7+1,b
	lda aDMAStructArray+structDMAToVRAMEntry.Source+2,b,y
	sta A1T7+2,b
	lda aDMAStructArray+structDMAToVRAMEntry.Count,b,y
	sta DAS7,b
	lda aDMAStructArray+structDMAToVRAMEntry.Count+1,b,y
	sta DAS7+1,b
	lda aDMAStructArray+structDMAToVRAMEntry.Mode,b,y
	sta VMAIN,b
	lda aDMAStructArray+structDMAToVRAMEntry.Dest,b,y
	sta VMADD,b
	lda aDMAStructArray+structDMAToVRAMEntry.Dest+1,b,y
	sta VMADD+1,b
	lda #DMAPx_Setting(DMAPx_TransferCPUToIO, DMAPx_Mode1, DMAPx_ABusIncrement, DMAPx_Direct)
	sta DMAP7,b
	lda #VMDATA - PPU_REG_BASE
	sta BBAD7,b
	lda #MDMAEN_Setting(False, False, False, False, False, False, False, True)
	sta MDMAEN,b
	rep #$20
	tya
	clc
	adc #size(structDMAToVRAMEntry)
	tay
	jmp _DMALoop

	_FromVRAM ; 80/AD8E

	.al
	.xl
	.autsiz
	.databank `rlProcessDMAStructArray

	sep #$20
	lda aDMAStructArray+structDMAFromVRAMEntry.Dest,b,y
	sta A1T7,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Dest+1,b,y
	sta A1T7+1,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Dest+2,b,y
	sta A1T7+2,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Count,b,y
	sta DAS7,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Count+1,b,y
	sta DAS7+1,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Mode,b,y
	sta VMAIN,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Source,b,y
	sta VMADD,b
	lda aDMAStructArray+structDMAFromVRAMEntry.Source+1,b,y
	sta VMADD+1,b
	lda #WMADD - PPU_REG_BASE
	sta DMAP7,b
	lda #RDVRAM - PPU_REG_BASE ; to RDVRAM
	sta BBAD7,b
	lda RDVRAM,b ; dummy read?
	lda RDVRAM+1,b
	lda #MDMAEN_Setting(False, False, False, False, False, False, False, True)
	sta MDMAEN,b
	rep #$20
	tya
	clc
	adc #size(structDMAFromVRAMEntry)
	tay
	jmp _DMALoop

	_InputDest ; 80/ADE0

	.al
	.xl
	.autsiz
	.databank `rlProcessDMAStructArray

	sep #$20
	lda aDMAStructArray+structDMAInputDestEntry.Source,b,y
	sta A1T7,b
	lda aDMAStructArray+structDMAInputDestEntry.Source+1,b,y
	sta A1T7+1,b
	lda aDMAStructArray+structDMAInputDestEntry.Source+2,b,y
	sta A1T7+2,b
	lda aDMAStructArray+structDMAInputDestEntry.Count,b,y
	sta DAS7,b
	lda aDMAStructArray+structDMAInputDestEntry.Count+1,b,y
	sta DAS7+1,b
	lda aDMAStructArray+structDMAInputDestEntry.Param,b,y
	sta DMAP7,b
	lda aDMAStructArray+structDMAInputDestEntry.Port,b,y
	sta BBAD7,b
	lda aDMAStructArray+structDMAInputDestEntry.Mode,b,y
	sta VMAIN,b
	lda aDMAStructArray+structDMAInputDestEntry.Dest,b,y
	sta VMADD,b
	lda aDMAStructArray+structDMAInputDestEntry.Dest+1,b,y
	sta VMADD+1,b
	lda #MDMAEN_Setting(False, False, False, False, False, False, False, True)
	sta MDMAEN,b
	rep #$20
	tya
	clc
	adc #size(structDMAInputDestEntry)
	tay
	jmp _DMALoop

rlDMAByStruct ; 80/AE2E

	.autsiz
	.databank ?

	; Appends a DMA struct immediately following
	; the jsl to this routine to the DMA array and then
	; attempts to process the array. This routine will
	; jump over the inlined struct when it returns.

	; Inputs:
	; DMA struct after jsl, i.e.:
	; jsl rlDMAByStruct
	; .dstruct structDMAToVRAM, $7E0000, $0080, VMAIN_Setting(True), $E000
	; plp
	; rtl

	; Outputs:
	; None

	php
	phb
	sep #$20
	lda lDMAByStructReturnLocation+2 ; bank
	pha
	plb

	.databank ?

	rep #$30
	lda lDMAByStructReturnLocation ; offset
	tax
	ldy wNextDMAArrayStructOffs,b
	sep #$20

	; Get transfer type

	lda $0001,b,x
	inc x
	sta aDMAStructArray,b,y

	; Copy to array based on type

	dec a
	bne +

	jmp _CGRAM

	+
	dec a
	bne +

	jmp _VRAM

	+
	dec a
	bne +
	jmp _VRAM

	+
	dec a

	bne _VRAM

	jmp _Input

	_VRAM

	.as
	.xl
	.autsiz
	.databank ?

	; Either to or from VRAM

	; Cap new end of array

	lda #$00
	sta aDMAStructArray+size(structDMAToVRAM),b,y

	; Append the entry

	rep #$20
	lda $0001,b,x
	sta aDMAStructArray+1,b,y
	lda $0003,b,x
	sta aDMAStructArray+3,b,y
	lda $0005,b,x
	sta aDMAStructArray+5,b,y
	lda $0007,b,x
	sta aDMAStructArray+7,b,y

	; Adjust return location on stack

	txa
	clc
	adc #size(structDMAToVRAM)-1
	sta lDMAByStructReturnLocation
	tya
	clc
	adc #size(structDMAToVRAM)
	bra _DoDMA

	_Input

	.as
	.xl
	.autsiz
	.databank ?

	; Same as above

	lda #$00
	sta aDMAStructArray+size(structDMAInputDest),b,y
	rep #$20
	lda $0001,b,x
	sta aDMAStructArray+1,b,y
	lda $0003,b,x
	sta aDMAStructArray+3,b,y
	lda $0005,b,x
	sta aDMAStructArray+5,b,y
	lda $0007,b,x
	sta aDMAStructArray+7,b,y
	lda $0009,b,x
	sta aDMAStructArray+9,b,y
	txa
	clc
	adc #size(structDMAInputDest)-1
	sta lDMAByStructReturnLocation
	tya
	clc
	adc #size(structDMAInputDest)
	bra _DoDMA

	_CGRAM

	.as
	.xl
	.autsiz
	.databank ?

	lda #$00
	sta aDMAStructArray+size(structDMAToCGRAM),b,y
	rep #$20
	lda $0001,b,x
	sta aDMAStructArray+1,b,y
	lda $0003,b,x
	sta aDMAStructArray+3,b,y
	lda $0005,b,x
	sta aDMAStructArray+5,b,y
	txa
	clc
	adc #size(structDMAToCGRAM)-1
	sta #$03,s
	tya
	clc
	adc #size(structDMAToCGRAM)

	_DoDMA

	.autsiz
	.databank ?

	; Update array size

	sta wNextDMAArrayStructOffs,b

	; Set flag and try DMA

	sep #$30
	lda #$01
	sta bDMAArrayFlag,b

	lda bBuf_INIDISP
	bpl _End

	jsl rlProcessDMAStructArray

	_End
	plb
	plp
	rtl

rlDMAByPointer ; 80/AEF9

	.xl
	.autsiz
	.databank ?

	; Appends a DMA struct to the DMA array
	; based on inputs and then tries to process
	; the array. This transfer is always to VRAM.

	; Inputs:
	; wR0: Size of transfer
	; wR1: Destination
	; lR18: Source

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	ldx wNextDMAArrayStructOffs,b

	sep #$20
	lda #$02 ; Type: To VRAM
	sta aDMAStructArray+structDMAToVRAMEntry.Type,b,x

	rep #$20
	lda lR18
	sta aDMAStructArray+structDMAToVRAMEntry.Source,b,x
	lda lR18+1
	sta aDMAStructArray+structDMAToVRAMEntry.Source+1,b,x

	lda wR0
	sta aDMAStructArray+structDMAToVRAMEntry.Count,b,x

	sep #$20
	lda #VMAIN_Setting(True, VMAIN_TranslationNone, VMAIN_Step1)
	sta aDMAStructArray+structDMAToVRAMEntry.Mode,b,x

	rep #$20
	lda wR1
	sta aDMAStructArray+structDMAToVRAMEntry.Dest,b,x

	; Cap end of array

	lda #$0000
	sta aDMAStructArray+size(structDMAToVRAMEntry),b,x

	; Advance an entry

	txa
	clc
	adc #size(structDMAToVRAMEntry)
	sta wNextDMAArrayStructOffs,b

	; Set flag and try DMA

	sep #$20
	lda #$01
	sta bDMAArrayFlag,b

	lda bBuf_INIDISP
	bpl _End

	jsl rlProcessDMAStructArray

	_End
	plp
	plb
	rtl

rlDMAByPointerStep32 ; 80/AF46

	.xl
	.autsiz
	.databank ?

	; Same as the previous routine but
	; this is used for horizontal scrolling,
	; as the increment size is 32

	; Inputs:
	; wR0: Size of transfer
	; wR1: Destination
	; lR18: Source

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	ldx wNextDMAArrayStructOffs,b

	sep #$20
	lda #$02
	sta aDMAStructArray+structDMAToVRAMEntry.Type,b,x

	rep #$20
	lda lR18
	sta aDMAStructArray+structDMAToVRAMEntry.Source,b,x
	lda lR18+1
	sta aDMAStructArray+structDMAToVRAMEntry.Source+1,b,x
	lda wR0
	sta aDMAStructArray+structDMAToVRAMEntry.Count,b,x
	sep #$20
	lda #VMAIN_Setting(True, VMAIN_TranslationNone, VMAIN_Step32)
	sta aDMAStructArray+structDMAToVRAMEntry.Mode,b,x
	rep #$20
	lda wR1
	sta aDMAStructArray+structDMAToVRAMEntry.Dest,b,x
	lda #$0000
	sta aDMAStructArray+size(structDMAToVRAMEntry),b,x
	txa
	clc
	adc #size(structDMAToVRAMEntry)
	sta wNextDMAArrayStructOffs,b

	sep #$20
	lda #$01
	sta bDMAArrayFlag,b
	lda bBuf_INIDISP
	bpl _End

	jsl rlProcessDMAStructArray

	_End
	plp
	plb
	rtl
