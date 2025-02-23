local ball = require "ball"
local platform = require "platform"
local bricks = require "bricks"
local levels = require "levels"
local walls = require "walls"
local collisions = require "collisions"
local gamestates = require "gamestates"
local gamestate = "menu"

--Main

function love.keyreleased(key, code)
    if gamestate == "menu" then
        if key == 'return' then
            gamestate = "game"
        elseif key ==  'escape' then
            love.event.quit()
        end
    elseif gamestate == "game" then
        if key == 'escape' then
            gamestate = "gamepaused"
        end
    elseif gamestate == "gamepaused" then
        if key == 'escape' then
            love.event.quit()
        elseif key == 'return' then
            gamestate = "game"
        end
    elseif gamestate == "gamefinished" then
        if key == 'return' then
            levels.current_level = 1
            levles =levels.require_current_level()
            bricks.construct_level(level)
            ball.reposition()
            gamestate = "game"
        elseif key == 'escape' then
            love.event.quit()
        end
    end

    if key == 'c' then
        bricks.clear_current_level_bricks()
    end
end

function love.load()
    level = levels.require_current_level()
    bricks.construct_level(level)
    walls.construct_walls()
    
end

function love.update(dt)
    if gamestate == "menu" then
    
    elseif gamestate == "game" then
        ball.update(dt)
        platform.update(dt)
        bricks.update(dt)
        walls.update(dt)
        collisions.resolve_collisions(ball, platform, walls, bricks)
        switch_to_next_level(bricks, ball, levels)

    elseif gamestate == "gamepaused" then

    elseif gamestate == "gamefinished" then

    end
end

function love.draw()
    love.graphics.print(gamestate, 10, 10)
    if gamestate == "menu" then
        love.graphics.print("menu gamestate. Press Enter to continue",
                            280, 250)
    elseif gamestate == "game" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
       
    elseif gamestate == "gamepaused" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
        love.graphics.print("Game is paused. Press Enter to continue or ESC to quit",
                            250, 100)
    elseif gamestate == "gamefinished" then
        love.graphics.print("Congratulations! You Won! Press enter to restart or Esc to exit.",
                                200, 100)
    end
    
end

function switch_to_next_level(bricks, ball, levels)
    if bricks.no_more_bricks then
        if levels.current_level < #levels.sequence then
            levels.current_level = levels.current_level +1
            level = levels.require_current_level()
            bricks.construct_level(level)
            ball.reposition()
        elseif levels.current_level >= #levels.sequence then
            gamestate = "gamefinished"
            -- levels.gamefinished = true
        end
    end
end

