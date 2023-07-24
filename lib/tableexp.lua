local table_exp = {}

local pretty = require "cc.pretty"

function table_exp.getOrElse(table, key, default)
    local value = table[key]
    if (value ~= nil) then
        return value
    else
        return default
    end
end

function table_exp.inspect(table)
    term.clear()
    term.setCursorPos(1,1)

    local doc = pretty.pretty(table)
    local text = pretty.render(doc, 50)

    textutils.pagedPrint(text, 5)
end

function table_exp.getKeys(source)
    local keyset = {}
    local n = 0
    for k, v in pairs(source) do
        table.insert(keyset, k)
    end
    return keyset
end

function table_exp.getByValue(source, search)
    for key, value in pairs(source) do
        if value == search then
            return key
        end
    end
    return nil
end

function table_exp.find(source, filter)
    for key, value in pairs(source) do
        if (filter(key, value)) then
            return value
        end
    end

    return nil
end

return table_exp