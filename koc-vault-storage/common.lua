local table_exp = require "tableexp"

local common = {}

common.displayNames = {}

function common.getInventory(vault)
    local inventoryTable = {}

    for slot, item in pairs(vault.list()) do
        local details = vault.getItemDetail(slot)
        common.displayNames[item.name] = details.displayName

        local list = table_exp.getOrElse(inventoryTable, item.name, {})
        table.insert(list, { slot = slot, amount = item.count })

        inventoryTable[item.name] = list
    end

    return inventoryTable
end

return common