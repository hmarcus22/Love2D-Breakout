local Entity = require "entities/entity"
local world = require "world"
local state = require "state"

local Button = Entity:extend()

    

    function Button:new(x, y, width, height, lable)
        Button.super.new(self, id)
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        self.lable = lable or ''
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newRectangleShape(self.width, self.height)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.z = 2
        self.clicked = false
    end

    function Button:update(dt)
        local previousState = self.clicked
        if self.fixture:testPoint(love.mouse.getPosition()) and state.left_mouse_click then
            self.clicked = true
            if not previousState and self.clicked then
                print(self.lable .. ' Clicked!')
            end
        else
        self.clicked = false
        end
    end

    function Button:draw()
        love.graphics.setColor(state.palette[1])
        love.graphics.rectangle('fill', self.x - (self.width/2), self.y - (self.height/2), self.width, self.height, 5, 5)
        love.graphics.setColor(state.palette[5])
        love.graphics.rectangle('line', self.x - (self.width/2), self.y - (self.height/2), self.width, self.height, 5, 5)
        love.graphics.printf(self.lable, self.x - (self.width/2), self.y - (self.height/4), self.width, 'center')
    end

    return Button