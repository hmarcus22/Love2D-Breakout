--Platform
local vector = require "vector"

local platform = {}
platform.position = vector(300, 500)
platform.speed = vector(800, 0)
platform.image = love.graphics.newImage("img/800x600/Platform_Lo.png")
platform.norm_tile_width = 70
platform.norm_tile_height = 20
platform.x_tile_pos = 0                                                        --(*2)
platform.y_tile_pos = 0
platform.tile_width = 70
platform.tile_height = 20
platform.tileset_width = 70
platform.tileset_height = 20
platform.quad = love.graphics.newQuad( platform.x_tile_pos, platform.y_tile_pos,
                                       platform.tile_width, platform.tile_height,
                                       platform.tileset_width, platform.tileset_height )
platform.width = platform.norm_tile_width
platform.height = platform.norm_tile_height

function platform.update(dt)
    if love.keyboard.isDown("right") then
        platform.position = platform.position + (platform.speed * dt)
    end
    if love.keyboard.isDown("left") then
        platform.position = platform.position - (platform.speed * dt)
    end
end

function platform.draw()
    love.graphics.draw( platform.image,
                        platform.quad,
                        platform.position.x,
                        platform.position.y)
    love.graphics.rectangle( 'line',
                            platform.position.x,
                            platform.position.y,
                            platform.width,
                            platform.height )
end

function platform.bounds(shift_platform)
    platform.position = platform.position + shift_platform
    
   
end

return platform