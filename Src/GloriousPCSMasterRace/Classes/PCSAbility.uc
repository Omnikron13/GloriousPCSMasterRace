// Master class for single ability granting PCS chips.
class PCSAbility extends PCSBase config(PCSAbility);


// Structure mirroring config for basic ability PCS definitions
struct Chip {
    var name Ability;
    var string Img;
    var int Tier;
    var int Price;
    var int DropChance;
};
var config array<Chip> Chips;


// Iterate the chips define in the config.
static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> templates;

    local int n;
    for(n = 0; n < default.Chips.Length; n++) {
        templates.AddItem(CreatePCSAbility(default.Chips[n]));
        `DEBUG("PCS Created:" @ templates[templates.Length-1].Name);
    }

    return templates;
}


// Create a generic ability-granting PCS chip.
static function X2DataTemplate CreatePCSAbility(Chip c) {
	local X2EquipmentTemplate t;
    local name n;

    n = name("PCS" $ c.Ability);

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', t, n);

	t.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	t.strImage = c.Img;
	t.ItemCat = 'combatsim';
	t.TradingPostValue = c.Price;
	t.bAlwaysUnique = false;
	t.Tier = c.Tier;
    t.Abilities.AddItem(c.Ability);
	t.InventorySlot = eInvSlot_CombatSim;

    AddLootDrop(n, default.LootTables[c.Tier], c.DropChance);

	return t;
}
