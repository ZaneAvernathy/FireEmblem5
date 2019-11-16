
procUnknown838196 .dstruct structProcInfo, "SC", rlProcUnknown838196Init, rlProcUnknown838196OnCycle, None ; 83/8196

rlProcUnknown838196Init ; 83/819E

	.al
	.xl
	.autsiz
	.databank ?

	jsl $858466
	rtl

rlProcUnknown838196OnCycle ; 83/81A3

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000E6D,b
	bne +

	jsl rlProcEngineFreeProc
	jsl $85847C

	+
	rtl
