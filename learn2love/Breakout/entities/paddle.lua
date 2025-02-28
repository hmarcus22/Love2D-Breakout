local world = require('world')
local input = require('input')



return function(x_pos, y_pos)
    local window_width = love.window.getMode()
    local entity_width = 120
    local entity_height = 20
    local entity_speed = 600
    local left_boundry = (entity_width /2) + 2
    local right_boundry = window_width - (entity_width / 2) - 2

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
    entity.shape = love.physics.newRectangleShape(entity_width, entity_height)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.draw = function(self)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.update = function(self, dt)
        if input.left and input.right then
            return
        end
        local self_x = self.body:getX()
        if input.left and self_x > left_boundry then
            self.body:setLinearVelocity(-entity_speed, 0)
        elseif input.right and self_x < right_boundry then
            self.body:setLinearVelocity(entity_speed, 0)
        else
            self.body:setLinearVelocity(0, 0)
        end
    end

    return entity
end