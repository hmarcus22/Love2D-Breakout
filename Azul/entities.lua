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

    function entities:draw()
        for _, entity in pairs(entities) do
            if type(entity) == "table" and entity.hasDraw and entity.inPlay then 
                
                entity:render()
            end
        end
    end
        
    function entities:fillBuckets()
        local x, y = 10, 10
        for x = 1, 5 do
            for number = 1, 5 do
                
                local key = math.random(4, 104)
                local entity = entities[key]
                print('Key is: ' .. key, 'Type is: ' .. type(entity), entity:is(Tile))
                
                if entity:is(Tile) and (not entity.inPlay) then
                entity.bucket = 1
                entity.x, entity.y = x, y
                entity.body:setX(x)
                entity.body:setY(y)
                entity.inPlay = true
                x, y = x + 10, y + 10
                print(entity.tType)
                end
            end
            
            local x, y = x + 200, 10
        end
    end
 


    -- Remember

    -- table.insert(t, table.remove(t, key))


return entities

