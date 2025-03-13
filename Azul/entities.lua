local state = require('state')
local player = require('entities/player')
local Tile = require "entities/tile"
local gameboard = require "entities/gameboard"
local Bucket = require "entities/bucket"
local Object = require "classic"



local entities = {}

    

    --Add tiles

    local tileType = 1
    local x_pos = 20
    for number = 1, 100 do
        
        local lTile = Tile(tileType, x_pos, 20)
        table.insert(entities, lTile)
        
        if tileType >= 5 then
            
            tileType = 1
            
        else
            tileType = tileType + 1
        end
        x_pos = x_pos + 35
    end    

    --Add players
    
    for number = 1, state.nrPlayers do
        local board = gameboard()
        table.insert(entities, player("name", number, board))
    end

    -- Add buckets
    for number = 1, state.nrBuckets do
        local bucket = Bucket(number)
        table.insert(entities, bucket)
    end

    local function entities:draw()
        for _, entity in pairs(entities) do
            if type(entity) == "table" and entity.hasDraw then 
                
                entity:render()
            end
        end
    end

    local function entities:moveTileToBucket()
    
        --Do stuff
    end


    -- Remember

    -- table.insert(t, table.remove(t, key))


return entities

