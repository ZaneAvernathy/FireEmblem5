	Default								= 0
		DefaultPointer					= rsInventoryActionDefault
		DefaultNextAction				= CloseMenu

	DisplayItemInfoWindow				= 1
		DisplayItemInfoWindowPointer	= rsInventoryActionDisplayItemInfoWindow
		DisplayItemInfoWindowNextAction	= UpdateItemInfoWindow

	UpdateItemInfoWindow				= 2
		UpdateItemInfoWindowPointer		= rsInventoryActionUpdateItemInfoWindow
		UpdateItemInfoWindowNextAction	= Default

	UpdateSkillInfoWindow				= 3
		UpdateSkillInfoWindowPointer	= rsInventoryActionUpdateSkillInfoWindow
		UpdateSkillInfoWindowNextAction	= Default

	Unknown								= 4
		UnknownPointer					= rsInventoryActionUnknown
		UnknownNextAction				= Default

	GetScrollAmount						= 5
		GetScrollAmountPointer			= rsInventoryGetScrollAmount
		GetScrollAmountNextAction		= Default

	CloseMenu							= 6
		CloseMenuPointer				= rlInventoryActionCloseMenu
		CloseMenuNextAction				= Default

DefaultInventoryActionTableEntry .dstruct structActionTableEntry, DefaultPointer, DefaultNextAction
DisplayItemInfoWindowInventoryActionTableEntry .dstruct structActionTableEntry, DisplayItemInfoWindowPointer, DisplayItemInfoWindowNextAction
UpdateItemInfoWindowInventoryActionTableEntry .dstruct structActionTableEntry, UpdateItemInfoWindowPointer, UpdateItemInfoWindowNextAction
UpdateSkillInfoWindowInventoryActionTableEntry .dstruct structActionTableEntry, UpdateSkillInfoWindowPointer, UpdateSkillInfoWindowNextAction
UnknownInventoryActionTableEntry .dstruct structActionTableEntry, UnknownPointer, UnknownNextAction
GetScrollAmountInventoryActionTableEntry .dstruct structActionTableEntry, GetScrollAmountPointer, GetScrollAmountNextAction
CloseMenuInventoryActionTableEntry .dstruct structActionTableEntry, CloseMenuPointer, CloseMenuNextAction
