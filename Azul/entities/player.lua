local Object = require "classic"

local player = Object:extend()

function player:new(name, id, gameboard)
    
    self.id = id
    self.name = (name or "n/a")
    self.gameboard = gameboard
end

function player:pNumber()
    print(self.id)
end

return player