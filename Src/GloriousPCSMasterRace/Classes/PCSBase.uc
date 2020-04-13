// Base class for new PCS items, providing functionality for loot tables, etc.
class PCSBase extends X2Item config(PCSBase);


var config array<name> LootTables;


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
    `DEBUG("PCSBase: Created loot table:" @ n);
}


// Pseudo-replace the default PCS drop tables with modded ones
static function InjectLootTables() {
    class'LootTables'.static.Setup();

    SetupUpgradeChance();

    // TODO: un-hardcode this
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsCommon');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsRare');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsEpic');

    AddLootRef('GPMRDropsCommon', 'PCSDropsBasic', 100, /**/, true);
    AddLootRef('GPMRDropsRare', 'PCSDropsRare', 100, /**/, true);
    AddLootRef('GPMRDropsEpic', 'PCSDropsEpic', 100, /**/, true);
}


// TODO: Move to LootTables?
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


// Convenience functions - defer to LootTables
protected static function RemoveLootDrop(name loot, name table, optional int group = 1) {
    class'LootTables'.static.RemoveLootDrop(loot, table, group);
}
protected static function AddLootDrop(name template, name table, int chance, optional int group = 1) {
    class'LootTables'.static.AddLootDrop(template, table, chance, group);
}
protected static function AddLootRef(name child, name parent, int chance, optional int group = 1, optional bool recalc = false) {
    class'LootTables'.static.AddLootRef(child, parent, chance, group, recalc);
}
