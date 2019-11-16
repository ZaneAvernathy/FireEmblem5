
structChapterDataTableEntry .struct TilesetGraphics, TilesetConfig, TilesetPalette, Map, MapChanges, StartingPositions, ObjectiveMarkers, VisionRange, PrepScreen, MinUnits, MaxUnits, PlayerAllegiance, EnemyAllegiance, NPCAllegiance, Unknown, PlayerPhaseMusic, EnemyPhaseMusic, NPCPhaseMusic, AlternateGraphics, TilesetAnimations
	TilesetGraphics		.long \TilesetGraphics
	.long 0, 0
	TilesetConfig		.long \TilesetConfig
	TilesetPalette		.long \TilesetPalette
	Map					.long \Map
	MapChanges			.long \MapChanges
	StartingPositions	.long \StartingPositions
	ObjectiveMarkers	.long \ObjectiveMarkers
	.word 0, 7, 0, 7
	VisionRange			.byte \VisionRange
	PrepScreen			.byte \PrepScreen
	MinUnits			.byte \MinUnits
	MaxUnits			.byte \MaxUnits
	PlayerAllegiance	.byte \PlayerAllegiance
	EnemyAllegiance		.byte \EnemyAllegiance
	NPCAllegiance		.byte \NPCAllegiance
	Unknown				.byte \Unknown
	PlayerPhaseMusic	.byte \PlayerPhaseMusic
	EnemyPhaseMusic		.byte \EnemyPhaseMusic
	NPCPhaseMusic		.byte \NPCPhaseMusic
	AlternateGraphics	.long \AlternateGraphics
	TilesetAnimations	.long \TilesetAnimations
	.ends
