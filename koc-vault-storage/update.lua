local programs = {
    "dispatch.lua",
    "tableexp.lua",
    "inventoryInspect.lua",
    "update.lua",
    "monitorVault.lua",
    "common.lua",
    "benchmark.lua",
    "nameUpdate.lua",
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
