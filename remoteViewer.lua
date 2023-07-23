rednet.open("left")

local function toggleRedstone(senderId, message, protocol)
    if(senderId ~= 1) then return end
    if(protocol~= "chaseDoorProtocol") then return end
    if(message ~= "toggleDoor") then return end

    redstone.setOutput("back", not redstone.getOutput("back"))
end 

while true do
    toggleRedstone(rednet.receive("chaseDoorProtocol"))
end