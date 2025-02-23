--Bricks
local bricks = {}
bricks.top_left_position_x = 100
bricks.top_left_position_y = 100
bricks.brick_width = 50
bricks.brick_height = 30
bricks.rows = 8
bricks.columns = 11
bricks.horizontal_distence = 10
bricks.vertical_distance = 15
bricks.current_level_bricks = {}


function bricks.new_brick(position_x, position_y, bricktype, width, height)
    return ({position_x = position_x,
            position_y = position_y,
            width = width or bricks.brick_width,
            height = height or bricks.brick_height,
            bricktype = bricktype})
end

function bricks.construct_level(level_bricks_arrangement)
    bricks.no_more_bricks = false
    for row_index, row in ipairs(level_bricks_arrangement) do
        for col_index, bricktype in ipairs(row) do
            if bricktype ~= 0 then
                local new_brick_position_x = bricks.top_left_position_x + 
                    (col_index -1) * 
                    (bricks.brick_width + bricks.horizontal_distence)
                local new_brick_position_y = bricks.top_left_position_y + 
                    (row_index -1) * 
                    (bricks.brick_height + bricks.vertical_distance)
                local new_brick = bricks.new_brick(new_brick_position_x, new_brick_position_y, bricktype)
                table.insert(bricks.current_level_bricks, new_brick)
            end
        end
    end
end

function bricks.draw_brick(single_brick)
    love.graphics.rectangle( 'line',
                            single_brick.position_x,
                            single_brick.position_y,
                            single_brick.width,
                            single_brick.height )
    local r, g, b, a = love.graphics.getColor()
    if single_brick.bricktype == 1 then
        love.graphics.setColor(255, 0, 0, 100)
    elseif single_brick.bricktype == 2 then
        love.graphics.setColor(0, 255, 0, 100)
    elseif single_brick.bricktype == 3 then
        love.graphics.setColor(0, 0, 255, 100)
    end
    love.graphics.rectangle( 'fill',
                            single_brick.position_x,
                            single_brick.position_y,
                            single_brick.width,
                            single_brick.height)
    love.graphics.setColor(r, g, b, a)
end

function bricks.draw()
    for _, brick in pairs(bricks.current_level_bricks) do
        bricks.draw_brick(brick)
    end
end

function bricks.update_brick(single_brick)
end

function bricks.add_to_current_level_bricks(brick)
    table.insert(bricks.current_level_bricks, brick)
end

function bricks.update(dt)
    if #bricks.current_level_bricks == 0 then
        bricks.no_more_bricks = true
    else
        for _, brick in pairs(bricks.current_level_bricks) do
            bricks.update_brick(brick)
        end
    end
end

function bricks.brick_hit_by_ball(i, brick, shift_ball_x, shift_ball_y)
    table.remove(bricks.current_level_bricks, i)
end

function bricks.clear_current_level_bricks()
    for i in pairs(bricks.current_level_bricks) do
        bricks.current_level_bricks[i] = nil
    end
end

return bricks