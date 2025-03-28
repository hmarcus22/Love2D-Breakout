local Entity = require "entities/entity"

local DrawOrder = Entity:extend()  

    function DrawOrder:new(type, x, y)
        DrawOrder.super.new(self)
        self.drawTable = {}
        self.updated = false
        self.nrEntities = 0
    end

    function DrawOrder:add(entity)
        
        table.insert(self.drawTable, entity)
        self.nrEntities = self.nrEntities + 1
        self.updated = true
        print('Entities added: ' .. self.nrEntities)
        
    end

    function DrawOrder:update(dt)
            
           table.sort(self.drawTable, function(a, b) return a.z > b.z end)
            
            print('DrawOrderTable updated!')
            
               
    end

    function DrawOrder:drawOrderly()
        for _, entity in pairs(self.drawTable) do
            if entity.owner then
                entity:draw()
            end
        end
    end

    function DrawOrder:isEmpty()
        return self.nrEntities ==  0
    end

    return DrawOrder