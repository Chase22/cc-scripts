local basalt = require "basalt"
local common = require "common"
local table_exp = require "tableexp"

local mainFrame = basalt.createFrame()
local list = mainFrame
    :addList("item list")
    :setPosition(1, 1)
    :setSize(w, h)
    :setScrollable(true)

local vaults = { peripheral.find("create:item_vault") }

if (next(vaults) == nil) then
    printError("No Vault found")
    return
end

local entries = {}
local inventory = common.getInventory(vaults)

for name, details in pairs(inventory) do
    local amount = 0

    for _, value in pairs(details) do
        amount = amount + value.amount
    end
    local displayName = table_exp.getOrElse(common.getDisplayNames(), name, name)

    table.insert(entries, ("%s %d"):format(displayName, amount))
end

table.sort(entries)

list:setOptions({"A", "B", "C"})

basalt.autoUpdate()
