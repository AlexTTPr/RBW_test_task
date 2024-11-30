local PlayingField = require("models.PlayingField")
local Gemstone = require("models.Gemstone")

local game = {}

function game:init()
    self.playingField = PlayingField:new(10, 10, {Gemstone:new('A'), Gemstone:new('B'), Gemstone:new('C'), Gemstone:new('D'), Gemstone:new('E'), Gemstone:new('F')})
    game:tick()
end

function game:move(from, to)
    self.playingField:move(from, to)
    self:tick()
end

function game:tick()
    local hasMatches, matchesField = self.playingField:findMatches()
    while hasMatches do
        self.playingField:removeMatches(matchesField)
        self.playingField:fillPlayingField()
        hasMatches, matchesField = self.playingField:findMatches()
    end
    self:dump()
end

function game:mix(from, to)
    repeat
    self.playingField:mix()
    local hasMatches = self.playingField:findMatches()
    until hasMatches
    tick()
end

function game:dump()
    io.write("    0 1 2 3 4 5 6 7 8 9\n")
    io.write("    -------------------\n")
    local num = 0
    for i = 1, #self.playingField.field do
        io.write(num .. " | ")
        num = num + 1
        for j = 1, #self.playingField.field[i] do
            io.write(self.playingField.field[i][j].symb .. " ")
        end
        io.write("\n")
    end

    io.write("\n")
end

return game