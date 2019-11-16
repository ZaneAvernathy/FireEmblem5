
procPrepItemsTradeInitiatorCursor .dstruct structProcInfo, None, rlProcPrepItemsTradeInitiatorCursorInit, rlProcPrepItemsTradeInitiatorCursorOnCycle, None ; 81/F108

rlProcPrepItemsTradeInitiatorCursorInit ; 81/F110

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcPrepItemsTradeInitiatorCursorOnCycle ; 81/F111

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wPrepUnitListLastSelectedColumn
	pha
	rep #$20
	plb

	.databank `wPrepUnitListLastSelectedColumn

	lda wPrepUnitListLastSelectedColumn
	sta wR0

	lda wPrepUnitListLastSelectedRow
	sta wR1

	jsl $85FB23
	plb
	plp
	rtl
