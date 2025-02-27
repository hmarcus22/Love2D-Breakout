local world = require('world')

local entity = {}
entity.body = love.physics.newBody(world, 400, -6, 'static')
entity.shape = love.physics.newRectangleShape(800, 10)
entity.fixture = love.physics.newFixture(entity.body, entity.shape)
entity.fixture:setUserData(entity)

return entity