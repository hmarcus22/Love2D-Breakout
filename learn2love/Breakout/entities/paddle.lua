local world = require('world')
local input = require('input')



return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(180, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.draw = function(self)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.update = function(self, dt)
        if input.left and input.right then
            -- print(input.left, input.right)
            return
        end
        local self_x, self_y = self.body:getPosition()
        if input.left then
            self.body:setPosition(self_x - 10, self_y)
            -- print(input.left)
        elseif input.right then
            self.body:setPosition(self_x + 10, self_y)
            -- print(input.right)
        end
    end

    return entity
end