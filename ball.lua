--Ball
local vector = require "vector"

local ball = {}
ball.position = vector(200, 500)
ball.speed = vector(200, 200)
ball.radius = 10
ball.image = love.graphics.newImage("img/800x600/Ball_Lo.png")
ball.x_tile_pos = 0
ball.y_tile_pos = 0
ball.tile_width = 18
ball.tile_height = 18
ball.tileset_width = 18
ball.tileset_height = 18
ball.quad = love.graphics.newQuad( ball.x_tile_pos, ball.y_tile_pos,
                                    ball.tile_width, ball.tile_height,
                                    ball.tileset_width, ball.tileset_height )
ball.radius = ball.tile_width / 2

function ball.update(dt)
    ball.position = ball.position + ball.speed * dt
end

function ball.draw()
    love.graphics.draw( ball.image,
                        ball.quad,
                        ball.position.x - ball.radius,
                        ball.position.y - ball.radius)

    -- local segments_in_circle = 16
    -- love.graphics.circle( 'line',
    --                     ball.position.x,
    --                     ball.position.y,
    --                     ball.radius,
    --                     segments_in_circle )
end

function ball.rebound(shift_ball)
    -- local shift_ball = vector(shift_b)
    local min_shift = math.min( math.abs(shift_ball.x),
                                math.abs(shift_ball.y))
    if math.abs(shift_ball.x) == min_shift then
        shift_ball.y = 0
    else
        shift_ball.x = 0
    end
    ball.position = ball.position + shift_ball
    if shift_ball.x ~= 0 then
        ball.speed.x = -ball.speed.x
    end
    if shift_ball.y ~= 0 then
        ball.speed.y = -ball.speed.y
    end
end

function ball.reposition()
    ball.position.x = 200
    ball.position.y = 500
end

return ball