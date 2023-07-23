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
        printError(("Not enough items to dispense %d. Would you like to dispense the available %d? Y/N"):format(amount,
            amountAvailable))
        local choice = read(nil, nil, function(text)
            return completion.choice(text, { "y", "n" })
        end)
        if string.lower(choice) == "y" then
            dispense(inventory, key, amountAvailable)
            return
        else
            return
        end
    end

    table.sort(items, function(a, b)
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
        Chest.pullItems(inventoryEntry.vault, inventoryEntry.slot, amountToDispense)
        amountLeft = amountLeft - amountToDispense
    end

    print()
    print(("Dispensed %d %s"):format(amount, common.displayNames[key]))
end

function requestUserInput(vaults)
    local inventory = common.getInventory(vaults)

    local keys = {}

    for _, value in pairs(table_exp.getKeys(inventory)) do
        table.insert(keys, common.displayNames[value])
    end

    table.sort(keys)

    print("What would you like to dispense?")
    local choice

    local choice = common.readWithTimeout(30, function(text)
        return completion.choice(text, keys)
    end)

    if (choice == nil) then
        return nil
    end

    term.clear()
    term.setCursorPos(1, 1)

    local key = table_exp.getByValue(common.displayNames, choice)
    if (key == nil) then
        printError(("Could not find any item Named %s in Storage"):format(choice))
        return nil
    end

    print("How many items?")
    local amount = nil

    while amount == nil do
        local input = common.readWithTimeout(30, nil)
        if (input == nil) then return end

        amount = tonumber(input)
        if (amount == nil or amount < 0) then
            print("please enter a valid number")
        end
    end

    return key, amount
end

function main()
    Chest = peripheral.find("minecraft:chest")
    local vaults = { peripheral.find("create:item_vault") }

    if (Chest == nil) then
        printError("No Output Chest found")
        return
    end

    if (next(vaults) == nil) then
        printError("No Vault found")
        return
    end

    while (true) do
        term.clear()
        term.setCursorPos(1, 1)

        local key, amount

        while (key == nil) do
            key, amount = requestUserInput(vaults)
        end

        local inventory = common.getInventory(vaults)
        dispense(inventory, key, amount)

        print("Press any key to dispense next item")
        os.pullEvent("key")
    end
end

return main
