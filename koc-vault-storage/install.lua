local programs = {
    "dispatch.lua", "tableexp.lua", "monitor.lua", "common.lua"
}

local completion = require "cc.completion"

function downloadFile(file, filename)
    if filename == nil then
        filename = file
    end

    if (fs.exists(filename)) then fs.delete(filename) end

    shell.run(("wget https://raw.githubusercontent.com/Chase22/cc-scripts/main/koc-vault-storage/%s %s"):format(file, filename))
end

for key, value in pairs(programs) do
    downloadFile(value)
end

downloadFile("startup.lua", "startup")

read()

os.reboot()
