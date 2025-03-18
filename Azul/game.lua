-- local Object = require "classic"
local Entity = require "entities/entity"
local Tile = require "entities/tile"
local state = require "state"
local Bucket = require "entities/bucket"
-- local tile_ = require "entities/tile_"

math.randomseed(state.seed)

local game = Entity()

local func = {}
local tiles = {}
local buckets = {}




-- Create tiles and assign to game
local tile_type = 1
for number = 1, 100 do
    
    -- print(tile_type)
    local tile = Tile(tile_type, 50, 50)
    table.insert(tiles, tile)
    tile:setOwner(game)
    -- print('Created tile of typ: ' .. tile_type)
    tile_type = tile_type + 1
    if tile_type >= 6 then
        tile_type = 1
    end
end

-- Create buckets and assign to game
local x_pos = 100
local width = (love.graphics.getWidth() - 20 ) / 4
for number = 1, 4 do
    
    local bucket = Bucket(number, x_pos)
    table.insert(buckets, bucket)
    bucket:setOwner(game)
    x_pos = x_pos + width + 5
end



function func.fillBuckets()
    
    for _, bucket in pairs(buckets) do

        local rndKey = func.getRandomTileKey()
        for key, tile in pairs(tiles) do
            if key == rndKey then
                tile:printOwner()
                tile:setOwner(bucket)
                tile:setInplay()
                tile:printOwner()
                print('Tile is in play: ' ..tostring(tile.InPlay))
                bucket:setOwnedEntityPos()
            
            end
        end
    end
end

function func.getRandomTileKey()
    local firstKey, lastKey = 1, #tiles
    local con = true
    local key
    while con do
         key = math.random(firstKey, lastKey)
         print(tiles[key].owner:is(Entity))
        if tiles[key].owner:is(Entity) then
            
            con = false
        else
            
        end
    end
        return key
end


    func.fillBuckets()
 




-- for _, bucket in ipairs(buckets) do
--     bucket:printOwnedEntities()
-- end

return game