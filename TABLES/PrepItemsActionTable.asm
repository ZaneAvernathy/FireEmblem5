	Default									= 0
		DefaultPointer						= rsPrepItemsActionDefault
		DefaultNextAction					= HandleUnitList

	HandleUnitList							= 1
		HandleUnitListPointer				= rsPrepItemsHandleUnitList
		HandleUnitListNextAction			= DrawOptionsTilemaps

	DrawOptionsTilemaps						= 2
		DrawOptionsTilemapsPointer			= rsPrepItemsDrawOptionsTilemaps
		DrawOptionsTilemapsNextAction		= HandleOptionsInputs

	HandleOptionsInputs						= 3
		HandleOptionsInputsPointer			= rsUnknown81E6FD
		HandleOptionsInputsNextAction		= Default

	Trade									= 4
		TradePointer						= rsPrepItemsSetupSelectedUnit
		TradeNextAction						= HandleTradeUnitList

	HandleTradeUnitList						= 5
		HandleTradeUnitListPointer			= rsPrepItemsHandleTradeUnitList
		HandleTradeUnitListNextAction		= Default

	BackOutOfTradeSearch					= 6
		BackOutOfTradeSearchPointer			= rsPrepItemsBackOutOfTradeSearch
		BackOutOfTradeSearchNextAction		= DrawOptionsTilemaps

	Discard									= 7
		DiscardPointer						= rsPrepItemsSetupDiscard
		DiscardNextAction					= HandleDiscardList

	HandleDiscardList						= 8
		HandleDiscardListPointer			= rsPrepItemsDiscardCycle
		HandleDiscardListNextAction			= Default

	HandleDiscard							= 9
		HandleDiscardPointer				= rsPrepItemsBuildDiscardConfirmMenu
		HandleDiscardNextAction				= Default

	HandleDiscardConfirm					= 10
		HandleDiscardConfirmPointer			= rlPrepItemsHandleDiscard
		HandleDiscardConfirmNextAction		= Discard

	Convoy									= 11
		ConvoyPointer						= rsPrepItemsCreateConvoyMenu
		ConvoyNextAction					= ConvoyDummy

	ConvoyDummy								= 12
		ConvoyDummyPointer					= rsPrepItemsConvoyDummy
		ConvoyDummyNextAction				= Default

	List									= 13
		ListPointer							= rsPrepItemsSetupList
		ListNextAction						= UnknownE

	UnknownE								= 14
		UnknownEPointer						= rsUnknown81EDED
		UnknownENextAction					= UnknownF

	UnknownF								= 15
		UnknownFPointer						= rsUnknown81EE08
		UnknownFNextAction					= HandleItemList

	HandleItemList							= 16
		HandleItemListPointer				= rsPrepItemsListHandleItemList
		HandleItemListNextAction			= ClearItemListTilemaps

	ClearItemListTilemaps					= 17
		ClearItemListTilemapsPointer		= rsPrepItemsListClearItemListTilemaps
		ClearItemListTilemapsNextAction		= RevertUnitListPositions

	RevertUnitListPositions					= 18
		RevertUnitListPositionsPointer		= rsPrepItemsListRevertUnitListPositions
		RevertUnitListPositionsNextAction	= DrawOptionsTilemaps

	Unknown13								= 19
		Unknown13Pointer					= rsPrepItemsDoListScrollStep
		Unknown13NextAction					= Default

	Unknown14								= 20
		Unknown14Pointer					= rsPrepItemsDoListScrollStep
		Unknown14NextAction					= Default

	Unknown15								= 21
		Unknown15Pointer					= rsUnknown81F457
		Unknown15NextAction					= Default

	Armory									= 22
		ArmoryPointer						= rsPrepItemsHandleArmory
		ArmoryNextAction					= Default

	InventoryFromMainUnitList				= 23
		InventoryFromMainUnitListPointer	= rsUnknown81E1EB
		InventoryFromMainUnitListNextAction	= DrawMainDescription

	DrawMainDescription						= 24
		DrawMainDescriptionPointer			= rsPrepItemsDrawMainDescriptionAndGetNextAction
		DrawMainDescriptionNextAction		= HandleUnitList

	InventoryFromTrade						= 25
		InventoryFromTradePointer			= rsUnknown81E204
		InventoryFromTradeNextAction		= RedrawTradeDescription

	RedrawTradeDescription					= 26
		RedrawTradeDescriptionPointer		= rsPrepItemsRedrawTradeDescriptionAfterClosingInventory
		RedrawTradeDescriptionNextAction	= HandleTradeUnitList

DefaultPrepItemsActionTableEntry .dstruct structActionTableEntry, DefaultPointer, DefaultNextAction
HandleUnitListPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleUnitListPointer, HandleUnitListNextAction
DrawOptionsTilemapsPrepItemsActionTableEntry .dstruct structActionTableEntry, DrawOptionsTilemapsPointer, DrawOptionsTilemapsNextAction
HandleOptionsInputsPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleOptionsInputsPointer, HandleOptionsInputsNextAction
TradePrepItemsActionTableEntry .dstruct structActionTableEntry, TradePointer, TradeNextAction
HandleTradeUnitListPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleTradeUnitListPointer, HandleTradeUnitListNextAction
BackOutOfTradeSearchPrepItemsActionTableEntry .dstruct structActionTableEntry, BackOutOfTradeSearchPointer, BackOutOfTradeSearchNextAction
DiscardPrepItemsActionTableEntry .dstruct structActionTableEntry, DiscardPointer, DiscardNextAction
HandleDiscardListPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleDiscardListPointer, HandleDiscardListNextAction
HandleDiscardPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleDiscardPointer, HandleDiscardNextAction
HandleDiscardConfirmPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleDiscardConfirmPointer, HandleDiscardConfirmNextAction
ConvoyPrepItemsActionTableEntry .dstruct structActionTableEntry, ConvoyPointer, ConvoyNextAction
ConvoyDummyPrepItemsActionTableEntry .dstruct structActionTableEntry, ConvoyDummyPointer, ConvoyDummyNextAction
ListPrepItemsActionTableEntry .dstruct structActionTableEntry, ListPointer, ListNextAction
UnknownEPrepItemsActionTableEntry .dstruct structActionTableEntry, UnknownEPointer, UnknownENextAction
UnknownFPrepItemsActionTableEntry .dstruct structActionTableEntry, UnknownFPointer, UnknownFNextAction
HandleItemListPrepItemsActionTableEntry .dstruct structActionTableEntry, HandleItemListPointer, HandleItemListNextAction
ClearItemListTilemapsPrepItemsActionTableEntry .dstruct structActionTableEntry, ClearItemListTilemapsPointer, ClearItemListTilemapsNextAction
RevertUnitListPositionsPrepItemsActionTableEntry .dstruct structActionTableEntry, RevertUnitListPositionsPointer, RevertUnitListPositionsNextAction
Unknown13PrepItemsActionTableEntry .dstruct structActionTableEntry, Unknown13Pointer, Unknown13NextAction
Unknown14PrepItemsActionTableEntry .dstruct structActionTableEntry, Unknown14Pointer, Unknown14NextAction
Unknown15PrepItemsActionTableEntry .dstruct structActionTableEntry, Unknown15Pointer, Unknown15NextAction
ArmoryPrepItemsActionTableEntry .dstruct structActionTableEntry, ArmoryPointer, ArmoryNextAction
InventoryFromMainUnitListPrepItemsActionTableEntry .dstruct structActionTableEntry, InventoryFromMainUnitListPointer, InventoryFromMainUnitListNextAction
DrawMainDescriptionPrepItemsActionTableEntry .dstruct structActionTableEntry, DrawMainDescriptionPointer, DrawMainDescriptionNextAction
InventoryFromTradePrepItemsActionTableEntry .dstruct structActionTableEntry, InventoryFromTradePointer, InventoryFromTradeNextAction
RedrawTradeDescriptionPrepItemsActionTableEntry .dstruct structActionTableEntry, RedrawTradeDescriptionPointer, RedrawTradeDescriptionNextAction
