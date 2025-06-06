local world = require('draw_box.world')
local state = require('state')

return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(800, 10)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)
    entity.type = 'bottom'

    entity.end_contact = function(selfe)
        if state.lives < 1 then
            state.game_over = true
        else 
            state.lives = state.lives - 1
            state.serve = true
        end
    end

    return entity
end