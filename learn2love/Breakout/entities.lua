local boundry_bottom = require('entities/boundry-bottom')
local boundry_vertical = require('entities/boundry-vertical')
local boundry_top = require('entities/boundry-top')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local world = require('draw_box.world')
local brick = require('entities/brick')
local pause = require('entities/pause')
local game_over = require('entities/game_over')
local stage_clear = require('entities/stage_clear')
local game = require('entities/game')
local level = require('entities/level')

local entities = {
    boundry_bottom(400, 606),
    boundry_vertical(-6, 300),
    boundry_vertical(806, 300),
    boundry_top(400, -6),
    ball(200, 200),
    paddle(300, 500),
    pause(),
    stage_clear(),
    game_over(),
    game(),
    level(brick)
}

-- local row_width = love.window.getMode() -20
-- for number = 0, 38 do
--     local brick_x = ((number * 60) % row_width) + 40
--     local brick_y = (math.floor((number * 60) / row_width) * 40) + 80
--     entities[#entities +1] = brick(brick_x, brick_y)
-- end

return entities