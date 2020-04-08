// Base class for new PCS items, providing functionality for loot tables, etc.
class PCSBase extends X2Item;


// Sets up loot tables which will essentially replace the inbuilt ones for PCS drops.
static function CreateLootTables() {
    CreateLootTable('GPMRDropsCommon');
    CreateLootTable('GPMRDropsRare');
    CreateLootTable('GPMRDropsEpic');
}


// Adds a new loot table
protected static function CreateLootTable(name n) {
    local LootTable lt;
    lt.TableName = n;
    class'X2LootTableManager'.static.AddLootTableStatic(lt);
    `LOG("PCSBase: Created loot table:" @ n);
}


// Pseudo-replace the default PCS drop tables with modded ones
static function InjectLootTables() {
    local LootTableEntry e;

    ClearDefaultTables();
    RecreateDefaultTables();
    SetupUpgradeChance();

    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsCommon');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsRare');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsEpic');

    e.Chance = 100; // TODO: possibly config this
	e.RollGroup = 1;
    e.TableRef = 'GPMRDropsCommon';
    class'X2LootTableManager'.static.AddEntryStatic('PCSDropsBasic', e);

    e.TableRef = 'GPMRDropsRare';
    class'X2LootTableManager'.static.AddEntryStatic('PCSDropsRare', e);

    e.TableRef = 'GPMRDropsEpic';
    class'X2LootTableManager'.static.AddEntryStatic('PCSDropsEpic', e);
}


// Clear the default PCS drops (so they can be re-added to the custom tables instead)
private static function ClearDefaultTables() {
    RemoveLootDrop('CommonPCSSpeed', 'PCSDropsBasic');
    RemoveLootDrop('CommonPCSConditioning', 'PCSDropsBasic');
    RemoveLootDrop('CommonPCSFocus', 'PCSDropsBasic');
    RemoveLootDrop('CommonPCSPerception', 'PCSDropsBasic');
    RemoveLootDrop('CommonPCSAgility', 'PCSDropsBasic');

    RemoveLootDrop('RarePCSSpeed', 'PCSDropsRare');
    RemoveLootDrop('RarePCSConditioning', 'PCSDropsRare');
    RemoveLootDrop('RarePCSFocus', 'PCSDropsRare');
    RemoveLootDrop('RarePCSPerception', 'PCSDropsRare');
    RemoveLootDrop('RarePCSAgility', 'PCSDropsRare');

    RemoveLootDrop('EpicPCSSpeed', 'PCSDropsEpic');
    RemoveLootDrop('EpicPCSConditioning', 'PCSDropsEpic');
    RemoveLootDrop('EpicPCSFocus', 'PCSDropsEpic');
    RemoveLootDrop('EpicPCSPerception', 'PCSDropsEpic');
    RemoveLootDrop('EpicPCSAgility', 'PCSDropsEpic');
}


// Add the default PCS chips to the new drop tables
private static function RecreateDefaultTables() {
    // TODO: config these values
    AddLootDrop('CommonPCSSpeed', 'GPMRDropsCommon', 24);
    AddLootDrop('CommonPCSConditioning', 'GPMRDropsCommon', 24);
    AddLootDrop('CommonPCSFocus', 'GPMRDropsCommon', 24);
    AddLootDrop('CommonPCSPerception', 'GPMRDropsCommon', 12);
    AddLootDrop('CommonPCSAgility', 'GPMRDropsCommon', 24);

    AddLootDrop('RarePCSSpeed', 'GPMRDropsRare', 24);
    AddLootDrop('RarePCSConditioning', 'GPMRDropsRare', 24);
    AddLootDrop('RarePCSFocus', 'GPMRDropsRare', 24);
    AddLootDrop('RarePCSPerception', 'GPMRDropsRare', 12);
    AddLootDrop('RarePCSAgility', 'GPMRDropsRare', 24);

    AddLootDrop('EpicPCSSpeed', 'GPMRDropsEpic', 24);
    AddLootDrop('EpicPCSConditioning', 'GPMRDropsEpic', 24);
    AddLootDrop('EpicPCSFocus', 'GPMRDropsEpic', 24);
    AddLootDrop('EpicPCSPerception', 'GPMRDropsEpic', 12);
    AddLootDrop('EpicPCSAgility', 'GPMRDropsEpic', 24);
}


// Allow a chance to 'upgrade' the drop to the next tier of drop table
private static function SetupUpgradeChance() {
    local LootTableEntry e;
    e.RollGroup = 1;
    e.Chance = 24; // TODO: config this. probably also move to reusable function
    e.TableRef = 'GPMRDropsRare';
    class'X2LootTableManager'.static.AddEntryStatic('GPMRDropsCommon', e);
    e.TableRef = 'GPMRDropsEpic';
    class'X2LootTableManager'.static.AddEntryStatic('GPMRDropsRare', e);
}


// Remove an existing drop from the loot tables (for clearing default PCS)
private static function RemoveLootDrop(name loot, name table) {
    local LootTableEntry e;
    e.RollGroup = 1;
    e.TemplateName = loot;
    class'X2LootTableManager'.static.RemoveEntryStatic(table, e, false);
}


// Add template to table with drop chance and optional (roll) group
protected static function AddLootDrop(name template, name table, int chance, optional int group = 1) {
    local LootTableEntry e;

    e.TemplateName = template;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(table, e, false);
}


// Add a reference to another table to a loot table
protected static function AddLootRef(name child, name parent, int chance, optional int group = 1) {
    local LootTableEntry e;

    e.TableRef = child;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(parent, e, false);
}
