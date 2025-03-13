local Object = require "classic"
local state = require "state"
local world = require "world"

local Tile = Object:extend()  

    function Tile:new(type, x, y)
        self.tType = (type or 5)
        self.size = 30
        self.x = x
        self.y = (y or 20)
        self.body = love.physics.newBody(world, x, y, 'dynamic')       
        self.shape = love.physics.newRectangleShape(self.size, self.size)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.hasDraw = true
    end

    function Tile:pType()
        print(self.tType)
    end

    function Tile:render()
        love.graphics.setColor(state.palette[self.tType])
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        
        -- Use a different color for the text based on the tile type
        if self.tType == 5 or self.tType == 2 then
            love.graphics.setColor(state.palette[4])  -- Black
        else
            love.graphics.setColor(state.palette[5])  -- White
        end
        love.graphics.print(self.tType, self.x, self.y)
    end
  
  

return Tile