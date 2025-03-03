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

input.mouse_release = function(button)
    local old_mouse_click = state.mouse_click
    if button == 1 and old_mouse_click then
        state.mouse_click = false
    end
    
    print(state.mouse_click)
    print(state.serve)
end

input.mouse_press = function(button)
    if button == 1 then
        state.mouse_click = true
    end
    print(state.mouse_click)
    print(state.serve)
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