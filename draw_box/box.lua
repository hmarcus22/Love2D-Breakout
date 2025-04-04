local Objcet = require "Classic"
local world = require "world"

local Box = Objcet:extend()

function Box:new(x, y, width, height)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0
    self.body = love.physics.newBody(world, x, y, 'kinematic')
    self.shape = love.physics.newRectangleShape(width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.palette = {
        {0, 0, 0, 1},   --Black, Outline
        {0, 0, 0, .3},  --Shade, shading
        {.2, 1, .2, 1} --Green, bodycolor        
    }
    self.lineWidth = 5
    
end

function Box:draw()
    local x1, y1, x2, y2, x3, y3, x4, y4 = self.body:getWorldPoints(self.shape:getPoints())
    local o = self.lineWidth
    -- love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth( o )
    --Draw outline
    -- love.graphics.setColor = self.palette[1]
    -- love.graphics.polygon('line', x1, y1, x2, y2, x3, y3, x4, y4)
    --Draw body
    love.graphics.setColor = self.palette[3]
    love.graphics.polygon('line', x1, y1, x2, y2, x3, y3, x4, y4)
    --Draw shade
    -- love.graphics.setColor = self.palette[2]
    -- love.graphics.polygon('line', x1 + o, y1 + o, x2 - o, y2 + o, x3 - o, y3 -o, x4 + o, y4 - o)


end

return Box