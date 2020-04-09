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
    `DEBUG("PCSBase: Created loot table:" @ n);
}


// Pseudo-replace the default PCS drop tables with modded ones
static function InjectLootTables() {
    ClearDefaultTables();
    RecreateDefaultTables();
    SetupUpgradeChance();

    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsCommon');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsRare');
    class'X2LootTableManager'.static.RecalculateLootTableChanceStatic('GPMRDropsEpic');

    AddLootRef('GPMRDropsCommon', 'PCSDropsBasic', 100, /**/, true);
    AddLootRef('GPMRDropsRare', 'PCSDropsRare', 100, /**/, true);
    AddLootRef('GPMRDropsEpic', 'PCSDropsEpic', 100, /**/, true);
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


// Replace vanilla entries in the Black Market PCS loot tables with GPMR drops.
private static function UpdateBlackMarketTables() {
    // Clear out vanilla PCS tables.
    // TODO: find a dynamic way of doing this?
    RemoveLootDrop('RarePCSSpeed', 'BlackMarketPCS_01', 1);
    RemoveLootDrop('RarePCSConditioning', 'BlackMarketPCS_01', 1);
    RemoveLootDrop('RarePCSFocus', 'BlackMarketPCS_01', 2);
    RemoveLootDrop('RarePCSAgility', 'BlackMarketPCS_01', 2);
    RemoveLootDrop('RarePCSPerception', 'BlackMarketPCS_01', 3);

    RemoveLootDrop('RarePCSSpeed', 'BlackMarketPCS_02', 1);
    RemoveLootDrop('EpicPCSSpeed', 'BlackMarketPCS_02', 1);
    RemoveLootDrop('RarePCSConditioning', 'BlackMarketPCS_02', 1);
    RemoveLootDrop('EpicPCSConditioning', 'BlackMarketPCS_02', 1);
    RemoveLootDrop('RarePCSFocus', 'BlackMarketPCS_02', 2);
    RemoveLootDrop('EpicPCSFocus', 'BlackMarketPCS_02', 2);
    RemoveLootDrop('RarePCSAgility', 'BlackMarketPCS_02', 2);
    RemoveLootDrop('EpicPCSAgility', 'BlackMarketPCS_02', 2);
    RemoveLootDrop('RarePCSPerception', 'BlackMarketPCS_02', 3);
    RemoveLootDrop('EpicPCSPerception', 'BlackMarketPCS_02', 3);

    RemoveLootDrop('EpicPCSSpeed', 'BlackMarketPCS_03', 1);
    RemoveLootDrop('EpicPCSConditioning', 'BlackMarketPCS_03', 1);
    RemoveLootDrop('EpicPCSFocus', 'BlackMarketPCS_03', 2);
    RemoveLootDrop('EpicPCSAgility', 'BlackMarketPCS_03', 2);
    RemoveLootDrop('EpicPCSPerception', 'BlackMarketPCS_03', 3);


    // Repopulate tables.
    // These roll groups match the chances of the vanilla tables, which should ensure the same
    // number of PCS chips available, just not the same distribution of rarity.
    // TODO: config this
    AddLootRef('GPMRDropsCommon', 'BlackMarketPCS_01', 50, 1);
    AddLootRef('GPMRDropsRare', 'BlackMarketPCS_01', 40, 2);
    AddLootRef('GPMRDropsRare', 'BlackMarketPCS_01', 25, 3);

    AddLootRef('GPMRDropsRare', 'BlackMarketPCS_02', 60, 1);
    AddLootRef('GPMRDropsRare', 'BlackMarketPCS_02', 60, 2);
    AddLootRef('GPMRDropsEpic', 'BlackMarketPCS_02', 30, 3);

    AddLootRef('GPMRDropsEpic', 'BlackMarketPCS_03', 60, 1);
    AddLootRef('GPMRDropsEpic', 'BlackMarketPCS_03', 40, 2);
    AddLootRef('GPMRDropsEpic', 'BlackMarketPCS_03', 30, 3);
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
private static function RemoveLootDrop(name loot, name table, optional int group = 1) {
    local LootTableEntry e;
    e.RollGroup = group;
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
protected static function AddLootRef(name child, name parent, int chance, optional int group = 1, optional bool recalc = false) {
    local LootTableEntry e;

    e.TableRef = child;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(parent, e, recalc);
}
