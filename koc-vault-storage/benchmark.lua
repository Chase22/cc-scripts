local common = require "common"
local vaults = { peripheral.find("create:item_vault") }

function measure(vaults)
    local start = os.epoch("local")
    common.getInventory(vaults)
    local finish = os.epoch("local")

    return finish - start
end

local elapsed = 0

for i = 1, 10, 1 do
    elapsed = elapsed + measure(vaults)
end

print(("Average: %d"):format(elapsed/10))