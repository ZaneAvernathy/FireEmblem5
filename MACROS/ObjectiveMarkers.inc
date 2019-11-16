
structObjectiveMarkerEntryRAM .struct
	X		.word ?
	Y		.word ?
	Sprite	.word ?
	Tile	.word ?
	.ends

structObjectiveMarkerEntry .struct Coordinates, Sprite
	.if type(\Coordinates) == type(?)
		.byte ?, ?
	.else
	.byte \Coordinates[0], \Coordinates[1]
	.endif
	.byte \Sprite
	.ends

structObjectiveMarkerArray .struct Color, EntryList
	.byte \Color
	.if type(\EntryList) != type(?)
		.for i in range(len(\EntryList))
			.dstruct structObjectiveMarkerEntry, \EntryList[i][0], \EntryList[i][1]
		.next
	.endif
	.byte 0
	.ends
