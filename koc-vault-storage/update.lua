local programs = {
    "dispatch.lua", "tableexp.lua", "inventoryInspect.lua", "update.lua", "monitor.lua", "common.lua", "benchmark.lua"
}

for key, value in pairs(programs) do
    shell.run(("rm %s"):format(value))
    shell.run(("wget http://192.168.1.194:8080/%s"):format(value))
end
