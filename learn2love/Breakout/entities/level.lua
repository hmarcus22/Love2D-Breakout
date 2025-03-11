--Put Level loader and builder here

local state = require('state')

return function(brick)

    local entity = {}

    entity.current_level = {}
    entity.levels = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

        
    }

    --Builds a generic level with bricks
        local row_width = love.window.getMode() -20
        
        for _, brick_type in ipars(entity.levels[state.current_level]) do
            local brick_x = ((number * 60) % row_width) + 40
            local brick_y = (math.floor((number * 60) / row_width) * 40) + 80
            if brick_type == 1 then
                entity.current_level[#entity.current_level +1] = brick(brick_x, brick_y)
            end
        end
    

    entity.draw = function(self)
        for _, brick in ipairs(entity.current_level) do
            love.graphics.setColor(state.palette[brick.health] or state.palette[5])
            love.graphics.polygon('fill', brick.body:getWorldPoints(brick.shape:getPoints()))
            love.graphics.setColor(state.palette[5])
        end
    end

    entity.update = function(dt)

        local have_bricks = false    

        local index = 1 -- Move bricks handling to level.update()
        while index <= #entity.current_level do
            
            local brick_entity = entity.current_level[index]
            
            if brick_entity.type == 'brick' then have_bricks = true end
            
            if brick_entity.health == 0 then
                table.remove(entity.current_level, index)
                brick_entity.fixture:destroy()
            else
                index = index + 1
            end
        end

        stage_cleared = not have_bricks
    end

    return entity
end