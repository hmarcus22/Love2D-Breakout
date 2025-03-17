local Object = require "classic"

local Player = Object:extend()

function Player:new(name, id, gameboard)
    
    self.id = id
    self.name = (name or "n/a")
    self.gameboard = gameboard
end

function Player:pNumber()
    print(self.id)
end

return Player