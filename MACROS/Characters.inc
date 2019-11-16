
structCharacterDataRAM .struct
	Character				.word ? ; $00
	Class					.byte ? ; $02
	.union
		Coordinates			.word ? ; $03
		.struct
			X				.byte ? ; $03
			Y				.byte ? ; $04
		.ends
	.endu
	.union
		TurnStatus			.word ? ; $05
		.struct
			TurnStatus1		.byte ? ; $05
			TurnStatus2		.byte ? ; $06
		.ends
	.endu
	Level					.byte ? ; $07
	Experience				.byte ? ; $08
	MaxHP					.byte ? ; $09
	CurrentHP				.byte ? ; $0A
	Strength				.byte ? ; $0B
	Magic					.byte ? ; $0C
	Skill					.byte ? ; $0D
	Speed					.byte ? ; $0E
	Defense					.byte ? ; $0F
	Luck					.byte ? ; $10
	Constitution			.byte ? ; $11
	Rescue					.byte ? ; $12
	Movement				.byte ? ; $13
	Fatigue					.byte ? ; $14
	Status					.byte ? ; $15
	MagicBonus				.byte ? ; $16
	VisionBonus				.byte ? ; $17
	MovementStars			.byte ? ; $18
	LeadershipStars			.byte ? ; $19
	Leader					.word ? ; $1A
	Skills1					.byte ? ; $1C
	Skills2					.byte ? ; $1D
	Skills3					.byte ? ; $1E
	.union
		Items				.fill 7 * 2 ; $1F
		.struct
			Item1ID			.byte ? ; $1F
			Item1Durability	.byte ? ; $20
			Item2ID			.byte ? ; $21
			Item2Durability	.byte ? ; $22
			Item3ID			.byte ? ; $23
			Item3Durability	.byte ? ; $24
			Item4ID			.byte ? ; $25
			Item4Durability	.byte ? ; $26
			Item5ID			.byte ? ; $27
			Item5Durability	.byte ? ; $28
			Item6ID			.byte ? ; $29
			Item6Durability	.byte ? ; $2A
			Item7ID			.byte ? ; $2B
			Item7Durability	.byte ? ; $2C
		.ends
	.endu
	.union
		WeaponRanks			.fill 10 ; $2D
		.struct
			SwordRank		.byte ? ; $2D
			LanceRank		.byte ? ; $2E
			AxeRank			.byte ? ; $2F
			BowRank			.byte ? ; $30
			StaffRank		.byte ? ; $31
			FireRank		.byte ? ; $32
			ThunderRank		.byte ? ; $33
			WindRank		.byte ? ; $34
			LightRank		.byte ? ; $35
			DarkRank		.byte ? ; $36
		.ends
	.endu
	.union
		SpriteInfo			.fill 3 ; $37
		.struct
			SpriteInfo1		.byte ? ; $37
			SpriteInfo2		.word ? ; $38
		.ends
	.endu
	.union
		AI					.fill 4 ; $3A
		.struct
			AI1				.byte ? ; $3A
			AI2				.byte ? ; $3B
			AI3				.byte ? ; $3C
			AI4				.byte ? ; $3D
			Unknown3E		.byte ? ; $3E
			Unknown3F		.byte ? ; $3F
			Unknown40		.byte ? ; $40
		.ends
		.struct
			TotalEXP		.word ? ; $3A
			CapturedChapter	.byte ? ; $3C
							.fill 2 ; $3D
			CapturedTurn	.word ? ; $3F
		.ends
	.endu
	.ends

structExpandedCharacterDataRAM .struct
	.dstruct structCharacterDataRAM ; $00-$40
	DeploymentNumber		.byte ? ; $41
	DeploymentSlot			.word ? ; $42
	.ends

structActionStructEntry .struct
	.dstruct structExpandedCharacterDataRAM ; $00-$43
	BattleMight					.byte ? ; $44
	BattleDefense				.byte ? ; $45
	BattleAttackSpeed			.byte ? ; $46
	BattleHit					.byte ? ; $47
	BattleAvoid					.byte ? ; $48
	BattleAdjustedHit			.byte ? ; $49
	BattleCrit					.byte ? ; $4A
	BattleDodge					.byte ? ; $4B
	BattleAdjustedCrit			.byte ? ; $4C
	EquippedItemID1				.byte ? ; $4D
	EquippedItemID2				.byte ? ; $4E
	EquippedItemMaxDurability	.byte ? ; $4F
	EquippedItemInventoryIndex	.byte ? ; $50
	AttackType					.byte ? ; $51
	WeaponTraits				.byte ? ; $52
	TerrainType					.byte ? ; $53
	TerrainAvoid				.byte ? ; $54
	TerrainDefense				.byte ? ; $55
	TerrainHitAvoid				.byte ? ; $56
								.byte ? ; $57
	TerrainHitAvoidBonus		.byte ? ; $58
	Unknown59					.byte ? ; $59
	CriticalCoefficient			.byte ? ; $5A
	StartingExperience			.byte ? ; $5B
	GainedExperience			.byte ? ; $5C
	StartingMaxHP				.byte ? ; $5D
	StartingCurrentHP			.byte ? ; $5E
	StartingLevel				.byte ? ; $5F
	StartingClass				.byte ? ; $60
	UnkillableFlag				.byte ? ; $61
								.word ? ; $62
	LevelUpHPGain				.byte ? ; $64
	LevelUpStrengthGain			.byte ? ; $65
	LevelUpMagicGain			.byte ? ; $66
	LevelUpSkillGain			.byte ? ; $67
	LevelUpSpeedGain			.byte ? ; $68
	LevelUpDefenseGain			.byte ? ; $69
	LevelUpConstitutionGain		.byte ? ; $6A
	LevelUpLuckGain				.byte ? ; $6B
	LevelUpMovementGain			.byte ? ; $6C
	WeaponEXP					.byte ? ; $6D
	GainedWeaponEXP				.byte ? ; $6E
	WeaponEXPGainChance			.byte ? ; $6F
	PostBattleStatus			.byte ? ; $70
	.ends

structCharacterDataROMEntry .struct HPOrAutolevel=?, Strength=?, Magic=?, Skill=?, Speed=?, Defense=?, Constitution=?, Luck=?, Movement=?, MovementStars=?, CriticalCoefficient=?, HPGrowth=?, StrengthGrowth=?, MagicGrowth=?, SkillGrowth=?, SpeedGrowth=?, DefenseGrowth=?, ConstitutionGrowth=?, LuckGrowth=?, MovementGrowth=?, SwordRank=?, LanceRank=?, AxeRank=?, BowRank=?, StaffRank=?, FireRank=?, ThunderRank=?, WindRank=?, LightRank=?, DarkRank=?, SwordEXPModifier=?, LanceEXPModifier=?, AxeEXPModifier=?, BowEXPModifier=?, StaffEXPModifier=?, FireEXPModifier=?, ThunderEXPModifier=?, WindEXPModifier=?, LightEXPModifier=?, DarkEXPModifier=?, Gender=?, Skills1=?, Skills2=?, Skills3=?, Class=?, LeadershipStars=?, MapSprite=?, Portrait=?
	HPOrAutolevel		.char \HPOrAutolevel			; $00
	Strength			.byte \Strength					; $01
	Magic				.byte \Magic					; $02
	Skill				.byte \Skill					; $03
	Speed				.byte \Speed					; $04
	Defense				.byte \Defense					; $05
	Constitution		.byte \Constitution				; $06
	Luck				.byte \Luck						; $07
	Movement			.byte \Movement					; $08
	MovementStars		.byte \MovementStars			; $09
	CriticalCoefficient	.byte \CriticalCoefficient		; $0A
	HPGrowth			.byte \HPGrowth					; $0B
	StrengthGrowth		.byte \StrengthGrowth			; $0C
	MagicGrowth			.byte \MagicGrowth				; $0D
	SkillGrowth			.byte \SkillGrowth				; $0E
	SpeedGrowth			.byte \SpeedGrowth				; $0F
	DefenseGrowth		.byte \DefenseGrowth			; $10
	ConstitutionGrowth	.byte \ConstitutionGrowth		; $11
	LuckGrowth			.byte \LuckGrowth				; $12
	MovementGrowth		.byte \MovementGrowth			; $13
	SwordRank			.byte \SwordRank				; $14
	LanceRank			.byte \LanceRank				; $15
	AxeRank				.byte \AxeRank					; $16
	BowRank				.byte \BowRank					; $17
	StaffRank			.byte \StaffRank				; $18
	FireRank			.byte \FireRank					; $19
	ThunderRank			.byte \ThunderRank				; $1A
	WindRank			.byte \WindRank					; $1B
	LightRank			.byte \LightRank				; $1C
	DarkRank			.byte \DarkRank					; $1D
	.union
	WeaponEXPModifiers
	.struct
		SwordEXPModifier	.byte \SwordEXPModifier		; $1E
		LanceEXPModifier	.byte \LanceEXPModifier		; $1F
		AxeEXPModifier		.byte \AxeEXPModifier		; $20
		BowEXPModifier		.byte \BowEXPModifier		; $21
		StaffEXPModifier	.byte \StaffEXPModifier		; $22
		FireEXPModifier		.byte \FireEXPModifier		; $23
		ThunderEXPModifier	.byte \ThunderEXPModifier	; $24
		WindEXPModifier		.byte \WindEXPModifier		; $25
		LightEXPModifier	.byte \LightEXPModifier		; $26
		DarkEXPModifier		.byte \DarkEXPModifier		; $27
	.ends
	.endu
	Gender				.byte \Gender					; $28
	Skills1				.byte \Skills1					; $29
	Skills2				.byte \Skills2					; $2A
	Skills3				.byte \Skills3					; $2B
	Class				.byte \Class					; $2C
	LeadershipStars		.byte \LeadershipStars			; $2D
	MapSprite			.byte \MapSprite				; $2E
	Portrait			.byte \Portrait					; $2F
	.ends

structCharacterNamePointer .struct Pointer
	Pointer .addr \Pointer
	.ends

