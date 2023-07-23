local table_exp = require "tableexp"

DisplayNames = {}

function getInventory()
    local inventoryTable = {}

    for slot, item in pairs(Vault.list()) do
        local details = Vault.getItemDetail(slot)
        DisplayNames[item.name] = details.displayName

        local list = table_exp.getOrElse(inventoryTable, item.name, {})
        table.insert(list, { slot = slot, amount = item.count })

        inventoryTable[item.name] = list
    end

    return inventoryTable
end

Chest = peripheral.find("minecraft:chest")
Vault = peripheral.find("create:item_vault")

local inventory = getInventory()

table_exp.inspect(inventory["minecraft:stone"])