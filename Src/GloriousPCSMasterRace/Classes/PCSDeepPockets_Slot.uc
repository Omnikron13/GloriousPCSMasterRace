// This is an Unreal Script
class PCSDeepPockets_Slot extends CHItemSlotSet config(PCSDeepPockets);


var config EInventorySlot TEMP_SLOT; // FIXME: Remove if/when moving the slot
var config int SlotPriority;
var config array<name> ProhibitedCategories;
var config array<name> ProhibitedItems;


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> t;
    t.AddItem(CreatePCSDeepPockets_Slot());
    return t;
}


protected static function CHItemSlot CreatePCSDeepPockets_Slot() {
    local CHItemSlot slot;

    `CREATE_X2TEMPLATE(class'CHItemSlot', slot, 'PCSDeepPockets_Slot');
    
    slot.InvSlot = default.TEMP_SLOT; // FIXME: Remove if/when moving the slot
    slot.SlotCatMask = sLot.SLOT_ITEM | slot.SLOT_MISC;
    slot.IsUserEquipSlot = true;
    slot.IsEquippedSlot = true;
    slot.BypassesUniqueRule = false;
    slot.IsMultiItemSlot = false;
    slot.MinimumEquipped = 0;
    slot.IsSmallSlot = false; // TODO: config this?
    slot.NeedsPresEquip = false;
    slot.ShowOnCinematicPawns = false; // What even happens if this is true..?

    slot.CanAddItemToSlotFn = CanAddItemToSlot;
    slot.UnitHasSlotFn = UnitHasSlot;
    slot.GetPriorityFn = GetPriority;
    slot.ShowItemInLockerListFn = ShowItemInLockerList;

    return slot;
}


protected static function bool CanAddItemToSlot(
    CHItemSlot slot,
    XComGameState_Unit unit,
    X2ItemTemplate template,
    optional XComGameState gameState,
    optional int quantity = 1,
    optional XComGameState_Item itemState
) {
    // TODO: Stuff
    // TODO: Integrate with ShowItemInLockerList? 
    return true;
}


protected static function bool UnitHasSlot(
    CHItemSlot slot,
    XComGameState_Unit unitState,
    out string lockedReason,
    optional XComGameState gameState
) {
    // TODO: Verify this is the only check needed
    return unitState.HasItemOfTemplateType('PCSDeepPockets');
}


protected static function int GetPriority(
    CHItemSlot slot,
    XComGameState_Unit unitState,
    optional XComGameState gameState
) {
    return default.SlotPriority; // TODO: Work out exactly how this interacts with other slotty mods
}


protected static function bool ShowItemInLockerList(
    CHItemSlot slot,
    XComGameState_Unit unit,
    XComGameState_Item itemState,
    X2ItemTemplate itemTemplate,
    XComGameState gameState
) {
    // TODO: split into central Prohibit() function?
    local name category;
    local name item;

    foreach default.ProhibitedCategories(category) {
        if(ItemTemplate.ItemCat == category) return false;
    }

    foreach default.ProhibitedItems(item) {
        if(ItemTemplate.Name == item) return false;
    }

    return true;
}


// TODO: Remove this..?
// I believe it is intended to pop a default item into a loadout when an item is removed.
// 'Borrowed' code from the vest mod while trying to get this PCS working smoothly, but
// not sure why it was needed there either...
protected static function ValidateLoadout(
    CHItemSlot slot,
    XComGameState_Unit unitState,
    XComGameState_HeadquartersXCom hq,
    XComGameState gameState
) {
	local XComGameState_Item equipped;
	local bool hasSlot;
    local string devNull;

	equipped = unitState.GetItemInSlot(slot.InvSlot, gameState);
	hasSlot = slot.UnitHasSlot(unitState, devNull, gameState);

	if(equipped != none && !hasSlot)
	{
        // What exactly is this step supposed to do..?
		//equipped = XComGameState_Item(gameState.ModifyStateObject(class'XComGameState_Item', equipped.ObjectID));

		unitState.RemoveItemFromInventory(equipped, gameState);
		hq.PutItemInInventory(gameState, equipped);
		//equipped = none; // Why..?
	}

}
