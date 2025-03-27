local Object = require "classic"
local world = require "world"
local state = require "state"

local Mouse = Object:extend()

    function Mouse:new()
        
        self.x = 0
        self.y = 0
        self.size = 10
        self.body = love.physics.newBody(world, x, y, 'static')       
        self.shape = love.physics.newRectangleShape(self.size, self.size)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:setUserData(self)

    end

    function Mouse:update(dt)
         
    end

    return Mouse