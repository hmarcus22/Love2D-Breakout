local state = require('state')
local player = require('entities/player')
local tile = require('entities/tile')
local gameboard = require "entities/gameboard"
local bucket = require "entities/bucket"

local entities = {
    bucket(1),
    bucket(2),
    bucket(3)
}

    --Add tiles
    local tileType = 1
    local x_pos = 20
    for number = 0, state.nrTiles do
        if tileType <= 5 then
            table.insert(entities, tile(tileType, x_pos, 20))
            tileType = tileType + 1
            x_pos = x_pos + 35
        else
            tileType = 1
        end
    end

    --Add players
    
    for number = 1, state.nrPlayers do
        local board = gameboard()
        table.insert(entities, player("name", number, board))
    end

    -- Move tiles to buckets
    function entities:moveTileToBucket()

        local nrBuckets = 3
        local tmpBucket = {}
        local count = 1
        for _, cBucket in ipairs(self) do
            tmpBucket = nil
            if bucket.type == 'bucket' then
                for i, tile in ipairs(self) do

                    if count <=5 then
                        if tile.type == 'tile' then
                            cBucket:addTiles(tile)
                            table.remove(self, i)
                            
                            count = count + 1
                        end
                    end

                end
            end
            
        end
    end

return entities

