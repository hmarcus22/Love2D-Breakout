local world = require('world')
local state = require('state')



return function(x_pos, y_pos)
    local window_width = love.window.getMode()
    local entity_width = 120
    local entity_height = 20
    local entity_speed = 7
    local left_boundry = (entity_width /2) + 5
    local right_boundry = window_width - (entity_width / 2) - 5
    local polygonshape = {-60, 10, 60, 10, 60, -3, 55, -7, 20, -10, -20, -10, -55, -7, -60, -3}

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
    entity.shape = love.physics.newPolygonShape(unpack(polygonshape))
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)
    entity.fixture:setFriction(0.5)

    entity.draw = function(self)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.follow_mouse = function(self, dt)
        local mouse_x, y = love.mouse.getPosition()
        local self_x = self.body:getX()
        local velocity = math.abs(self_x - mouse_x)
        if velocity < 10 then
            velocity = velocity * 0.65
        end
        
        if state.serve then
            state.paddle_pos = {x = self_x, y = y_pos}
        end

        if mouse_x >= self_x -3 and mouse_x <= self_x +3 then
            return
        end 

        if mouse_x < self_x and self_x > left_boundry then
            self.body:setX(self_x - (entity_speed * velocity * dt))
        elseif mouse_x > self_x and self_x < right_boundry then
            self.body:setX(self_x + (entity_speed * velocity * dt))
        end
    end

    entity.update = function(self, dt)

              
        self.follow_mouse(self, dt)
   
    end

    return entity
end