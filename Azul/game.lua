-- local Object = require "classic"
local Entity = require "entities/entity"
local Tile = require "entities/tile"
local state = require "state"

math.randomseed(state.seed)

local game = Entity()

local tile = Tile(1, 20, 20)

print(game.id)
print (tile.id)
-- print(generateUUID())

tile:setOwner(game)


return game