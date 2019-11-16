
procUnknown81E817 .dstruct structProcInfo, None, rlProcUnknown81E817Init, rlProcUnknown81E817OnCycle, None ; 81/E817

rlProcUnknown81E817Init ; 81/E81F

	.al
	.xl
	.autsiz
	.databank `wPrepItemsActionIndex

	lda wProcInput0,b
	sta aProcBody0,b,x
	lda #$0004
	sta aProcBody1,b,x
	rtl

rlProcUnknown81E817OnCycle ; 81/E82C

	.al
	.xl
	.autsiz
	.databank `wPrepItemsActionIndex

	lda wBuf_BG3VOFS
	sec
	sbc aProcBody0,b,x
	sta wBuf_BG3VOFS
	dec aProcBody1,b,x
	bne +

	jsl rlProcEngineFreeProc

	+
	rtl
