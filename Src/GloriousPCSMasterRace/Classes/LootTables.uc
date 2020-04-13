// This is an Unreal Script
class LootTables extends object config(LootTables);


// Config structs
struct Drop {
    var name Loot;
    var int Chance;
    var int Group;
};
struct RemoveDrop {
    var name Table;
    var array<Drop> Drop;
};
struct AddDrop {
    var name Table;
    var array<Drop> Drop;
};
struct AddRef {
    var name Table;
    var array<Drop> Ref;
};


var config array<RemoveDrop> RemoveDrops;
var config array<AddDrop> AddDrops;
var config array<AddRef> AddRefs;


// Intial clear/rebuild of vanilla drops
static function Setup() {
    ClearTables();
    RebuildTables();
}


// Clear out vanilla drops, as specified in the config
protected static function ClearTables() {
    local RemoveDrop rd;
    local Drop d;
    foreach default.RemoveDrops(rd) {
        `DEBUG("Clearing drop table:" @ rd.Table);
        foreach rd.Drop(d) {
            `DEBUG(" - Removing drop:" @ d.Loot);
            RemoveLootDrop(d.Loot, rd.Table, d.Group);
        }
    }
}


// Re-add vanilla drops, as specified in the config
protected static function RebuildTables() {
    local AddDrop ad;
    local AddRef ar;
    local Drop d;
    foreach default.AddDrops(ad) {
        `DEBUG("Readding drops:" @ ad.Table);
        foreach ad.Drop(d) {
            `DEBUG(" - Adding drop:" @ d.Loot);
            AddLootDrop(d.Loot, ad.Table, d.Chance); // TODO: maybe config group, even if it is likely just 1
        }
    }
    foreach default.AddRefs(ar) {
        `DEBUG("Adding refs:" @ ar.Table);
        foreach ar.Ref(d) {
            `DEBUG(" - Adding ref:" @ d.Loot);
            AddLootRef(d.Loot, ar.Table, d.Chance, d.Group);
        }
    }
}


// -- GENERAL LOOT TABLE FUNCTIONS --


// Remove an existing drop from the loot tables (for clearing default PCS)
static function RemoveLootDrop(name loot, name table, optional int group = 1) {
    local LootTableEntry e;
    e.RollGroup = group;
    e.TemplateName = loot;
    class'X2LootTableManager'.static.RemoveEntryStatic(table, e, false);
}


// Add template to table with drop chance and optional (roll) group
static function AddLootDrop(name template, name table, int chance, optional int group = 1) {
    local LootTableEntry e;

    e.TemplateName = template;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(table, e, false);
}


// Add a reference to another table to a loot table
static function AddLootRef(name child, name parent, int chance, optional int group = 1, optional bool recalc = false) {
    local LootTableEntry e;

    e.TableRef = child;
    e.Chance = chance;
    e.RollGroup = group;

    class'X2LootTableManager'.static.AddEntryStatic(parent, e, recalc);
}
