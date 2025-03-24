local Object = require "classic"

local Square = Object:extend()

function Square:new(x, y, type)
    self.x = x
    self.y = y
    self.width = 50
    self.height = self.width
    self.type = type or 0
    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.free = true

end

function Square:getPos()
    return self.body:getPos()
end

return Square