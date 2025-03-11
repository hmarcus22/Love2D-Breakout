local entities = require('entities')
local input = require "input"

-- Debug_print

for _, entity in ipairs(entities) do

   
        if entity.type == 'bucket' then
            print(entity.id, entity.tileBucket)
            for _, v in pairs(entity.tileBucket) do
                print( v)
            end
        end

    
   
    
end

function love.load()

    entities:moveTileToBucket()
   
end

function love.keyreleased(key, code)
    input:release(key, code)
    print(key)
end


function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(.5, .5, .5, 1)
    for _, entity in ipairs(entities) do
       if entity.draw then entity:draw() end
    
    end
    
end