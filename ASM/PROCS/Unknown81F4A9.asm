
procUnknown81F4A9 .dstruct structProcInfo, None, rlProcUnknown81F4A9Init, rlProcUnknown81F4A9OnCycle, None ; 81/F4A9

rlProcUnknown81F4A9Init ; 81/F4B1

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcUnknown81F4A9OnCycle ; 81/F4B2

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlProcUnknown81F4A9OnCycle2
	sta aProcHeaderOnCycle,b,x

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (32 * $20)) * 2))

	rtl

rlProcUnknown81F4A9OnCycle2 ; 81/F4C6

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlProcEngineFreeProc
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG2TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($F000 + ((0 + (32 * $20)) * 2))

	rtl
