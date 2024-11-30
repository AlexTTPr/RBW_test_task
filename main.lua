local helpers = require("etc.helpers")
local game = require("presentation.game")

local directions = {
    l = {x = -1, y = 0},
    r = {x = 1, y = 0},
    u = {x = 0, y = -1},
    d = {x = 0, y = 1}
}

game:init()

while true do
    local input = io.read()
    if input == "q" then
        break
    else
        local params = helpers.splitString(input)
        local x = tonumber(params[2])
        local y = tonumber(params[3])
        local dir = directions[params[4]]
        if #params ~= 4 or not x or not y or not dir then
            print("Invalid input")
        else
            game:move({x = x + 1, y = y + 1}, {x = x + 1 + dir.x, y = y + 1 + dir.y})
        end         
    end
end