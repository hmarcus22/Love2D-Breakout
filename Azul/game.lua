-- local Object = require "classic"
local Entity = require "entities/entity"
local Tile = require "entities/tile"
local state = require "state"

math.randomseed(state.seed)

local game = Entity()

local tiles = {}


for number = 1, 100 do
    local tile_type = 1
    local tile = Tile(tile_type, 50, 50)
    table.insert(tiles, tile)
    tile:setOwner(game)
    tile.inPlay = true
    print(tile.id)
    tile_type = tile_type + 1
    if tile_type >=6 then
        tile_type = 1
    end
end

for _, entity in ipairs(tiles) do
    print(entity.owner.id .. ' ' .. tostring(entity.inPlay))
end

return game