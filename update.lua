local programs = {
    {"lib/tableexp.lua", "tableexp.lua"},
    {"lib/common.lua", "common.lua"},

    {"src/dispatch.lua", "dispatch.lua"},
    {"src/monitorVault.lua", "monitorVault.lua"},
    {"src/nameUpdate.lua", "nameUpdate.lua"},

    {"update.lua", "update.lua"},
    { "startup.lua", "startup" }
}

local address = fs.open("address", "r").readAll()

for key, value in pairs(programs) do
    local remoteName, localName

    if (type(value) == "table") then
        remoteName, localName = table.unpack(value)
    else
        remoteName = value
        localName = value
    end

    fs.delete(localName)
    shell.run(("wget http://%s/%s %s"):format(address, remoteName, localName))
end
