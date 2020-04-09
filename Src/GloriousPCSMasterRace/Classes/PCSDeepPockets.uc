// This is an Unreal Script
class PCSDeepPockets extends PCSBase config(PCSDeepPockets);


var config EInventorySlot TEMP_SLOT; // FIXME: Remove if/when moving the slot


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> t;
    t.AddItem(CreatePCSDeepPockets());
    return t;
}


// 
static function X2DataTemplate CreatePCSDeepPockets() {
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'PCSDeepPockets');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///Omnikron13_GloriousPCSMasterRace.Inventory.PCSDeepPockets";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = 20;
	Template.bAlwaysUnique = false;
	Template.Tier = 2;
    
	Template.InventorySlot = eInvSlot_CombatSim;

    Template.OnUnequippedFn = UnequipDelegate;

	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

    AddLootDrop('PCSDeepPockets', 'GPMRDropsEpic', 24); // TODO: config chance, perhaps table?

	return Template;
}


function UnequipDelegate(XComGameState_Item itemState, XComGameState_Unit unitState, XComGameState gameState) {
    // TODO: empty slot into HQ inventory when PCS is removed
    local XComGameState_HeadquartersXCom hq;
    local XComGameState_Item equipped;

    // The 'true' here means that this will fail silently, which could result in items being eaten, one way or another.
    hq = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

    // This could optionally take an XComGameState, though I'm not sure exactly what this would do...
    equipped = unitState.GetItemInSlot(default.TEMP_SLOT); // FIXME: Remove if/when moving the slot

    if(equipped == None) {
        `DEBUG("##############################################");
        `DEBUG("#  Apparently no item in slot being removed  #");
        `DEBUG("##############################################");
        return;
    }

    // Attempt to return an item in the slot to the armoury
    unitState.RemoveItemFromInventory(equipped, gameState);
	hq.PutItemInInventory(gameState, equipped);

    `DEBUG("###############################################");
    `DEBUG("#  Item transfered out of slot being removed  #");
    `DEBUG("###############################################");
}
