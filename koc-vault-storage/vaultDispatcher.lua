local table_exp = require "tableexp"
local completion = require "cc.completion"
local pretty = require "cc.pretty"

string.lpad = function(str, len, char)
    if char == nil then char = ' ' end
    return str .. string.rep(char, len - #str)
end

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

function dispense(inventory, key, amount)
    local amountLeft = amount
    local items = inventory[key]
    table.sort(items, function (a,b)
        return a.amount < b.amount
    end)
    table_exp.inspect(items)

    while amountLeft > 0 do
        local inventoryEntry = table.remove(items, 1)
        local amountToDispense = 0
        if inventoryEntry.amount >= amountLeft then
            amountToDispense = amountLeft
        else 
            amountToDispense = inventoryEntry.amount
        end
        Vault.pushItems(peripheral.getName(Chest), inventoryEntry.slot, amountToDispense)
        amountLeft = amountLeft - amountToDispense
    end
end

term.clear()
term.setCursorPos(1, 1)

Chest = peripheral.find("minecraft:chest")
Vault = peripheral.find("create:item_vault")
Monitor = peripheral.wrap("monitor_0")


DisplayNames = {}

if (Chest == nil) then
    printError("No Output Chest found")
    return
end

if (Vault == nil) then
    printError("No Vault found")
    return
end

local inventory = getInventory()

local keys = {}

for key, value in pairs(table_exp.getKeys(inventory)) do
    table.insert(keys, DisplayNames[value])
end

-- for name, details in pairs(inventory) do
--     local amount = 0
--     for key, value in pairs(details) do
--         amount = amount + value.amount
--     end

--     print(("%s * %d"):format(DisplayNames[name], amount))
-- end

if (Monitor ~= nil) then
    local entries = {}
    local longestName = -1

    for name, details in pairs(inventory) do
        local amount = 0
        
        for key, value in pairs(details) do
            amount = amount + value.amount
        end
        local displayName =  DisplayNames[name]
        longestName = math.max(longestName, #displayName)

        table.insert(entries, { displayName, ("%s"):format(amount), ("%s"):format(#details) })
    end

    table.sort(entries, function (a, b)
        return a[1] < b[1]
    end)

    local old_term = term.redirect(Monitor)
    term.clear()
    term.setCursorPos(1,1)
--    textutils.tabulate(table.unpack(entries))
    for key, value in pairs(entries) do
        print(("%s \t %s %s"):format(string.lpad(value[1], longestName), value[2], value[3]))
    end
    term.redirect(old_term)
end

print("What would you like to dispense?")
local choice = read(nil, nil, function(text)
    return completion.choice(text, keys)
end)

local x, y = term.getCursorPos()
if (y > 1) then
    term.setCursorPos(1, y - 1)
    term.clearLine()
end

print("How many items?")
local amount = nil

while amount == nil do
    amount = tonumber(read())
    if (amount == nil or amount < 0) then
        print("please enter a valid number")
    end
end

term.clear()
term.setCursorPos(1,1)

print()
print(("Dispensed %d %s"):format(amount, choice))

local key = table_exp.getByValue(DisplayNames, choice)
dispense(inventory, key, amount)