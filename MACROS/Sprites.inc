
structSpriteEntry .struct Coords, Unk, Size, Index, Prio, Pal, HFlip, VFlip
	.if type(\Coords) == type(?)
		xc := ?
		yc := ?
	.else
		xc := \Coords[0]
		yc := \Coords[1]
	.endif
	X		.byte (xc & $FF)
			.byte ((xc>>8) & 1) | \Unk & $7E | (\Size<<7)
	Y		.char yc
	Index	.byte \Index & $FF
	Attr	.byte ((\Index>>8) & 1) | ((\Pal & 7)<<1) | ((\Prio & 3)<<4) | (\HFlip<<6) | (\VFlip<<7)
	.ends

structSpriteEntryNoLabels .struct Coords, Unk, Size, Index, Prio, Pal, HFlip, VFlip
	.if type(\Coords) == type(?)
		xc := ?
		yc := ?
	.else
		xc := \Coords[0]
		yc := \Coords[1]
	.endif
	.byte (xc & $FF)
	.byte ((xc>>8) & 1) | \Unk & $7E | (\Size<<7)
	.char yc
	.byte \Index & $FF
	.byte ((\Index>>8) & 1) | ((\Pal & 7)<<1) | ((\Prio & 3)<<4) | (\HFlip<<6) | (\VFlip<<7)
	.ends

structSpriteArray .struct SpriteList
	.if type(\SpriteList) == type(?)
		; Assume all fields are holes
		SpriteCount .fill 2
		Sprites
	.else
	SpriteCount .word len(\SpriteList)
	Sprites
	.for i = 0, i < len(\SpriteList), i += 1
		.dstruct structSpriteEntryNoLabels, \SpriteList[i][0], \SpriteList[i][1], \SpriteList[i][2], \SpriteList[i][3], \SpriteList[i][4], \SpriteList[i][5], \SpriteList[i][6]
	.next
	.endif
	.ends

structPPUOAMEntry .struct
	X		.fill 1
	Y		.fill 1
	Index	.fill 1
	Attr	.fill 1
	.ends

structUnknownSpriteEntryRAM .struct
	SpriteListOffset	.word ?
	X					.word ?
	Y					.word ?
	SpriteBase			.word ?
	AttributeBase		.word ?
	SpriteListBank		.word ?
	.ends

structActiveSpriteInfo .struct Init, OnCycle, Code
	Init .word <>\Init
	OnCycle .word <>\OnCycle
	Code .word <>\Code
	.ends

OAMTileAndAttr .function TileIndex, Palette, Priority, XFlip, YFlip
	.endf TileIndex | (Palette << 9) | (Priority << 12) | (XFlip << 14) | (YFlip << 15)

structMapSpriteAndStatusEntry .struct
	X			.word ?
	Y			.word ?
	TileAndAttr	.word ?
	.ends
