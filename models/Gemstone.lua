local oop = require("etc.oop")
local FieldItemBase = require("models.FieldItemBase")

local Gemstone = oop.inherit(FieldItemBase)

function Gemstone:new(symb)
    local public = FieldItemBase:new()
    public.symb = symb
    return oop.init(public, Gemstone)
end

return Gemstone