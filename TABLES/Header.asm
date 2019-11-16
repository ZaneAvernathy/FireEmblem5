
; Cartridge-specific settings

.enc "None"

MakerCode            = 1
GameCode             = "BFRJ"
ExpansionFLASHSize   = 0
ExpansionRAMSize     = 0
SpecialVersion       = 0
CartridgeSubtype     = None
CartridgeTitle       = "FIREEMBLEM5ROM"
CartridgeSpeed       = CartridgeSpeedFast
CartridgeMode        = CartridgeModeLoROM
CartridgeType        = CartridgeTypeROMRAMBattery
CartridgeCoprocessor = None
CartridgeROMSize     = $400000
CartridgeRAMSize     = $8000
CartridgeDestination = DestinationJapanese
CartridgeNew         = True
CartridgeVersion     = 0
CartridgeChecksum    = $E390

; Now to actually create the header

.if CartridgeNew == True

	.text format("%02X", MakerCode)
	.text GameCode

	.if (len(GameCode) == 4)
		.if (GameCode[0] != "T") && (GameCode[0] != "Z") && !(GameCode in ["042J", "MENU", "XBND"]) && (CartridgeDestination[1] != None)
			.cwarn GameCode[3] != CartridgeDestination[1], "Game code and destination mismatch."
		.endif
	.endif

	.fill 6, 0

	.byte GetShiftAmount(ExpansionFLASHSize / 1024)
	.byte GetShiftAmount(ExpansionRAMSize / 1024)
	.byte SpecialVersion

.else

	.fill 15, 0

.endif

.byte CartridgeSubtype

.cerror len(CartridgeTitle) > 21, "Cartridge title too long."

.union
	.fill 21, " "
	.text CartridgeTitle
.endu

.byte (CartridgeSpeed << 4) | CartridgeMode
.byte (CartridgeCoprocessor << 4) | CartridgeType
.byte GetShiftAmount(CartridgeROMSize / 1024)
.byte GetShiftAmount(CartridgeRAMSize / 1024)
.byte CartridgeDestination[0]

.if CartridgeNew == True

	.byte $33

.else

	.byte MakerCode

.endif

.byte CartridgeVersion

.word CartridgeChecksum ^ $FFFF
.word CartridgeChecksum

