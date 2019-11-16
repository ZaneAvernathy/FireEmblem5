
rlFadeInByTimer ; 80/AB89

	.autsiz
	.databank ?

	; Fades in with settable time between changes

	; Inputs:
	; A: Frames between intensity step

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	sta wScreenBrightnessTimeIncrement,b

	; Check if we need to change brightness

	lda wScreenBrightnessFlag,b
	bpl +

	; Reset timer and flag

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	stz wScreenBrightnessFlag,b

	+
	lda bBuf_INIDISP
	and #15
	cmp #INIDISP_Setting(False, 15)
	beq _MaxBrightness ; If max brightness

	; dec timer

	dec wScreenBrightnessTimer,b
	bne _NotTime

	; If time to change brightness

	; reset timer

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b

	; increment brightness

	lda bBuf_INIDISP
	inc a
	and #15
	sta bBuf_INIDISP

	_NotTime
	plp
	plb
	clc
	rtl

	_MaxBrightness
	lda #-1
	sta wScreenBrightnessFlag,b
	plp
	plb
	sec
	rtl

rlFadeOutByTimer ; 80/ABC7

	.autsiz
	.databank ?

	; Fades out with settable time between changes

	; Inputs:
	; A: Frames between intensity step

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	sta wScreenBrightnessTimeIncrement,b

	; Check if we need to change brightness

	lda wScreenBrightnessFlag,b
	bpl +

	; Reset timer and flag

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	stz wScreenBrightnessFlag,b

	+
	lda bBuf_INIDISP
	and #15
	beq _MinBrightness ; If min brightness

	; dec timer

	dec wScreenBrightnessTimer,b
	bne _NotTime

	; If time to change brightness

	; reset timer

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b

	; decrement brightness

	lda bBuf_INIDISP
	dec a
	and #15
	sta bBuf_INIDISP

	_NotTime
	plp
	plb
	clc
	rtl

	_MinBrightness
	lda #-1
	sta wScreenBrightnessFlag,b
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	plp
	plb
	sec
	rtl

rlFadeOutColorByTimer ; 80/AC07

	.autsiz
	.databank ?

	; Fades colors out with settable time between changes

	; Inputs:
	; A: Frames between intensity step

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	sta wScreenBrightnessTimeIncrement,b

	; Check if we need to change brightness

	lda wScreenBrightnessFlag,b
	bpl +

	; Reset timer

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	lda #COLDATA_Setting(31, True, True, True)
	sta bBuf_COLDATA_0 ; color base?
	stz bBuf_COLDATA_1 ; b?
	stz bBuf_COLDATA_2 ; g?
	stz wScreenBrightnessFlag,b

	+
	lda bBuf_COLDATA_0 ; get intensity of colors
	and #COLDATA.Intensity
	beq _MinIntensity

	; dec timer

	dec wScreenBrightnessTimer,b
	bne +

	; decrement intensity and set all channels to be affected

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	lda bBuf_COLDATA_0
	and #COLDATA.Intensity
	dec a
	ora #COLDATA_Setting(0, True, True, True)
	sta bBuf_COLDATA_0

	+
	plp
	plb
	clc
	rtl

	_MinIntensity
	lda #-1
	sta wScreenBrightnessFlag,b
	plp
	plb
	sec
	rtl

rlFadeInColorByTimer ; 80/AC4D

	.autsiz
	.databank ?

	; Fades colors in with settable time between changes

	; Inputs:
	; A: Frames between intensity step

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	sta wScreenBrightnessTimeIncrement,b

	; Check if we need to change brightness

	lda wScreenBrightnessFlag,b
	bpl +

	; Reset timer

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	lda #COLDATA_Setting(0, True, True, True)
	sta bBuf_COLDATA_0
	stz bBuf_COLDATA_1
	stz bBuf_COLDATA_2
	stz wScreenBrightnessFlag,b

	+
	lda bBuf_COLDATA_0
	and #COLDATA.Intensity
	cmp #COLDATA.Intensity
	beq _MaxIntensity

	dec wScreenBrightnessTimer,b
	bne _NotTime

	lda wScreenBrightnessTimeIncrement,b
	sta wScreenBrightnessTimer,b
	lda bBuf_COLDATA_0
	and #COLDATA.Intensity
	inc a
	ora #COLDATA_Setting(0, True, True, True)
	sta bBuf_COLDATA_0

	_NotTime
	plp
	plb
	clc
	rtl

	_MaxIntensity
	lda #-1
	sta wScreenBrightnessFlag,b
	plp
	plb
	sec
	rtl
