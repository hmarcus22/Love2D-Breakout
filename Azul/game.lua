-- local Object = require "classic"
local Entity = require "entities/entity"
local Tile = require "entities/tile"
local state = require "state"
local Bucket = require "entities/bucket"
local Gameboard = require "entities/gameboard"
local Discard = require "entities/discard"



-- local tile_ = require "entities/tile_"

math.randomseed(state.seed)

local game = Entity()

local func = {}
local tiles = {}
local buckets = {}
local gameboards = {}
local discard = Discard(state.nrBuckets +1, 540, 250, true )
discard:setOwner(game)

function game:update(dt)
    --find selected tileType
    if state.left_mouse_click then
        local tType = 0
        local owner = nil
        local isSelected = false
        for _, tile in pairs(tiles) do
            if tile.selected then
                tType = tile.tType
                owner = tile.owner
                isSelected = true

                break
            end
        end

        if not isSelected then
            tType = 0
        end

        --Set owner for all of same tType and discard the rest
        
        for _, tile in pairs(tiles) do
            if tile.tType == tType and tile.owner == owner then
                tile:setOwner(gameboards[state.curentPlayer])
                tile.selected = false
                tile.choosen = true
            elseif tile.owner == owner then
                
                tile:setOwner(discard)
                tile.selected = false
                
            end
            --Add discard the rest
        end
    end

end

-- Create tiles
local tile_type = 1
for number = 1, 100 do
    
    -- print(tile_type)
    local tile = Tile(tile_type, 50, 50)
    table.insert(tiles, tile)
    -- tile:setOwner(game)
    -- print('Created tile of typ: ' .. tile_type)
    tile_type = tile_type + 1
    if tile_type >= 6 then
        tile_type = 1
    end
end

-- Create buckets and assign to game
local x_pos = 100
local width = (love.graphics.getWidth() -20 ) / state.nrBuckets
for number = 1, state.nrBuckets do
    
    local bucket = Bucket(number, x_pos)
    table.insert(buckets, bucket)
    bucket:setOwner(game)
    x_pos = x_pos + width + 5
end



--Add Gameboards
for number = 1,  state.nrPlayers do
    local gameboard = Gameboard(number)
    gameboard:initBoard()
    table.insert(gameboards, gameboard)
    gameboard:setOwner(game)
end


-- Add tiles to buckets to be put in game init?
function func.fillBuckets()
    -- Create a copy of available tiles to avoid modifying original array
    local availableTiles = {}
    for _, tile in pairs(tiles) do
        if not tile.owner then
            table.insert(availableTiles, tile)
        end
    end
    
    -- Assign tiles to buckets
    for _, bucket in pairs(buckets) do
        -- Check if we still have available tiles
        if not bucket.discard then
            for number = 1, 4 do
                if #availableTiles > 0 then
                    -- Get random tile index
                    local randomIndex = math.random(#availableTiles)
                    local selectedTile = availableTiles[randomIndex]
                    
                    -- Remove tile from available pool
                    table.remove(availableTiles, randomIndex)
                    
                    -- Assign tile to bucket
                    selectedTile:setOwner(bucket)
                    selectedTile:setInplay()
                    
                    
                    print(string.format('Assigned tile: ' .. selectedTile.id .. ' to bucket: ' .. bucket.nr))
                end
            end
        end
    end
    
    -- Set position of tiles in each bucket
    for _, bucket in pairs(buckets) do
        bucket:setOwnedEntityPos()
        print(bucket.radius)
    end
end

--Add Gameboards
for number = 1,  state.nrPlayers do


end


-- function func.checkBuckets()
--     local x, y = 50, 50
--     for _, bucket in pairs(buckets) do
--         for _, tile in pairs(bucket.ownedEntities) do
--             local x, y = bucket.body:getPosition()          
--         end
--     end
-- end
    func.fillBuckets()
    -- func.checkBuckets()




-- for _, bucket in ipairs(buckets) do
--     bucket:printOwnedEntities()
-- end

return game