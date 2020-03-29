// A very simple PCS that boosts the natural defence stat.
class PCSDefence extends X2Item config(PCSDefence);


var config int CommonPrice, RarePrice, EpicPrice;


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> t;

    t.AddItem(CreateCommonPCSDefence());
    t.AddItem(CreateRarePCSDefence());
    t.AddItem(CreateEpicPCSDefence());

    return t;
}


// TODO: refactor these three functions into one.
protected static function X2DataTemplate CreateCommonPCSDefence() {
	local X2EquipmentTemplate t;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', t, 'CommonPCSDefence');

	t.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
    // TODO: dig into the assets
	t.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Focus";
	t.ItemCat = 'combatsim';
	t.TradingPostValue = default.CommonPrice;
	t.bAlwaysUnique = false;
	t.Tier = 0;

	t.StatBoostPowerLevel = 1;
	t.StatsToBoost.AddItem(eStat_Defense);
	t.InventorySlot = eInvSlot_CombatSim;

    // TODO: work out exactly what this is
	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return t;
}


protected static function X2DataTemplate CreateRarePCSDefence() {
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'RarePCSDefence');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Focus";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = default.RarePrice;
	Template.bAlwaysUnique = false;
	Template.Tier = 1;

	Template.StatBoostPowerLevel = 2;
	Template.StatsToBoost.AddItem(eStat_Defense);
	Template.InventorySlot = eInvSlot_CombatSim;

	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return Template;
}


protected static function X2DataTemplate CreateEpicPCSDefence() {
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'EpicPCSDefence');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Focus";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = default.EpicPrice;
	Template.bAlwaysUnique = false;
	Template.Tier = 2;

	Template.StatBoostPowerLevel = 3;
	Template.StatsToBoost.AddItem(eStat_Defense);
	Template.InventorySlot = eInvSlot_CombatSim;

	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return Template;
}
