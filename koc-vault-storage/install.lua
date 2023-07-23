local programs = {
    "dispatch.lua", "tableexp.lua", "monitor.lua", "common.lua"
}

local completion = require "cc.completion"

function downloadFile(file, filename)
    if (fs.exists(file)) then fs.delete(file) end

    if filename == nil then
        filename = file
    end

    shell.run(("wget https://raw.githubusercontent.com/Chase22/cc-scripts/main/koc-vault-storage/%s %s"):format(file, filename))
end

function startup(program)
    local startup = fs.open("startup", "w")
    startup.write(("shell.run(\"%s\")"):format(program))
    startup.close()
end

for key, value in pairs(programs) do
    downloadFile(value)
end

downloadFile("startup.lua", "startup")

read()

os.reboot()
