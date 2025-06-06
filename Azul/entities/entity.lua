local Object = require "classic"
local state = require "state"

local Entity = Object:extend()

function Entity:new()
        self.seed = math.random(10000, 99999)
        self.id = self:generateUUID()
        self.owner = nil
        self.ownedEntities = {}
        self.components = {}
        self.z = 0
        self.maxZ = 5
end

function Entity:setOwner(owner)
    

    -- Remove ownership from previous owner if exists
    if self.owner then
        self.owner:releaseEntity(self.id)
    end
    
    self.owner = owner

    if owner and owner ~= self then
        owner:addOwnedEntity(self)
    end
    
    return self
end

function Entity:getOwnerId()
    return self.owner.id
    
end

function Entity:addOwnedEntity(entity)
    -- Only add entity if it's not already owned by someone else
    if entity.owner == nil or entity.owner == self then
        self.ownedEntities[entity.id] = entity
    end
end

function Entity:releaseEntity(id)
        if self.ownedEntities[id] then
            self.ownedEntities[id].owner = nil
            self.ownedEntities[id] = nil
        end
end

function Entity:getCount()
    local count = 0
    for _ in pairs(self.ownedEntities) do
        count = count + 1
    end
    return count
end

function Entity:printOwnedEntities()
    print('Entity: ' .. self.id .. ' owns:')
    for key, entity in pairs(self.ownedEntities) do
        print('Entity: ' .. self.id .. ' owns:')
        print('Key: '.. key .. ' ' .. tostring((entity)))
    end
end

function Entity:printOwner()
    print('Owner is: ' .. tostring(self.owner))
    
end

function Entity:destroy()
    -- Release all owned entities
    for id, _ in pairs(self.ownedEntities) do
        self:releaseEntity(id)
    end
    
    -- Release ourselves from our owner
    if self.owner then
        self.owner:releaseEntity(self.id)
    end
end

function Entity:draw()
    -- Default draw behavior - override in specific entity types
end

function Entity:drawAll()
    --Decide draw order experiment
    for number = 0, self.maxZ do
        -- Draw this entity first
        if self.z == number then
            self:draw()
        end
        
        if self.z == number then
            
            -- Then draw all owned entities
            if self.ownedEntities then
                for _, ownedEntity in pairs(self.ownedEntities) do
                    ownedEntity:drawAll()
                end
            end
        end
    end
end

function Entity:update(dt)
    -- Default update behavior - override in specific entity types
end

function Entity:updateAll(dt)
    -- Draw this entity first
    self:update(dt)
    
    -- Then update all owned entities
    if self.ownedEntities then
        for _, ownedEntity in pairs(self.ownedEntities) do
            ownedEntity:updateAll(dt)
        end
    end
end

function Entity:generateUUID()
    math.randomseed(self.seed)
local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return (string.gsub(template, '[xy]', function(c)
        local v = c == 'x' and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end))
end

return Entity