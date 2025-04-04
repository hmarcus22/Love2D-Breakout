local bar = require('entities/bar')
local triangle = require('entities/triangle')
local world = require('draw_box.world')

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
    love.graphics.polygon(
                            'line',
                             triangle.body:getWorldPoints(triangle.shape:getPoints())
                         )
    love.graphics.polygon(
                            'line',
                             bar.body:getWorldPoints(bar.shape:getPoints())
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
