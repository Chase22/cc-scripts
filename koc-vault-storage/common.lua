local table_exp = require "tableexp"

local common = {}

common.displayNames = {}

function common.getInventory(vaults)
    local inventoryTable = {}

    for _, vault in pairs(vaults) do
        local name = peripheral.getName(vault)

        for slot, item in pairs(vault.list()) do
            
            local details = vault.getItemDetail(slot)
            if (details ~= nil) then 
                common.displayNames[item.name] = details.displayName 
            end
    
            local list = table_exp.getOrElse(inventoryTable, item.name, {})
            table.insert(list, { slot = slot, amount = item.count, vault = name })
    
            inventoryTable[item.name] = list
        end
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