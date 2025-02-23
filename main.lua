gamestates = require "gamestates"

function love.load()
    local love_window_with = 800
    local love_window_height = 600
    love.window.setMode(love_window_with,
                        love_window_height,
                        {fullscreen = false})
    
    gamestates.set_state("menu")
end

function love.update(dt)
    gamestates.state_event("update", dt)
end

function love.draw()
    print(current_state)
    gamestates.state_event("draw")
    
end

function love.keyreleased(key, code)
    gamestates.state_event("keyreleased", key, code)
end