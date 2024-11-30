local oop = require("etc.oop")
local helpers = require("etc.helpers")
local Gemstone = require("models.Gemstone")

local PlayingField = {}

function PlayingField:new(height, width, gemstones)
    local public = {
        field = {},
        width = width,
        height = height,
        gemstones = gemstones
    }

    local obj = oop.init(public, PlayingField)
    
    for i = 1, obj.height do
        obj.field[i] = {}
        for j = 1,obj.width do
            obj.field[i][j] = helpers.getRandomElement(obj.gemstones)
        end
    end

    return obj
end

function PlayingField:findMatches()
    local hasMatches = false
    local matchField = {}

    for i = 1, self.height do
        matchField[i] = {}
        for j = 1, self.width do
            matchField[i][j] = false
        end
    end

    for i = 1, self.height do
        local seqLength = 1
        for j = 1, self.width - 1 do
            if self.field[i][j] == self.field[i][j + 1] then
                seqLength = seqLength + 1
            else
                if seqLength >= 3 then
                    hasMatches = true
                    for k = j - seqLength + 1, j do
                        matchField[i][k] = true
                    end
                end
                seqLength = 1
            end
        end

        if seqLength >= 3 then
            hasMatches = true
            for k = self.width - seqLength + 1, self.width do
                matchField[i][k] = true
            end
        end
    end

    for j = 1, self.width do
        local seqLength = 1
        for i = 1, self.height - 1 do
            if self.field[i][j] == self.field[i + 1][j] then
                seqLength = seqLength + 1
            else
                if seqLength >= 3 then
                    hasMatches = true
                    for k = i - seqLength + 1, i do
                        matchField[k][j] = true
                    end
                end
                seqLength = 1
            end
        end

        if seqLength >= 3 then
            hasMatches = true
            for k = self.height - seqLength + 1, self.height do
                matchField[k][j] = true
            end
        end
    end
    
    return hasMatches, matchField
end

function PlayingField:removeMatches(matchField)
    for i = 1, self.height do
        for j = 1, self.width do
            if matchField[i][j] == true then
                self.field[i][j] = nil
            end
        end
    end 
end

function PlayingField:fillPlayingField()
    for i = 1, self.width do
        local replaceIndex
        for j = self.height, 1, -1 do
            if self.field[j][i] == nil then
                replaceIndex = j
                for k = replaceIndex - 1, 1, -1 do
                    if self.field[k][i] ~= nil then
                        self.field[replaceIndex][i], self.field[k][i] = self.field[k][i], self.field[replaceIndex][i]
                        break
                    end
                end
            end
        end
    end

    for i = 1, self.width do
        for j = 1, self.height do
            if self.field[j][i] == nil then
                self.field[j][i] = helpers.getRandomElement(self.gemstones)
            end
        end
    end
end

function PlayingField:hasPossibleMatches()
    for i = 1, self.height do
        for j = 1, self.width - 1 do
            local sameGems = 1
            local diffGems = 0
            for k = j + 1, self.width do
                if self.field[i][j] == self.field[i][k] then
                    sameGems = sameGems + 1
                else
                    diffGems = diffGems + 1
                end

                if sameGems == 3 then 
                    return true
                end

                if diffGems == 2 then
                    break
                end
            end
        end
    end

    for i = 1, self.width do
        for j = 1, self.height - 1 do
            local sameGems = 1
            local diffGems = 0
            for k = j + 1, self.height do
                if self.field[j][i] == self.field[k][i] then
                    sameGems = sameGems + 1
                else
                    diffGems = diffGems + 1
                end

                if sameGems == 3 then 
                    return true
                end

                if diffGems == 2 then
                    break
                end
            end
        end
    end

    return false
end

function PlayingField:mix()
    for i = 1, self.height do
        for j = 1, self.width do
            local randRow = math.random(1, self.height)
            local randCol = math.random(1, self.width)

            self.field[i][j], self.field[randRow][randCol] = self.field[randRow][randCol], self.field[i][j]
        end
    end
end

function PlayingField:move(from, to)
    if from.x < 1 or from.x > self.width or from.y < 1 or from.y > self.height then
        error("Coordinates of the first element out of field's bounds")
    end

    if to.x < 1 or to.x > self.width or to.y < 1 or to.y > self.height then
        error("Coordinates of the second element out of field's bounds")
    end

    if math.abs(from.x - to.x) + math.abs(from.y - to.y) ~= 1 then
        error("Elements are not nearby")
    end

    self.field[from.y][from.x], self.field[to.y][to.x] = self.field[to.y][to.x], self.field[from.y][from.x]
end

return PlayingField