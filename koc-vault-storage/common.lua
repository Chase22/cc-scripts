local table_exp = require "tableexp"

local common = {}

common.displayNames = {}

function common.getInventory(vaults)
    local inventoryTable = {}

    local vaultNames = {}

    for _, vault in pairs(vaults) do
        local name = peripheral.getName(vault)
        vaultNames[name] = vault

        for slot, item in pairs(vault.list()) do
            if (details ~= nil) then 
                common.displayNames[item.name] = details.displayName 
            end
    
            local list = table_exp.getOrElse(inventoryTable, item.name, {})
            table.insert(list, { slot = slot, amount = item.count, vault = name })
    
            inventoryTable[item.name] = list
        end
    end

    for key, entry in pairs(inventoryTable) do
        local details = vaultNames[entry[1].vault].getItemDetail(entry[1].slot)
        common.displayNames[key] = details.displayName
    end
    
    return inventoryTable
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