local programs = {
    {"lib/tableexp.lua", "tableexp.lua"},
    {"lib/common.lua", "common.lua"},

    {"src/dispatch.lua", "dispatch.lua"},
    {"src/monitorVault.lua", "monitorVault.lua"},
    {"src/nameUpdate.lua", "nameUpdate.lua"},

    {"update.lua", "update.lua"},
    { "startup.lua", "startup" }
}

for key, value in pairs(programs) do
    local remoteName, localName

    if (type(value) == "table") then
        remoteName, localName = table.unpack(value)
    else
        remoteName = value
        localName = value
    end

    fs.delete(localName)
    shell.run(("wget http://192.168.1.194:8080/%s %s"):format(remoteName, localName))
end
