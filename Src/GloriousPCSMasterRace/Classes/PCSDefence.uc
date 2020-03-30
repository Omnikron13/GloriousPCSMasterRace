// A very simple PCS that boosts the natural defence stat.
class PCSDefence extends X2Item config(PCSDefence);


var config array<int> Price;


enum RarityNames {
    Common,
    Rare,
    Epic,
};


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> t;

    local int n;
    for(n = 0; n < RarityNames.EnumCount; n++) {
        t.AddItem(CreatePCSDefence(n, default.Price));
        `LOG("PCS Created:" @ t[n].Name);
    }

    return t;
}


// TODO: further refactor into a base class to construct other simple stat-based PCS
protected static function X2DataTemplate CreatePCSDefence(int tier, array<int> prices) {
	local X2EquipmentTemplate t;

    `CREATE_X2TEMPLATE(class'X2EquipmentTemplate', t, name(GetEnum(enum'RarityNames', tier) $ 'PCSDefence'));

	t.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
    // TODO: dig into the assets
	t.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Focus";
	t.ItemCat = 'combatsim';
	t.TradingPostValue = prices[tier];
	t.bAlwaysUnique = false;
	t.Tier = tier;

	t.StatBoostPowerLevel = tier + 1;
	t.StatsToBoost.AddItem(eStat_Defense);
	t.InventorySlot = eInvSlot_CombatSim;

    // TODO: work out exactly what this is
	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return t;
}
