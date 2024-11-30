local helpers = {}

function helpers.getRandomElement(array)
    local index = math.random(1, #array)
    return array[index]
end

function helpers.splitString(string)
    local words = {}
    for word in string:gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

return helpers