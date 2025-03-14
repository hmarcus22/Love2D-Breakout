local entities = require('entities')
local input = require "input"
local Object = require "classic"
local state = require "state"


function love.load()
    math.randomseed(state.seed)
    entities:fillBuckets()
  
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