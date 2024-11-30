local oop = require("etc.oop")

local FieldItemBase = {}

function FieldItemBase:new()
    local public = {
        symb = nil
    }
    return oop.init(public, self)
end

return FieldItemBase