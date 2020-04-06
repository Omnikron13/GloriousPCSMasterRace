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


// Add template to table with drop chance and optional (roll) group
protected static function AddLootDrop(name template, name table, int chance, optional int group = 1) {
    local LootTableEntry e;

    e.TemplateName = template;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(table, e, false);
}
