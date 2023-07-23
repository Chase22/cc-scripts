local table_exp = require "tableexp"
local completion = require "cc.completion"
local common = require "common"

function dispense(inventory, key, amount)
    local amountLeft = amount
    local items = inventory[key]

    local amountAvailable = 0
    for key, value in pairs(items) do
        amountAvailable = amountAvailable + value.amount
    end

    if (amountAvailable < amount) then
        printError(("Not enough items to dispense %d. Would you like to dispense the available %d? Y/N"):format(amount, amountAvailable))
        local choice = read(nil, nil, function(text)
            return completion.choice(text, {"y", "n"})
        end)
        if string.lower(choice) == "y" then
            dispense(inventory, key, amountAvailable)
            return
        else
            return
        end
    end

    table.sort(items, function (a,b)
        return a.amount < b.amount
    end)

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

    print()
    print(("Dispensed %d %s"):format(amount, common.displayNames[key]))
end

term.clear()
term.setCursorPos(1, 1)

Chest = peripheral.find("minecraft:chest")
Vault = peripheral.find("create:item_vault")

if (Chest == nil) then
    printError("No Output Chest found")
    return
end

if (Vault == nil) then
    printError("No Vault found")
    return
end

local inventory = common.getInventory(Vault)

local keys = {}

for key, value in pairs(table_exp.getKeys(inventory)) do
    table.insert(keys, common.displayNames[value])
end

print("What would you like to dispense?")
local choice = read(nil, nil, function(text)
    return completion.choice(text, keys)
end)

term.clear()
term.setCursorPos(1, 1)

local key = table_exp.getByValue(common.displayNames, choice)
if (key == nil) then
    printError(("Could not find any item Named %s in Storage"):format(choice))
    return
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
 
dispense(inventory, key, amount)

print("Press any key to dispense next item")
os.pullEvent("key")
shell.run("dispatch")