local table_exp = require "tableexp"

local common = {}

local displayNamesFile = "displayNames"

function common.getInventory(vaults)
    local inventoryTable = {}

    for _, vault in pairs(vaults) do
        local name = peripheral.getName(vault)

        for slot, item in pairs(vault.list()) do    
            local list = table_exp.getOrElse(inventoryTable, item.name, {})
            table.insert(list, { slot = slot, amount = item.count, vault = name })
    
            inventoryTable[item.name] = list
        end
    end
    
    return inventoryTable
end

function common.updateDisplayNames(vaults)

    local vaultNames = {}
    local displayNames = {}

    for _, vault in pairs(vaults) do
        local name = peripheral.getName(vault)
        vaultNames[name] = vault
    end

    for key, entry in pairs(common.getInventory(vaults)) do
        local details = vaultNames[entry[1].vault].getItemDetail(entry[1].slot)
        if (details ~= nil) then displayNames[key] = details.displayName end
    end

    local names = fs.open(displayNamesFile, "w")
    names.write(textutils.serialize(displayNames))
    names.close()
end

function common.getDisplayNames()
    local names = fs.open(displayNamesFile, "r")
    if (names == nil) then
        return {}
    end

    local displayNames = textutils.unserialize(names.readAll())
    names.close()

    return displayNames
end

function common.readWithTimeout(timeout, autocomplete)
    local result
    parallel.waitForAny(
        function()
          result = read(nil, nil, autocomplete)
        end,
      
        function()
          local myTimer = os.startTimer(timeout)
      
          while true do
            local myEvent = {os.pullEvent()}
      
            if myEvent[1] == "timer" and myEvent[2] == myTimer then
              break
      
            elseif myEvent[1] == "char" then
              os.pullEvent("yield forever")
      
            end
          end
        end
      )
      return result
end

return common