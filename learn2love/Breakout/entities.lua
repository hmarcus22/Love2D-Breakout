local boundry_bottom = require('entities/boundry-bottom')
local boundry_vertical = require('entities/boundry-vertical')
local boundry_top = require('entities/boundry-top')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local world = require('world')
local brick = require('entities/brick')
local pause = require('entities/pause')

return {
    boundry_bottom(400, 606),
    boundry_vertical(-6, 300),
    boundry_vertical(806, 300),
    boundry_top(400, -6),
    ball(200, 200),
    paddle(300, 500),
    brick(100, 100),
    brick(200, 100),
    brick(300, 100),
    pause()
    
}
