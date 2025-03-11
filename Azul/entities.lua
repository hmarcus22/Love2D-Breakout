local state = require('state')
local player = require('entities/player')
local tile = require('entities/tile')
local gameboard = require "entities/gameboard"

local entities = {}

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

  

return entities

