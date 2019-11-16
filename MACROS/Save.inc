
structSaveDataHeader .struct
	LastFile			.byte ?
	LastSuspend			.byte ?
	CompletionCount		.byte ?
	CompletionFlag		.byte ?
	IrregularityFlag	.word ?
						.word ?
	.ends

structSaveDataEntry .struct
	MagicNumber					.word ? ; $0000
	Checksum					.word ? ; $0002
	Unknown						.word ? ; $0004
	GameTime					.word ? ; $0006
	MenuPressCounter			.word ? ; $0008
	CurrentChapter				.byte ? ; $000A
	CurrentTurn					.word ? ; $000B
	Options .block						; $000D
		TileSettingIndex		.word ? ; $000D
		TileSetting1UpperRed	.word ? ; $000F
		TileSetting1UpperGreen	.word ? ; $0011
		TileSetting1UpperBlue	.word ? ; $0013
		TileSetting1LowerRed	.word ? ; $0015
		TileSetting1LowerGreen	.word ? ; $0017
		TileSetting1LowerBlue	.word ? ; $0019
		TileSetting2UpperRed	.word ? ; $001B
		TileSetting2UpperGreen	.word ? ; $001D
		TileSetting2UpperBlue	.word ? ; $001F
		TileSetting2LowerRed	.word ? ; $0021
		TileSetting2LowerGreen	.word ? ; $0023
		TileSetting2LowerBlue	.word ? ; $0025
		TileSetting3UpperRed	.word ? ; $0027
		TileSetting3UpperGreen	.word ? ; $0029
		TileSetting3UpperBlue	.word ? ; $002B
		TileSetting3LowerRed	.word ? ; $002D
		TileSetting3LowerGreen	.word ? ; $002F
		TileSetting3LowerBlue	.word ? ; $0031
		TileSetting4UpperRed	.word ? ; $0033
		TileSetting4UpperGreen	.word ? ; $0035
		TileSetting4UpperBlue	.word ? ; $0037
		TileSetting4LowerRed	.word ? ; $0039
		TileSetting4LowerGreen	.word ? ; $003B
		TileSetting4LowerBlue	.word ? ; $003D
		TileSetting5UpperRed	.word ? ; $003F
		TileSetting5UpperGreen	.word ? ; $0041
		TileSetting5UpperBlue	.word ? ; $0043
		TileSetting5LowerRed	.word ? ; $0045
		TileSetting5LowerGreen	.word ? ; $0047
		TileSetting5LowerBlue	.word ? ; $0049
		AnimationSetting		.word ? ; $004B
		TerrainSetting			.word ? ; $004D
		BurstSetting			.word ? ; $004F
		TextSpeedSetting		.word ? ; $0051
		UnitSpeedSetting		.word ? ; $0053
		SoundSetting			.word ? ; $0055
		BGMSetting				.word ? ; $0057
		AutocursorSetting		.word ? ; $0059
		Volume					.word ? ; $005B
	.bend
	DefaultVisibility			.byte ? ; $005D
	VisionRange					.byte ? ; $005E
	CurrentPhase				.byte ? ; $005F
	Gold						.long ? ; $0060
	HorizontalScroll			.word ? ; $0063
	VerticalScroll				.word ? ; $0065
	CursorX						.byte ? ; $0067
	CursorY						.byte ? ; $0068
	BossID						.word ? ; $0069
	Wins						.word ? ; $006B
	Captures					.word ? ; $006D
	AllegianceInfo .block				; $006F
		AlliedAllegiance		.byte ? ; $006F
		EnemyAllegiance			.byte ? ; $0070
		NPCAllegiance			.byte ? ; $0071
								.byte ? ; $0072
		PlayerPhaseController	.byte ? ; $0073
		EnemyPhaseController	.byte ? ; $0074
		NPCPhaseController		.byte ? ; $0075
								.byte ? ; $0076
	.bend
	PermanentEventFlags			.fill 5 ; $0077
	TemporaryEventFlags			.fill 12 ; $007C
	RandomizedItems				.fill 2 * 16 ; $0088
	RandomizedNumbers			.fill 64 ; $00A8
	AllyUnits					.fill size(structCharacterDataRAM) * 48 ; $00E8
	EnemyUnits					.fill size(structCharacterDataRAM) * 51 ; $0D18
	NPCUnits					.fill size(structCharacterDataRAM) * 16 ; $1A0B
	Convoy						.fill 2 * 128 ; 1E1B
	LossesTable					.fill 49 ; $1F1B
	WinsTable					.fill 49 ; $1F4C
	TurncountsTable				.fill size(structTurncountEntryRAM) * 40 ; $1F7D
	ParagonFlag					.word ? ; $1FF5
								.byte ? ; $1FF7
	.ends
