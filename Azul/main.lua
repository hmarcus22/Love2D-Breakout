local entities = require('entities')
local input = require "input"
local Object = require "classic"





function love.load()
  
end

function love.keyreleased(key, code)
    input:release(key, code)
    print(key)
end


function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(.5, .5, .5, 1)
    entities:draw()
    
end