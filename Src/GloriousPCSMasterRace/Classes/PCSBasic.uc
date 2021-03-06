// This class serves as a base for simple stat-boosting PCS chips
class PCSBasic extends PCSBase config(PCSBasic);


enum RarityNames {
    Common,
    Rare,
    Epic,
};


// Structure to hold per-tier data for basic chips
struct Tier {
    var int Price;
    var name DropTable;
    var int DropChance;
};
// Structure mirroring config for basic PCS definitions
struct Chip {
    var string Name;
    var ECharStatType Stat;
    var string Img;
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
            `DEBUG("PCS Created:" @ templates[templates.Length-1].Name);
        }
    }

    return templates;
}


// Creates a basic stat-boosting PCS chip of tier t
protected static function X2DataTemplate CreatePCSBasic(Chip c, int t) {
	local X2EquipmentTemplate template;
    local name n;

    n = name(GetEnum(enum'RarityNames', t) $ "PCS" $ c.Name);

    `CREATE_X2TEMPLATE(class'X2EquipmentTemplate', template, n);

	template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
    if(c.Img == "") {
        template.strImage = "img:///Omnikron13_GloriousPCSMasterRace.Inventory.PCS_Blank";
    } else {
        template.strImage = c.Img;
    }
	template.ItemCat = 'combatsim';
    template.TradingPostValue = c.Tiers[t].Price;
	template.bAlwaysUnique = false;
	template.Tier = t;

	template.StatBoostPowerLevel = t + 1;
	template.StatsToBoost.AddItem(c.Stat);
	template.InventorySlot = eInvSlot_CombatSim;

    AddLootDrop(n, c.Tiers[t].DropTable, c.Tiers[t].DropChance);

	return template;
}
