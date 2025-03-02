local world = require('world')
local state = require('state')



return function(x_pos, y_pos)
    local window_width = love.window.getMode()
    local entity_width = 120
    local entity_height = 20
    local entity_speed = 800
    local left_boundry = (entity_width /2) + 5
    local right_boundry = window_width - (entity_width / 2) - 5

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
    entity.shape = love.physics.newRectangleShape(entity_width, entity_height)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.draw = function(self)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.update = function(self, dt)

        local self_x = self.body:getX()
        local mouse_x = love.mouse.getX()
        if state.serve then
            state.paddle_pos = {x = self_x, y = y_pos}
        end

        if mouse_x >= self_x -2 and mouse_x <= self_x +2 then
            return
        end 

        if mouse_x < self_x and mouse_x > left_boundry then
            self.body:setX(self_x - (entity_speed * dt))
        elseif mouse_x > self_x and self_x < right_boundry then
            self.body:setX(self_x + (entity_speed * dt))
        end
   
    end

    return entity
end