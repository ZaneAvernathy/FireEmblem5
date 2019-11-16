
; This proc's code field overlaps its init function

.union

procBattleForecastCenterShadingHBounds .dstruct structProcInfo, None, rlProcBattleForecastCenterShadingHBoundsInit, rlProcBattleForecastCenterShadingHBoundsOnCycle, ?

.struct

.fill 6

rlProcBattleForecastCenterShadingHBoundsInit ; 81/C1BE

	.al
	.xl
	.autsiz
	.databank ?

	; Side

	lda wProcInput0,b
	sta aProcBody0,b,x

	rtl

.ends
.endu

rlProcBattleForecastCenterShadingHBoundsOnCycle ; 81/C1C5

	.al
	.xl
	.autsiz
	.databank ?

	; Wait a cycle

	lda #<>rlProcBattleForecastCenterShadingHBoundsOnCycle2
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcBattleForecastCenterShadingHBoundsOnCycle2 ; 81/C1CC

	.al
	.xl
	.autsiz
	.databank ?

	; Use side to get horizontal start, stop pixels
	; for center window shading

	phx
	lda aProcBody0,b,x
	tax
	lda aBattleForecastWindowCenterShadingBounds,x
	jsl $8594C9
	plx
	jsl rlProcEngineFreeProc
	rtl

aBattleForecastWindowCenterShadingBounds ; 81/C1DF
	.byte  32,  64
	.byte 192, 224
