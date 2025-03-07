local entities = require('entities')
local world = require('world')
local input = require('input')
local state = require('state')

love.load = function()
    love.mouse.setGrabbed(state.mouse_grab)
end

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.focus = function(focused)
    input.toggle_focus(focused)
end

love.keypressed = function(pressed_key)
    input.press(pressed_key)
end

love.keyreleased = function(released_key)
    input.release(released_key)
end

love.mousereleased = function(mX, mY, pButton)
    input.mouse_release(pButton)
end

love.mousepressed = function(mX, mY, rButton)
    input.mouse_press(rButton)
end

love.update = function(dt)
   
    if state.mouse_grab then
        love.mouse.setVisible(false)
    end
    for _, entity in ipairs(entities) do
        if entity.update then entity:update(dt) end
    end

    world:update(dt)
   
end