local entities = require('entities')
local world = require('world')
local input = require('input')

love.focus = function(f)
    if not f then
        paused = true
    elseif f then
        paused = false
    end
end

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then 
            entity:draw() 
        end
    end

                         if paused then
        love.graphics.print("game is paused", 10, 10)
    end
end

love.keypressed = function(key_pressed)
    input.press(pressed_key)
end

love.keyreleased = function(released_key)
    input.release(released_key)
end

love.update = function(dt)
    if not input.paused then
        for _, entity in ipairs(entities) do
            if entity.update then entity:update(dt) end
        end
        world:update(dt)
    end
end
  