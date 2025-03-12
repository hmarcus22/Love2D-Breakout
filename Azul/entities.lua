local state = require('state')
local player = require('entities/player')
local tile = require('entities/tile')
local gameboard = require "entities/gameboard"
local Bucket = require "entities/bucket"
local Object = require "classic"

local entities = {
    Bucket(1),
    Bucket(2),
    Bucket(3)
}

    --Add players
    
    for number = 1, state.nrPlayers do
        local board = gameboard()
        table.insert(entities, player("name", number, board))
    end

    --Add tiles

    local tileType = 1
    local x_pos = 20
    for number = 1, 100 do

        entities[#entities +1] = tile(tileType, x_pos, 20)
        
        if tileType >= 5 then
            
            tileType = 1
            
        else
            tileType = tileType + 1
            x_pos = x_pos + 35  
        end
        
    end

    -- for _, entity in ipairs(entities) do
    --     if entity:is(tile) then
    --         print('tile of type: ' .. entity.tType)
    --     end
    -- end

    for _, entity in ipairs(entities) do
        if entity.draw then print(entity.tType) end
    end

    function entities:draw()
        for _, entity in ipairs(self) do
            if entity.draw then entity:draw() end
        end
    end

    -- Remember

    -- table.insert(t, table.remove(t, key))


return entities

