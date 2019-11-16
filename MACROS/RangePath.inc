
structRangePathEntry .struct
	TargetTile				.word ? ; $00
	.union
		EndFlag				.word ? ; $02
		.struct
			TargetDirection	.byte ? ; $02
			TargetCost		.byte ? ; $03
		.ends
	.endu
	.ends
