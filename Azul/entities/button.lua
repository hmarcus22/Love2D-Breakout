local Entity = require "entities/entity"
local world = require "draw_box.world"
local state = require "state"

local Button = Entity:extend()

    

    function Button:new(x, y, width, height, lable)
        Button.super.new(self, id)
        self.width = width
        self.widthScale = self.width
        self.height = height
        self.heightScale = self.height
        self.x = x
        self.y = y
        self.lable = lable or ''
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newRectangleShape(self.width, self.height)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.z = 2
        self.clicked = false
        self.color = state.palette[1]
        self.clickedColor = {.7, .7, .9}
        self.scale = 1
        self.scaleSpeed = 40
        self.scaleTarget = 1
        self.highlight = false
    end

    function Button:update(dt)
        local previousState = self.clicked
        if self.fixture:testPoint(love.mouse.getPosition()) then
            self.highlight = true
            if state.left_mouse_click then
                self.clicked = true
                if not previousState and self.clicked then
                    print(self.lable .. ' Clicked!')
                end
            else
            self.clicked = false
            end
        else
            self.highlight = false
        end

        if self.highlight then
            self.scaleTarget = 1.1
        else
            self.scaleTarget = 1
        end

        if self.scale ~= self.scaleTarget then
            local ds = self.scaleTarget - self.scale
            self.scale = self.scale + ds * self.scaleSpeed * dt
            self.widthScale = self.width * self.scale
            self.heightScale = self.height * self.scale
        end

    end

    function Button:draw()
        if self.clicked then
            love.graphics.setColor(self.clickedColor)
        else
            love.graphics.setColor(state.palette[1])
        end
        love.graphics.rectangle('fill', self.x - (self.widthScale/2), self.y - (self.heightScale/2), self.widthScale, self.heightScale, 5, 5)
        love.graphics.setColor(state.palette[5])
        love.graphics.rectangle('line', self.x - (self.widthScale/2), self.y - (self.heightScale/2), self.widthScale, self.heightScale, 5, 5)
        love.graphics.printf(self.lable, self.x , self.y - (self.heightScale/5), self.widthScale, 'center', 0, self.scale, self.scale, (self.widthScale/2), 0)
    end

    return Button