
; Looks like a proc but as a pointer to
; ASM instead of proc code?

procUnknown958000 .dstruct structProcInfo, "MM", rlProcUnknown958000Init, rlProcUnknown958000OnCycle, rlProcUnknown958000Code ; 95/8000

rlProcUnknown958000Init ; 95/8008

	.autsiz
	.databank ?

	rtl

rlProcUnknown958000OnCycle ; 95/8009

	.autsiz
	.databank ?

	rtl

rlProcUnknown958000Code ; 95/800A

	.autsiz
	.databank ?

	rtl
