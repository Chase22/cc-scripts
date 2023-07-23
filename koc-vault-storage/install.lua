local programs = {
    "dispatch.lua", "tableexp.lua", "monitor.lua", "common.lua"
}

local completion = require "cc.completion"

function downloadFile(file)
    if (fs.exists(file)) then fs.delete(file) end

    shell.run(("wget https://raw.githubusercontent.com/Chase22/cc-scripts/main/koc-vault-storage/%s"):format(file))
end

function startup(program)
    local startup = fs.open("startup", "w")
    startup.write(("shell.run(\"%s\")"):format(program))
    startup.close()
end

for key, value in pairs(programs) do
    downloadFile(value)
end

read()

term.clear()
term.setCursorPos(1,1)
print("Should this computer be a dispatcher or monitor?")

local choice = read(nil, nil, function(text)
    return completion.choice(text, {"dispatcher", "monitor"})
end)
if choice == "dispatcher" then
    startup("dispath") 
    os.reboot()
elseif choice == "monitor" then
    startup("monitor")
    os.reboot()
else
    printError("Invalid selection")
    return
end