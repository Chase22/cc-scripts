local common = require "common"

local monitor = peripheral.find("monitor")
local vault = peripheral.find("create:item_vault")

string.lpad = function(str, len, char)
    if char == nil then char = ' ' end
    return str .. string.rep(char, len - #str)
end

if (vault == nil) then
    printError("No Vault found")
    return
end

print(("Updating monitor %s"):format(peripheral.getName(monitor)))

while true do
    local entries = {}
    local longestName = -1
    local inventory = common.getInventory(vault)
    
    for name, details in pairs(inventory) do
        local amount = 0
    
        for key, value in pairs(details) do
            amount = amount + value.amount
        end
        local displayName = common.displayNames[name]
        longestName = math.max(longestName, #displayName)
    
        table.insert(entries, { displayName, ("%s"):format(amount), ("%s"):format(#details) })
    end
    
    table.sort(entries, function(a, b)
        return a[1] < b[1]
    end)
    
    local old_term = term.redirect(monitor)
    term.clear()
    term.setCursorPos(1, 1)
    for key, value in pairs(entries) do
        print(("%s \t %s %s"):format(string.lpad(value[1], longestName), value[2], value[3]))
    end
    term.redirect(old_term)     
end