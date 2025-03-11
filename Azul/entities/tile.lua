local Object = require "classic"
local state = require "state"
local world = require "world"

local tile = Object:extend()  

    function tile:new(type, x, y)
        self.tType = (type or 1)
        self.size = 30
        self.name = "I'm a tile" 
        self.x = x
        self.y = (y or 20)
        self.body = love.physics.newBody(world, x, y, 'dynamic')       
        self.shape = love.physics.newRectangleShape(self.size, self.size)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.type = 'tile'
    end

    function tile:pType()
        print(self.tType)
    end

    function tile:draw()
        love.graphics.setColor(state.palette[self.tType])
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.setColor(state.palette[5])
    end

return tile



