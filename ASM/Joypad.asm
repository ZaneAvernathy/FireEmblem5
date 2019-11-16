
rlGetJoypadInput ; 80/8002

	.autsiz
	.databank ?

	; Reads joypad input every frame.

	; You shouldn't call this yourself.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	sep #$20

	; Wait for controllers

	-
	lda HVBJOY,b
	and #HVBJOY.AutoJoypadFlag
	bne -

	rep #$20

	; Controller 1

	; Fetch inputs, discard input from non-controllers

	lda JOY1,b
	sta wJoy1Input
	and #JoypadID
	beq +

	lda wJoy1Old
	sta wJoy1Input

	+

	; Strip strictly-new inputs

	lda wJoy1Input
	eor wJoy1Old
	and wJoy1Input
	sta wJoy1New
	sta wJoy1Alt

	; Check if a button is held
	; and if it is the same combination
	; as the previous read

	lda wJoy1Input
	beq +

	cmp wJoy1Old
	bne +

	; While the combination is the same
	; have a timer run out

	dec wJoy1PressTime
	bne ++

	; Once this timer runs out, set it
	; to a shorter timer

	lda wJoy1Input
	sta wJoy1Alt
	lda wJoyShortTime
	sta wJoy1PressTime
	bra ++

	+

	; Reset press time to long

	lda wJoyLongTime
	sta wJoy1PressTime

	+

	; Overwrite the previous check's
	; input

	lda wJoy1Input
	sta wJoy1Old

	; Controller 2

	; Same as previous

	lda JOY2,b
	sta wJoy2Input
	and #JoypadID
	beq +

	lda wJoy2Old
	sta wJoy2Input

	+
	lda wJoy2Input
	eor wJoy2Old
	and wJoy2Input
	sta wJoy2New
	sta wJoy2Alt

	lda wJoy2Input
	beq +

	cmp wJoy2Old
	bne +

	dec wJoy2PressTime
	bne ++

	lda wJoy2Input
	sta wJoy2Alt
	lda wJoyShortTime
	sta wJoy2PressTime
	bra ++

	+
	lda wJoyLongTime
	sta wJoy2PressTime

	+
	lda wJoy2Input
	sta wJoy2Old

	plp
	rtl
