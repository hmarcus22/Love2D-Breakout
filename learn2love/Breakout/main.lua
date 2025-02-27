local boundry_bottom = require('entities/boundry-bottom')
local boundry_left = require('entities/boundry-left')
local boundry_right = require('entities/boundry-right')
local boundry_left = require('entities/boundry-left')
local boundry_top = require('entities/boundry-top')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local world = require('world')

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
    -- love.graphics.polygon('line', boundry_bottom.body:getWorldPoints(boundry_bottom.shape:getPoints()))
    -- love.graphics.polygon('line', boundry_left.body:getWorldPoints(boundry_left.shape:getPoints()))
    -- love.graphics.polygon('line', boundry_right.body:getWorldPoints(boundry_right.shape:getPoints()))
    -- love.graphics.polygon('line', boundry_top.body:getWorldPoints(boundry_top.shape:getPoints()))
    local ball_x, ball_y = ball.body:getWorldCenter()
    love.graphics.circle('fill', ball_x, ball_y, ball.shape:getRadius())
    love.graphics.polygon(
                            'line',
                             paddle.body:getWorldPoints(paddle.shape:getPoints())
                         )
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
