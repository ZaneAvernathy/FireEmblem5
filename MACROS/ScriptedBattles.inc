
structScriptedBattleSetup .struct Unk, Unit1Data, Unit2Data, Range, StartCharacter, StartDialogue, EndCharacter, EndDialogue, Chapter, ASMPointer
	.if type(\Unk) == type(?)
		.fill $2B
	.else
	Unknown			.byte \Unk
	Unit1Unit		.word \Unit1Data[0]
	Unit2Unit		.word \Unit2Data[0]
	Unit1Allegiance	.byte \Unit1Data[1]
	Unit2Allegiance	.byte \Unit2Data[1]
	Unit1Class		.byte \Unit1Data[2]
	Unit2Class		.byte \Unit2Data[2]
	Unit1Weapon		.word \Unit1Data[3]
	Unit2Weapon		.word \Unit2Data[3]
	Unit1Terrain	.byte \Unit1Data[4]
	Unit2Terrain	.byte \Unit2Data[4]
	Unit1MaxHP		.byte \Unit1Data[5][0]
	Unit2MaxHP		.byte \Unit2Data[5][0]
	Unit1CurrentHP	.byte \Unit1Data[5][1]
	Unit2CurrentHP	.byte \Unit2Data[5][1]
	Unit1Level		.byte \Unit1Data[6]
	Unit2Level		.byte \Unit2Data[6]
	Unit1Hit		.byte \Unit1Data[7]
	Unit2Hit		.byte \Unit2Data[7]
	Unit1Attack		.byte \Unit1Data[8]
	Unit2Attack		.byte \Unit2Data[8]
	Unit1Defense	.byte \Unit1Data[9]
	Unit2Defense	.byte \Unit2Data[9]
	Unit1Resistance	.byte \Unit1Data[10]
	Unit2Resistance	.byte \Unit2Data[10]
	Range			.byte \Range
	StartCharacter	.byte \StartCharacter
	StartDialogue	.long \StartDialogue
	EndCharacter	.byte \EndCharacter
	EndDialogue		.long \EndDialogue
	Chapter			.word \Chapter
	ASMPointer		.long \ASMPointer
	.endif
	.ends
