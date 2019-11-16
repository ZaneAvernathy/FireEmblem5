
riVBlankInterruptN ; 80/81B6

	.autsiz
	.databank ?

	; Handles VBlank.
	; You shouldn't call this yourself.

	; Inputs:
	; Short pointer to things to do in wUnknown0000D3

	; Outputs:
	; None

	cli
	rep #$30
	jml +

	+
	phb
	phd
	pha
	phx
	phy
	lda #$0000
	tcd
	phk
	plb

	.databank `*

	lda RDNMI,b
	lda wUnknown0000D9
	bpl +

	jmp _8A20


	+
	ora #$8000
	sta wUnknown0000D9

	.for i=wR0, i<=wR26-2, i+=2

	lda i
	pha

	.next

	pea #<>(+)-1
	jmp (wUnknown0000D3)

	+
	jsl $838E5B

	.for i=wR26-2, i>=wR0, i-=2

	pla
	sta i

	.next

	inc wUnknown0000DB
	ply
	plx
	pla
	pld
	stz wUnknown0000D9,b
	plb
	rti

	_8A20
	inc wUnknown0000DD
	jsl rlUnknown808D9C
	jsl rlCopyINIDISPBuffer
	jsl $838E5B
	ply
	plx
	pla
	pld
	plb
	rti

riIRQInterruptN ; 80/82B4

	.autsiz
	.databank ?

	; Handles IRQs.
	; You shouldn't call this yourself.

	; Inputs:
	; Short pointer to things to do in wUnknown0000D5

	; Outputs:
	; None

	rep #$30

	jml +

	+
	phb
	phd
	pha
	phx
	phy
	phk
	plb

	.databank `*

	lda #$0000
	tcd
	lda TIMEUP,b
	bit #TIMEUP.IRQFlag
	beq +
	pea #<>(+)-1
	jmp (wUnknown0000D5)

	+
	ply
	plx
	pla
	pld
	plb
	rti

rsUnknown8082D9 ; 80/82D9

	.autsiz
	.databank ?

	rts

rlEnableVBlank ; 80/82DA

	.autsiz
	.databank ?

	; Enables VBlank.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	sep #$20
	lda bBuf_NMITIMEN
	ora #NMITIMEN.VBlankEnable
	sta bBuf_NMITIMEN
	sta NMITIMEN,b
	plp
	rtl

rlDisableVBlank ; 80/82E8

	.autsiz
	.databank ?

	; Disables VBlank.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	sep #$20
	lda bBuf_NMITIMEN
	and #~NMITIMEN.VBlankEnable
	sta bBuf_NMITIMEN
	sta NMITIMEN,b
	plp
	rtl

rlHaltUntilVBlank ; 80/82F6

	.autsiz
	.databank ?

	; Waits until next VBlank.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	lda wUnknown0000DB

	-
	cmp wUnknown0000DB
	beq -

	plp
	rtl

rlEnableForcedBlank ; 80/82FF

	.autsiz
	.databank ?

	; Enables forced blank, waits a frame.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	sep #$20
	lda bBuf_INIDISP
	ora #INIDISP.ForcedBlank
	sta bBuf_INIDISP
	jsl rlHaltUntilVBlank
	plb
	plp
	rtl

rlDisableForcedBlank ; 80/8312

	.autsiz
	.databank ?

	; Disables forced blank, waits a frame.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	sep #$20
	lda bBuf_INIDISP
	and #~INIDISP.ForcedBlank
	sta bBuf_INIDISP
	jsl rlHaltUntilVBlank
	plb
	plp
	rtl
