local ball = require "ball"
local platform = require "platform"
local bricks = require "bricks"
local levels = require "levels"
local walls = require "walls"
local collisions = require "collisions"


local game = {}

function game.switch_to_next_level(bricks, ball, levels)
    if bricks.no_more_bricks then
        if levels.current_level < #levels.sequence then
            gamestates.set_state( "game", { current_level = levels.current_level + 1 } )
        else
            gamestates.set_state( "gamefinished" )
        end
    end
end

function game.load(prev_state, ...)
    walls.construct_walls()

function game.update(dt)
    ball.update( dt )
    platform.update( dt )
    bricks.update( dt )
    walls.update( dt )
    collisions.resolve_collisions( ball, platform, walls, bricks )
    game.switch_to_next_level( bricks, ball, levels )
end

function game.draw()
    ball.draw()
    platform.draw()
    bricks.draw()
    walls.draw()
 end
    
end

function game.keyreleased( key, code )
    if key == 'c' then
        bricks.clear_current_level_bricks()
    elseif  key == 'escape' then
       gamestates.set_state( "gamepaused", { ball, platform, bricks, walls } )
    end    
end

function game.enter(prev_state, ...)
    args = ...
    if args and args.current_level then
        levels.current_level = args.current_level
        local level = levels.require_current_level()
        bricks.construct_level(level)
        ball.reposition()
    end
end

return game