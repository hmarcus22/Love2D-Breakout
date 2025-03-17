local state = require('state')
local Player = require('entities/player')
local Tile = require "entities/tile"
local Gameboard = require "entities/gameboard"
local Bucket = require "entities/bucket"
local Object = require "classic"
local Mouse = require "entities/mouse"



local entities = {
    Mouse(),
    Gameboard()
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
    
    -- for number = 1, state.nrPlayers do
    --     local board = Gameboard()
    --     table.insert(entities, Player("name", number, board))
    -- end

    -- Add buckets
    for number = 1, state.nrBuckets do
        
        local x_pos = ((love.graphics.getWidth() - 40) / state.nrBuckets)

        local bucket = Bucket(number, x_pos)
        
        table.insert(entities, bucket)
        x_pos = x_pos + x_pos
    end
    
    function entities:getTileKeys()
        
        local firsKey = 1
        local lastKey = 1
        for key, entity in ipairs(self) do
            if entity:is(Tile) then
                if key < firsKey then 
                    firsKey = key
                elseif key > lastKey then
                    lastKey = key
                end
            end
        end
        return firsKey, lastKey 

    end
    
    function entities:getRndTile()

        local fKey, lKey = entities:getTileKeys()
        local key = math.random(fKey, lKey)
        return key 
    end

    function entities:getEntitiesKeys(type)

        local buckets = {}
        local tiles = {}
        local players = {}
        local gameboards = {}
        for key, entity in ipairs(self) do
            if entity:is(Bucket) then
                table.insert(buckets, key)
            elseif entity:is(Tile) then
                table.insert(tiles, key)
            elseif entity:is(Player) then
                table.insert(players, key)
            elseif entity:is(Gameboard) then
                table.insert(gameboards, key)
            end
        end
        
        if type == 'bucket' then
            print(#buckets)
            return buckets
        end
    end

    function entities:fillBuckets()
        local keys = entities:getEntitiesKeys('bucket')
        for _, key in ipairs(keys) do
            print("Processing bucket:", key)
            print("Initial bucket state:", #self[key].tileBucket)
            
            while self[key].isNotFull do
                local tKey = entities:getRndTile()
                print("Got tile:", tKey)
                
                -- Add debug info before calling addTile
                print("Before addTile call:")
                print("Bucket contents:", #self[key].tileBucket)
                print("Is bucket not full?", self[key].isNotFull)
                
                self[key].addTile(tKey)
                
                -- Add debug info after calling addTile
                print("After addTile call:")
                print("Bucket contents:", #self[key].tileBucket)
                print("Is bucket full?", self[key].isNotFull)
            end
            
            print("Finished processing bucket:", key)
            print("Final bucket state:", #self[key].tileBucket)
        end
    end

    
    -- function entities:fillBuckets()
        
    --     local keys = entities:getEntitiesKeys('bucket')
    --     for _, key in ipairs(keys) do            
    --         while self[key].isNotFull do
    --             local tKey = entities:getRndTile()
    --             print(tKey)
    --             self[key].addTile(tKey)
    --         end
    --     end
    


        
    --     -- local x, y = 50, 20
    --     -- for nr = 1, 5 do
    --     --     local number = 1
    --     --     while number <= 5 do
    --     --         local key = math.random(4, 104)
    --     --         local entity = entities:getRndTile()
    --     --         if entity:is(Tile) and (not entity.inPlay) then
    --     --             entity:setInplay(nr, x, y)
    --     --             x, y = x + 32, y + 32
    --     --             print(entity.tType)
    --     --             number = number + 1
    --     --         end
                
    --     --     end
    --     --     x, y = x + 20, 20
    --     -- end
    -- end

    function entities:draw()
        for _, entity in pairs(entities) do
            if type(entity) == "table" and entity.draw then 
                
                entity:draw()
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

