
aDeploymentSlotTable ; 83/8E98

	; This table is used to get a pointer to a unit in RAM
	; given the unit's deployment number.

	; Each of the three allegiances get $40 entries,
	; with the first entry always 0000 and the last always FFFF
	; Which are used as start/stop markers for looping through
	; deployment slots.

	; That leaves $3E (62d) potential slots, but only:
	; Player: 48
	; Enemy: 50*
	; NPC: 16
	; are used, with the remaining slots full of
	; some strange nonsense terminated the same way
	; as the actual entries.

	; *There are only 50 set pointers for enemy deployment slots
	; despite there being space for 51 allocated.

	_PlayerSlots ; 83/8E98

	_slot := 0

	.sint 0

	_slot += 1

	.for _slot := _slot, _slot<=Player+48, _slot += 1

		.word <>aPlayerUnits + (size(structCharacterDataRAM) * (_slot - 1 - Player))

	.next

	.sint -1

	_slot += 1

	; The remaining player slots are full of pointers to
	; enemy units, starting with the second one.

	.for fill := 1, _slot<Enemy-1, fill += 1

		.word <>aEnemyUnits + (size(structCharacterDataRAM) * fill)
		_slot += 1

	.next

	.sint -1

	_slot += 1

	_EnemySlots ; 83/8F18

	.sint 0

	_slot += 1

	.for _slot := _slot, _slot<=Enemy+50, _slot += 1

		.word <>aEnemyUnits + (size(structCharacterDataRAM) * (_slot - 1 - Enemy))

	.next

	.sint -1

	_slot += 1

	; The remaining enemy slots are full of pointers to
	; NPC units.

	.for fill := 0, _slot<NPC-1, fill += 1

		.word <>aNPCUnits + (size(structCharacterDataRAM) * fill)
		_slot += 1

	.next

	.sint -1

	_slot += 1

	_NPCSlots ; 83/8F98

	.sint 0

	_slot += 1

	.for _slot := _slot, _slot<=NPC+16, _slot += 1

		.word <>aNPCUnits + (size(structCharacterDataRAM) * (_slot - 1 - NPC))

	.next

	.sint -1

	_slot += 1

	; The remaining NPC slots are wild.
	; There are 7 pointers to RAM not allocated
	; to units, 7 end markers, and the rest
	; are start markers.

	.for _slot := _slot, _slot<=NPC+24, _slot += 1

		.word <>aNPCUnits + (size(structCharacterDataRAM) * (_slot - 1 - NPC))

	.next

	.for _slot := _slot, _slot<=NPC+31, _slot += 1

		.sint -1

	.next

	.for _slot := _slot, _slot<=NPC+$40, _slot += 1

		.sint 0

	.next

	.sint -1

	_slot += 1
