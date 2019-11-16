
	WinLossOffsets := [$FF] x 342

	WinLossOffsets := Modify(Leif,		$00, WinLossOffsets)
	WinLossOffsets := Modify(Finn,		$01, WinLossOffsets)
	WinLossOffsets := Modify(Orsin,		$02, WinLossOffsets)
	WinLossOffsets := Modify(Halvan,	$03, WinLossOffsets)
	WinLossOffsets := Modify(Eyvel,		$04, WinLossOffsets)
	WinLossOffsets := Modify(Dagdar,	$05, WinLossOffsets)
	WinLossOffsets := Modify(Ralph,		$06, WinLossOffsets)
	WinLossOffsets := Modify(Marty,		$07, WinLossOffsets)
	WinLossOffsets := Modify(Ronan,		$08, WinLossOffsets)
	WinLossOffsets := Modify(Miranda,	$09, WinLossOffsets)
	WinLossOffsets := Modify(Sapphie,	$0A, WinLossOffsets)
	WinLossOffsets := Modify(Lara,		$0B, WinLossOffsets)
	WinLossOffsets := Modify(Brighton,	$0C, WinLossOffsets)
	WinLossOffsets := Modify(Fergus,	$0D, WinLossOffsets)
	WinLossOffsets := Modify(Eda,		$0E, WinLossOffsets)
	WinLossOffsets := Modify(Asvel,		$0F, WinLossOffsets)
	WinLossOffsets := Modify(Matria,	$10, WinLossOffsets)
	WinLossOffsets := Modify(Hicks,		$11, WinLossOffsets)
	WinLossOffsets := Modify(Nanna,		$12, WinLossOffsets)
	WinLossOffsets := Modify(Selphina,	$13, WinLossOffsets)
	WinLossOffsets := Modify(Dahlson,	$14, WinLossOffsets)
	WinLossOffsets := Modify(Callion,	$15, WinLossOffsets)
	WinLossOffsets := Modify(Shiva,		$16, WinLossOffsets)
	WinLossOffsets := Modify(Pan,		$17, WinLossOffsets)
	WinLossOffsets := Modify(Glade,		$18, WinLossOffsets)
	WinLossOffsets := Modify(Kane,		$19, WinLossOffsets)
	WinLossOffsets := Modify(Alba,		$1A, WinLossOffsets)
	WinLossOffsets := Modify(Robert,	$1B, WinLossOffsets)
	WinLossOffsets := Modify(Fred,		$1C, WinLossOffsets)
	WinLossOffsets := Modify(Olwen,		$1D, WinLossOffsets)
	WinLossOffsets := Modify(CedChp23,	$1E, WinLossOffsets)
	WinLossOffsets := Modify(Lithis,	$1F, WinLossOffsets)
	WinLossOffsets := Modify(Karin,		$20, WinLossOffsets)
	WinLossOffsets := Modify(Dean,		$21, WinLossOffsets)
	WinLossOffsets := Modify(Shanam,	$22, WinLossOffsets)
	WinLossOffsets := Modify(Trude,		$23, WinLossOffsets)
	WinLossOffsets := Modify(Tanya,		$24, WinLossOffsets)
	WinLossOffsets := Modify(Linoan,	$25, WinLossOffsets)
	WinLossOffsets := Modify(Mischa,	$22, WinLossOffsets)
	WinLossOffsets := Modify(Salem,		$26, WinLossOffsets)
	WinLossOffsets := Modify(Schroff,	$09, WinLossOffsets)
	WinLossOffsets := Modify(Mareeta,	$27, WinLossOffsets)
	WinLossOffsets := Modify(Tina,		$28, WinLossOffsets)
	WinLossOffsets := Modify(Amalda,	$29, WinLossOffsets)
	WinLossOffsets := Modify(Conomore,	$29, WinLossOffsets)
	WinLossOffsets := Modify(Homer,		$2A, WinLossOffsets)
	WinLossOffsets := Modify(Dermott,	$2B, WinLossOffsets)
	WinLossOffsets := Modify(Sarah,		$2C, WinLossOffsets)
	WinLossOffsets := Modify(Saias,		$2D, WinLossOffsets)
	WinLossOffsets := Modify(Galzus,	$2E, WinLossOffsets)
	WinLossOffsets := Modify(Ilios,		$1D, WinLossOffsets)
	WinLossOffsets := Modify(Xavier,	$2F, WinLossOffsets)

aWinLossOffsetsTable ; 81/C9DD

	.for offset in WinLossOffsets

		.byte offset

	.next

