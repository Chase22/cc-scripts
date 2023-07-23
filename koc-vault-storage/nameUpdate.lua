local common = require "common"

function main()
    local vaults = { peripheral.find("create:item_vault") }

    while true do
        common.updateDisplayNames(vaults)
    end
end

return main
