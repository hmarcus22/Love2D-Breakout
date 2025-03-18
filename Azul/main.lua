local game = require('game')
local input = require "input"
local Object = require "classic"
local state = require "state"
local world = require "world"



function love.load()
    math.randomseed(state.seed)
    -- entities:fillBuckets()
    
end

function love.keyreleased(key, code)
    input:release(key, code)
    print(key)
end

function love.mousereleased(mX, mY, pButton)
    input:mouseRelease(pButton)
end

function love.mousepressed(mX, mY, rButton)
    input:mousePress(rButton)
end


function love.update(dt)
    
    game:updateAll(dt)
    world:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(.5, .5, .5, 1)
    game:drawAll()
end