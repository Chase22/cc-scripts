local basalt = require "basalt"


local main = basalt.createFrame()
local aList = main:addList():setScrollable(true)
local scrollbar = main:addScrollbar():setPosition("{parent.w-1}",1):setSize(1,15):setScrollAmount(10)

scrollbar:onChange(function (self, _, value)
    aList:setOffset(value-1)
end)

local entries = {}

for i = 1, 40,1 do
    table.insert(entries, ("%d"):format(i))
end

aList:setOptions(entries)

basalt.autoUpdate()