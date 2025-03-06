local world = require('world')
local state = require('state')

return function(x_pos, y_pos)
    
    local entity_max_speed = 800

    local entity = {}

    entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
    entity.body:setLinearVelocity(300, 300)
    entity.shape = love.physics.newCircleShape(0, 0, 10)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape, 0.5)
    entity.fixture:setRestitution(1)
    entity.fixture:setUserData(entity)
    entity.fixture:setFriction(1)
    entity.texture = love.graphics.newImage('img/ball_lo.png')
    entity.body:setFixedRotation(false)
    entity.body:setMass(20)
    
    entity.end_contact = function(self)
        -- speed upp om collison
        local force = 60
        local x, y = self.body:getLinearVelocity()
        print (x, y)
        if y < 0 then force = - force end
        
        self.body:applyLinearImpulse(0, force)
    end
    
    entity.draw = function(self)
        local self_x, self_y = self.body:getWorldCenter()
        local rotation = self.body:getAngle()
        love.graphics.draw(self.texture, self_x, self_y, rotation, 1, 1, self.texture:getWidth()/2, self.texture:getHeight()/2)
        -- love.graphics.circle('fill', self_x, self_y, self.shape:getRadius())
    end

    entity.serve = function(self)

        local x = state.paddle_pos.x
            local y = state.paddle_pos.y - 15
            self.body:setLinearVelocity(0, 0)
            self.body:setPosition(x, y)
            self.body:setAngularVelocity(0)

            if state.mouse_click then
                self.body:setLinearVelocity(x - 300, 300)
                state.serve = false
            end
    end

    entity.update = function(self)
        
        local vel_x, vel_y = self.body:getLinearVelocity()
        local speed = math.abs(vel_x) + math.abs(vel_y)

        if state.serve then
            self.serve(self)
        else
            local vel_x_is_critical = math.abs(vel_x) > entity_max_speed * 2
            local vel_y_is_critical = math.abs(vel_y) > entity_max_speed * 2
            if vel_x_is_critical or vel_y_is_critical then
                self.body:setLinearVelocity(vel_x * .75, vel_y * .75)
            end
            if speed > entity_max_speed then
                self.body:setLinearDamping(0.1)
            else
                self.body:setLinearDamping(0)
            end
        end
    end

    return entity
end
