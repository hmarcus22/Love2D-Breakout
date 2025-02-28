local state = require('state')

local input = {}

local press_functions = {}
local release_functions = {}

input.press = function(pressed_key)
    if press_functions[pressed_key] then
        press_functions[pressed_key]()
    end
end

input.release = function(released_key)
    if release_functions[released_key] then
        release_functions[released_key]()
    end
end

input.toggle_focus = function(focused)
    if not focused then
        state.paused = true
    end
end

press_functions.left = function()
    state.button_left = true
end
press_functions.right = function()
    state.button_right = true
end
press_functions.escape = function()
    love.event.quit()
end
press_functions.space = function()
    state.paused = not state.paused
end

release_functions.left = function()
    state.button_left = false
end
release_functions.right = function()
    state.button_right = false
end

return input