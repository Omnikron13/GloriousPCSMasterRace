// This class serves as a base for simple stat-boosting PCS chips
class PCSBasic extends X2Item config(PCSBasic);


enum RarityNames {
    Common,
    Rare,
    Epic,
};


// Structure to hold per-tier data for basic chips
struct Tier {
    var int Price;
};
// Structure mirroring config for basic PCS definitions
struct Chip {
    var string Name;
    var ECharStatType Stat;
    var array<Tier> Tiers;
};
var config array<Chip> Chips;


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> templates;

    local int n;
    local int t;
    for(n = 0; n < default.Chips.Length; n++) {
        for(t = 0; t < default.Chips[n].Tiers.Length; t++) {
            templates.AddItem(CreatePCSBasic(default.Chips[n], t));
            `LOG("PCS Created:" @ templates[templates.Length-1].Name);
        }
    }

    return templates;
}


// Creates a basic stat-boosting PCS chip of tier t
protected static function X2DataTemplate CreatePCSBasic(Chip c, int t) {
	local X2EquipmentTemplate template;

    `CREATE_X2TEMPLATE(class'X2EquipmentTemplate', template, name(GetEnum(enum'RarityNames', t) $ "PCS" $ c.Name));

	template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
    // TODO: dig into the assets
	template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Focus";
	template.ItemCat = 'combatsim';
    template.TradingPostValue = c.Tiers[t].Price;
	template.bAlwaysUnique = false;
	template.Tier = t;

	template.StatBoostPowerLevel = t + 1;
	template.StatsToBoost.AddItem(c.Stat);
	template.InventorySlot = eInvSlot_CombatSim;

    // TODO: work out exactly what this is
	//Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return template;
}
