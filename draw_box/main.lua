local Box = require "box"

local box1 = Box(200, 200, 100, 200)

function love.draw()
    love.graphics.setBackgroundColor(.4, .4, .4, 1)
    box1:draw()
end

