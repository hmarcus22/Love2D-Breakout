local world = require('draw_box.world')
local state = require('state')

return function(x_pos, y_pos)

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(50, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)
    entity.health = 2
    entity.type = 'brick'

    -- entity.draw = function(self)
    --     love.graphics.setColor(state.palette[self.health] or state.palette[5])
    --     love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    --     love.graphics.setColor(state.palette[5])
    -- end
    
    entity.end_contact = function(self)
        self.health = self.health - 1
        if self.health == 2 then
        end

    end

    return entity
end
