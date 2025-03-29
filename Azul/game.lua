-- local Object = require "classic"
local Entity = require "entities/entity"
local Tile = require "entities/tile"
local state = require "state"
local Bucket = require "entities/bucket"
local Gameboard = require "entities/gameboard"
local Discard = require "entities/discard"
local DrawOrder = require "entities/draworder"
local Button = require "entities/button"


-- local tile_ = require "entities/tile_"

math.randomseed(state.seed)

local game = Entity()
local discard = Discard(state.nrBuckets +1, 540, 250, true )
discard:setOwner(game)
local func = {}
local tiles = {}
local buckets = {}
local gameboards = {}
local buttons = {}
local drawOrder = DrawOrder()

function game:drawAll()
    drawOrder:drawOrderly()
end

function game:update(dt)
    --find selected tileType
    if not drawOrder:isEmpty() and state.update then
        drawOrder:update(dt)
        state.update = false
    end
    
    if state.left_mouse_click then
        local tType = 0
        local owner = nil
        local isSelected = false
        for _, tile in pairs(tiles) do
            if tile.selected and not tile.placed then
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
        if isSelected then
            for _, tile in pairs(tiles) do
                if tile.highlight and not tile.placed and tile.tType == tType then
                    
                    tile:setOwner(gameboards[state.curentPlayer])
                    tile.selected = false
                    tile.choosen = true
                    
                elseif owner == tile.owner and not tile.placed then
                    --Else add to discard
                    
                    tile:setOwner(discard)
                    tile.selected = false
                    
                end
            end
            state.update = true
        end
    end
end

-- Create tiles
local tile_type = 1
for number = 1, 100 do
    local tile = Tile(tile_type, 50, 50)
    table.insert(tiles, tile)
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

--Create test button
local doneButton = Button(900, 450, 100, 40, 'Done')
doneButton:setOwner(game)
table.insert(buttons, doneButton)


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
            end
        end
        
    end
    
    -- Set position of tiles in each bucket
    for _, bucket in pairs(buckets) do
        bucket:setOwnedEntityPos()
        print(bucket.radius)
    end
end
    func.fillBuckets()

    for _, entity in pairs(game.ownedEntities) do
        drawOrder:add(entity)
    end
    for _, entity in pairs(tiles) do
        drawOrder:add(entity)
    end

return game