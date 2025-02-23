--Platform
local vector = require "vector"

local platform = {}
platform.position = vector( 300, 500 )
platform.speed = vector( 800, 0 )
platform.image = love.graphics.newImage( "img/800x600/Platform_Lo.png" )
-- platform.small_tile_width = 75
-- platform.small_tile_height = 16
-- platform.small_tile_x_pos = 0
-- platform.small_tile_y_pos = 0
platform.norm_tile_width = 70
platform.norm_tile_height = 20
platform.norm_tile_x_pos = 0
platform.norm_tile_y_pos = 0
-- platform.large_tile_width = 141
-- platform.large_tile_height = 16
-- platform.large_tile_x_pos = 0
-- platform.large_tile_y_pos = 64
platform.glued_x_pos_shift = 192
platform.tileset_width = 70
platform.tileset_height = 20
platform.quad = love.graphics.newQuad( platform.norm_tile_x_pos,
				       platform.norm_tile_y_pos,
				       platform.norm_tile_width,
				       platform.norm_tile_height,
				       platform.tileset_width,
				       platform.tileset_height )
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
    -- love.graphics.rectangle( 'line',
    --                         platform.position.x,
    --                         platform.position.y,
    --                         platform.width,
    --                         platform.height )
end

function platform.bounds(shift_platform)
    platform.position.x = platform.position.x + shift_platform.x 
end

return platform