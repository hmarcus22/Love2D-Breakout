local state = require('state')
local player = require('entities/player')
local Tile = require "entities/tile"
local gameboard = require "entities/gameboard"
local Bucket = require "entities/bucket"
local Object = require "classic"
local Mouse = require "entities/mouse"



local entities = {
    Mouse()
}

    

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

    function entities:fillBuckets()
        local x, y = 50, 20
        for nr = 1, 5 do
            for number = 1, 5 do
                local key = math.random(4, 104)
                local entity = self[key]
                if entity:is(Tile) and (not entity.inPlay) then
                    entity:setBucket(nr, x, y)
                    x, y = x + 32, y + 32
                    print(entity.tType)
                end
            end
            x, y = x + 50, 20
        end
    end

    function entities:draw()
        for _, entity in pairs(entities) do
            if type(entity) == "table" and entity.hasDraw and entity.inPlay then 
                
                entity:render()
            end
        end
    end
        
   function entities:update(dt)

        for _, entity in pairs(entities) do
            if type(entity) == "table" and entity.update  then
                
                entity:update(dt)
            end
        end

   end
 


    -- Remember

    -- table.insert(t, table.remove(t, key))


return entities

