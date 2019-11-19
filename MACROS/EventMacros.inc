
macroCountAllUncapturedAliveUnits .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCountAllUnitUncapturedAlive, $0000
	.endm

macroCountPlayerUncapturedAliveUnits .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCountPlayerUnitUncapturedAlive, $0000
	.endm

macroCountEnemyUncapturedAliveUnits .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCountEnemyUnitUncapturedAlive, $0000
	.endm

macroCountNPCUncapturedAliveUnits .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCountNPCUnitUncapturedAlive, $0000
	.endm

macroMountUnit .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCMount, $0000
	.endm

macroDismountUnit .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCDismount, $0000
	.endm

macroCountAllUnitsWithCharacterDataWord .macro Field, Value
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCCountAllUnitsWithCharacterDataWord, $0000
	.endm

macroCheckIfCaptured .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCIsUnitCaptured, $0000
	.endm

macroCheckAlive .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCheckAllUnitAlive, $0000
	.endm

macroItemHouse .macro DialoguePointer, Item, Coords, TileID
		PLAY_SOUND_WORD $00F7
		DIALOGUE \DialoguePointer
		YIELD

		STORE_WORD wEventEngineParameter1, TurnStatusActing
		CALL_ASM_LOOP rlASMCActiveUnitSetTurnStatus, $0000

		macroGiveItemToActiveUnit \Item

		STORE_WORD wEventEngineParameter1, TurnStatusActing
		CALL_ASM_LOOP rlASMCActiveUnitUnsetTurnStatus, $0000

		macroSingleTileChangeByCoordinates \Coords, \TileID
	.endm

macroDialogueHouse .macro DialoguePointer
		PLAY_SOUND_WORD $00F7
		DIALOGUE \DialoguePointer
		YIELD
	.endm

macroGiveItemToActiveUnit .macro Item
		STORE_WORD wEventEngineParameter1, \Item
		PAUSE_SKIPPABLE 10
		YIELD

		CALL_ASM_LOOP rlASMCSetPopupGivenItemWithMaxDurability, $0000
		YIELD_UNK

		CALL_ASM_LOOP rlASMCSetupGiveItemPopup, $0000
		CALL_ASM_LOOP rlASMCWaitWhileGiveItemPopup, $0000
		CALL_ASM_LOOP rlASMCSetupGiveToConvoyIfInventoryFull, $0000
		CALL_ASM_LOOP rlASMCWaitWhileGiveToConvoyIfInventoryFull, $0000
	.endm

macroChapterTitlePopup .macro DialoguePointer
		STORE_LONG wProcInput1+1, \DialoguePointer
		STORE_WORD wProcInput1, <>\DialoguePointer
		STORE_LONG lR43, $9A814C
		CALL_ASM_SKIPPABLE rlEventEngineCreateProcAndSetActive, $0000
		YIELD
	.endm

macroSetCharacterWord .macro Character, Field, Value
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCSetCharacterDataWord, $0000
	.endm

macroSetCharacterByte .macro Character, Field, Value
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCSetCharacterDataByte, $0000
	.endm

macroSetAllCharacterByteIfCharacterWord .macro Field, Value, CheckCharacter, CheckField
		STORE_WORD wEventEngineCharacterStructParameter, \CheckField
		STORE_WORD wEventEngineCharacterTarget, \CheckCharacter
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCSetCharacterDataByteIfWord, $0000
	.endm

macroSetAllCharacterByte .macro Field, Value
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCAllUnitsSetCharacterDataByte, $0000
	.endm

macroAddCharacterByte .macro Character, Field, Value
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCAddCharacterDataByte, $0000
	.endm

macroSubtractCharacterByte .macro Character, Field, Value
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Value
		CALL_ASM_LOOP rlASMCSubtractCharacterDataByte, $0000
	.endm

macroSetCharacterBitsWord .macro Character, Field, Bits
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Bits
		CALL_ASM_LOOP rlASMCSetBitsCharacterDataWord, $0000
	.endm

macroUnsetCharacterBitsWord .macro Character, Field, Bits
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \Field
		STORE_WORD wEventEngineParameter2, \Bits
		CALL_ASM_LOOP rlASMCUnsetBitsCharacterDataWord, $0000
	.endm

macroCheckTurnStatusSet .macro Character, TurnStatus
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCCheckUnitTurnStatusSet, $0000
	.endm

macroCheckTurnStatusUnset .macro Character, TurnStatus
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCCheckUnitTurnStatusUnset, $0000
	.endm

macroSetCharacterTurnStatus .macro Character, TurnStatus
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCSetUnitTurnStatus, $0000
	.endm

macroUnsetCharacterTurnStatus .macro Character, TurnStatus
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCUnsetUnitTurnStatus, $0000
	.endm

macroSetAllCharacterTurnStatus .macro TurnStatus
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCAllUnitsSetTurnStatus, $0000
	.endm

macroUnsetAllCharacterTurnStatus .macro TurnStatus
		STORE_WORD wEventEngineParameter1, \TurnStatus
		CALL_ASM_LOOP rlASMCAllUnitsUnsetTurnStatus, $0000
	.endm

macroCheckIfRescuedByAllyOrNPC .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCCheckUnitRescuedByPlayerOrNPC, $0000
	.endm

macroCheckIfRescued .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCIsUnitRescued, $0000
	.endm

macroClearRescue .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCClearRescue, $0000
	.endm

macroDialogueWithBackground .macro DialoguePointer, BackgroundID
		STORE_WORD wEventEngineParameter1, \BackgroundID
		CALL_ASM_SKIPPABLE rlASMCDialogueWithBGSetup, <>rsUnknown80A23A
		HALT_UNTIL_WORD_SKIPPABLE wUnknown000302, $0009
		CALL_ASM_LONG_SKIPPABLE rlASMCDialogueWithBGStart, \DialoguePointer
		YIELD_UNK
		YIELD_UNK
		YIELD_UNK
	.endm

macroEventConditionCheckCoords .macro Coords
		CMP_BYTE wCursorXCoord, \Coords[0]
		CMP_BYTE wCursorYCoord, \Coords[1]
	.endm

macroEventConditionCheckCoordRanges .macro UpperLeft, LowerRight
		CMP_BYTE_RANGE wCursorXCoord, \UpperLeft[0], \LowerRight[0]
		CMP_BYTE_RANGE wCursorYCoord, \UpperLeft[1], \LowerRight[1]
	.endm

macroShopDefinition .macro ChapterShopData
		EVENT FlagAlwaysZero, \ChapterShopData
			CMP_BYTE_AT wCursorXCoord, \ChapterShopData
			CMP_BYTE_AT wCursorYCoord, \ChapterShopData+1
		END_DEFINITION
	.endm

macroSingleTileChangeByCoordinates .macro Coords, TileID
		STORE_WORD wEventEngineXCoordinate, \Coords[0]
		STORE_WORD wEventEngineYCoordinate, \Coords[1]
		STORE_WORD wEventEngineParameter1, \TileID
		CALL_ASM_LOOP rlASMCSingleTileChangeByCoords, $0000
		YIELD_UNK
	.endm

macroDestroyHouseByTileChangeID .macro TileChangeID
		PLAY_SOUND_BYTE $45
		macroTileChangeByID \TileChangeID

		PAUSE_SKIPPABLE 10
		YIELD
	.endm

macroOpenDoorByTileChangeID .macro TileChangeID, SoundID=$6B
		PLAY_SOUND_BYTE \SoundID
		macroTileChangeByID \TileChangeID
	.endm

macroOpenDrawbridgeByTileChangeID .macro TileChangeID, SoundID=$6E
		PLAY_SOUND_BYTE \SoundID
		macroTileChangeByID \TileChangeID
	.endm

macroTileChangeByID .macro TileChangeID
		HALT_UNTIL_BYTE bDecompListFlag, $00

		CALL_ASM_LOOP rlASMCDecompressChapterMapChanges, $0000
		HALT_UNTIL_BYTE bDecompListFlag, $00
		HALT_UNTIL_BYTE bDMAArrayFlag, $00

		STORE_WORD wEventEngineParameter1, \TileChangeID
		CALL_ASM_LOOP rlASMCTileChangeByID, $0000
		HALT_UNTIL_BYTE bDMAArrayFlag, $00
		YIELD_UNK
		YIELD_UNK
	.endm

macroBossQuoteDefinition .macro EventFlag, Character
		EVENT \EventFlag, eventBattleQuoteDummyEvent
			CHECK_SINGLE \Character
		END_DEFINITION
	.endm

macroChestDefinition .macro EventFlag, EventPointer, CoordinatePointer
		EVENT \EventFlag, \EventPointer
			CMP_BYTE_AT wCursorXCoord, \CoordinatePointer
			CMP_BYTE_AT wCursorYCoord, \CoordinatePointer+1
		END_DEFINITION
	.endm

macroDoorDefinition .macro EventFlag, Coords, EventPointer
		EVENT \EventFlag, \EventPointer
			CMP_BYTE wEventEngineUnknownXTarget, \Coords[0]
			CMP_BYTE wEventEngineUnknownYTarget, \Coords[1]
		END_DEFINITION
	.endm

macroDrawbridgeDefinition .macro EventFlag, Coords, EventPointer
		EVENT \EventFlag, \EventPointer
			CMP_BYTE wEventEngineUnknownXTarget, \Coords[0]
			CMP_BYTE wEventEngineUnknownYTarget, \Coords[1]
		END_DEFINITION
	.endm

macroRemoveUnit .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCRemoveUnit, $0000
	.endm

macroPlayerRetreatDefinition .macro EventFlag, EventPointer
		EVENT \EventFlag, \EventPointer
			CMP_BITS $7E4F98, $0008
			RUN_ASM rlEventDefinitionCheckRetreatCoordinates
			CMP_WORD aSelectedCharacterBuffer.Character, Leif
		END_DEFINITION
		EVENT \EventFlag, \EventPointer
			CMP_BITS $7E4F98, $0008
			RUN_ASM rlEventDefinitionCheckRetreatCoordinates
			CHECK_CARRYING Leif
		END_DEFINITION
		EVENT FlagAlwaysZero, \EventPointer
			CMP_BITS $7E4F98, $0008
			TEST_FLAG_UNSET \EventFlag
			RUN_ASM rlEventDefinitionCheckRetreatCoordinates
			CMP_WORD wCurrentPhase, Player
		END_DEFINITION
	.endm

macroHaveActiveUnitRetreat .macro Movestring
		STORE_WORD wEventEngineCharacterTarget, $0000
		STORE_WORD_FROM wEventEngineCharacterTarget, aSelectedCharacterBuffer.Character
		DIALOGUE_ARRAY aRetreatQuoteTable
		YIELD

		CALL_ASM_LOOP rlASMCUpdateRetreatingUnitTurnStatus, $0000
		CALL_ASM_LOOP rlASMCCopyRetreatingUnitDataToEventBuffer, $0000

		MOVE_UNIT $FFFF, [0, 0], [0, 0], 1, \Movestring
		YIELD_UNK

		CALL_ASM_LOOP rlASMCUnknown8CA097, $0000
		WAIT_MOVE
		YIELD

		CALL_ASM_LOOP rlASMCCopyRetreatingUnitDataFromEventBuffer, $0000
	.endm

macroSetUnitPosition .macro Character, Coords
		STORE_WORD wEventEngineCharacterTarget, \Character
		STORE_WORD wEventEngineXCoordinate, \Coords[0]
		STORE_WORD wEventEngineYCoordinate, \Coords[1]
		CALL_ASM_LOOP rlASMCSetUnitPosition, $0000
	.endm

macroConvertToPlayerAllegiance .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCChangeAllegianceToPlayer, $0000
	.endm

macroConvertToEnemyAllegiance .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCChangeAllegianceToEnemy, $0000
	.endm

macroConvertToNPCAllegiance .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCChangeAllegianceToNPC, $0000
	.endm

macroConvertToPlayerAllegianceIfCaptured .macro Character
		STORE_WORD wEventEngineCharacterTarget, \Character
		CALL_ASM_LOOP rlASMCChangeAllegianceToPlayerIfCaptured, $0000
	.endm

macroScriptedWarpStaff .macro CastingCharacter, TargetCharacter, Coords
		; Coords of [-1, -1] mean "off the map" and
		; should be followed by removing the target unit
		; Otherwise this thould be followed by a WARP_UNIT
		macroCountAllUncapturedAliveUnits \CastingCharacter
		JUMP_FALSE +

		macroCountAllUncapturedAliveUnits \TargetCharacter
		JUMP_FALSE +

		STORE_WORD wEventEngineParameter1, Warp
		STORE_WORD wEventEngineParameter2, $0000
		STORE_WORD wEventEngineCharacterStructParameter, \CastingCharacter
		STORE_WORD wEventEngineCharacterTarget, \TargetCharacter
		STORE_WORD wEventEngineXCoordinate, \Coords[0] & $FF
		STORE_WORD wEventEngineYCoordinate, \Coords[1] & $FF
		CALL_ASM_SKIPPABLE $9A8D4A, $0000

		STORE_LONG lUnknown7EA4EC, $9A9029
		CALL_ASM_SKIPPABLE $84B719, $0000

		HALT_UNTIL_WORD_SKIPPABLE $7FAA14, $0000

		CALL_ASM_SKIPPABLE rlUpdateUnitMaps, $0000
		CALL_ASM_SKIPPABLE rlUpdateVisibilityMap, $0000

		PAUSE_SKIPPABLE 2
		YIELD

		+
	.endm

macroScriptedStoneCast .macro CastingCharacter, TargetCharacter
		macroCountAllUncapturedAliveUnits \CastingCharacter
		JUMP_FALSE +

		macroCountAllUncapturedAliveUnits \TargetCharacter
		JUMP_FALSE +

		STORE_WORD wEventEngineParameter1, Stone
		STORE_WORD wEventEngineParameter2, $0000
		STORE_WORD wEventEngineCharacterStructParameter, \CastingCharacter
		STORE_WORD wEventEngineCharacterTarget, \TargetCharacter
		CALL_ASM_SKIPPABLE $9A8D4A, $0000

		STORE_LONG lUnknown7EA4EC, rlEventPetrifyCastingEffect
		CALL_ASM_SKIPPABLE $84B719, $0000

		HALT_UNTIL_WORD_SKIPPABLE $7FAA14, $0000

		CALL_ASM_SKIPPABLE rlUpdateUnitMaps, $0000
		CALL_ASM_SKIPPABLE rlUpdateVisibilityMap, $0000

		PAUSE_SKIPPABLE 2
		YIELD

		+
	.endm

macroScriptedRewarpStaff .macro CastingCharacter, Coords
		; Slightly different if going off the map or
		; to coordinates
		STORE_WORD wEventEngineParameter1, Rewarp
		STORE_WORD wEventEngineParameter2, $0000
		STORE_WORD wEventEngineCharacterStructParameter, \CastingCharacter
		STORE_WORD wEventEngineCharacterTarget, $0000
		STORE_WORD wEventEngineXCoordinate, \Coords[0] & $FF
		STORE_WORD wEventEngineYCoordinate, \Coords[1] & $FF
		CALL_ASM_SKIPPABLE $9A8D4A, $0000

		.if (\Coords[0] & \Coords[1]) == -1
			STORE_LONG lUnknown7EA4EC, $9A9029
		.else
			STORE_LONG lUnknown7EA4EC, $83EDB6
		.endif
		CALL_ASM_SKIPPABLE $9A8F82, $0000

		CALL_ASM_SKIPPABLE $84B719, $0000

		HALT_UNTIL_WORD_SKIPPABLE $7FAA14, $0000

		CALL_ASM_SKIPPABLE rlUpdateUnitMaps, $0000
		CALL_ASM_SKIPPABLE rlUpdateVisibilityMap, $0000

		PAUSE_SKIPPABLE 2
		YIELD
	.endm



