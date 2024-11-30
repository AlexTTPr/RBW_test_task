local oop = {}

function oop.inherit(parent)
    local child = {}
    return setmetatable(child, {__index = parent})
end

function oop.init(obj, class)
    class.__index = class
    return setmetatable(obj, class)
end

return oop