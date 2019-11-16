
aScriptedBattleTable ; 9A/E802
	.addr OrsinHalvanScriptedBattle
	.addr MareetaShanamScriptedBattle
	.addr NannaLoptyrianScriptedBattle
	.addr CedAlphanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle
	.addr OrsinHalvanScriptedBattle

OrsinHalvanScriptedBattle .dstruct structScriptedBattleSetup, $00, [Orsin, Player, Fighter, Pugi, TerrainVillage, [22, 22], 1, 81, 13, 2, 0], [Halvan, Enemy, Fighter, BraveAxe, TerrainVillage, [24, 24], 1, 89, 15, 3, 0], $09, Orsin, dialogueDemoOrsinBattle, Halvan, dialogueDemoHalvanBattle, Chapter1, None ; 9A/E842

	; Rounds

	.byte $80, $02, $00, $0C
	.byte $00, $02, $00, $0C
	.byte $02, $02, $00, $02
	.byte $02, $03, $00, $02
	.byte $00, $03, $00, $0C
.word $FFFF, $FFFF

MareetaShanamScriptedBattle .dstruct structScriptedBattleSetup, $00, [Mareeta, Player, MyrmidonF, $FFFF, TerrainThicket, [$FF, 30], 6, 56, 18, 14, 0], [Shanam, Enemy, Swordmaster, $FFFF, TerrainThicket, [38, 35], 18, 100, 20, 7, 8], $01, Halvan, None, Halvan, None, $FFFF, None ; 9A/E885

	; Rounds

	.byte $82, $02, $00, $0C
	.byte $00, $12, $00, $0C
	.byte $00, $02, $00, $02
	.byte $00, $02, $00, $0C
	.byte $00, $02, $00, $0C
	.byte $00, $02, $00, $0C
.word $FFFF, $FFFF

NannaLoptyrianScriptedBattle .dstruct structScriptedBattleSetup, $00, [Nanna, Player, TroubadourDismounted, EarthSword, TerrainCastle, [34, 34], 10, 99, 21, 11, 0], [LoptyrianDarkMage1, Enemy, DarkMage, Jormungand, TerrainCastle, [38, 38], 12, 67, 20, 10, 8], $0A, Halvan, None, Halvan, None, Chapter5, None ; 9A/E8CC

	; Rounds

	.byte $82, $00, $00, $09
	.byte $00, $01, $00, $20
.word $FFFF, $FFFF

CedAlphanScriptedBattle .dstruct structScriptedBattleSetup, $17, [CedChp23, Player, Sage, Forseti, TerrainCastle, [$FF, 32], 17, 99, 37, 17, 8], [Alphan, Enemy, DarkBishop, $FFFF, TerrainCastle, [56, 56], 13, 67, 31, 12, 8], $09, Halvan, None, Halvan, None, $FFFF, $9A9B45

	; Rounds

	.byte $80, $01, $00, $38
.word $FFFF, $FFFF
