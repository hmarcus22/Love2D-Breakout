local boundry_bottom = require('entities/boundry-bottom')
local boundry_left = require('entities/boundry-left')
local boundry_right = require('entities/boundry-right')
local boundry_left = require('entities/boundry-left')
local boundry_top = require('entities/boundry-top')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local world = require('world')
local brick = require('entities/brick')

local entities = {
    brick(100, 100),
    brick(200, 100),
    brick(300, 100)
}

local paused = false

local key_map = {
    escape = function()
        love.event.quit()
    end,
    space = function()
        paused = not paused
    end
}

love.focus = function(f)
    if not f then
        paused = true
    elseif f then
        paused = false
    end
end

love.draw = function()
    local ball_x, ball_y = ball.body:getWorldCenter()
    love.graphics.circle('fill', ball_x, ball_y, ball.shape:getRadius())
    love.graphics.polygon(
                            'line',
                             paddle.body:getWorldPoints(paddle.shape:getPoints())
                         )
    
    for _, entity in ipairs(entities) do
        love.graphics.polygon('fill', entity.body:getWorldPoints(entity.shape:getPoints()))
    end

                         if paused then
        love.graphics.print("game is paused", 10, 10)
    end
end

love.keypressed = function(key_pressed)
    if key_map[key_pressed] then
        key_map[key_pressed]()
    end
end

love.update = function(dt)
    if not paused then
        world:update(dt)
    end
end
