local Object = require "classic"
local state = require "state"

local Entity = Object:extend()

function Entity:new()
        self.seed = math.random(10000, 99999)
        self.id = self:generateUUID()
        self.owner = nil
        self.ownedEntities = {}
        self.components = {}
end

function Entity:setOwner(owner)
    
    -- for _, component in pairs(self.components) do
    --     if component.onOwnershipChange then
    --         component:onOwnershipChange(owner)
    --     end
    -- end
    -- Remove ownership from previous owner if exists
    print(tostring('New owner ID: ' .. owner.id))
    print(tostring('Old owner ID: ' .. self.id))
    if self.owner then
        self.owner:releaseEntity(self.id)
    end
    
    self.owner = owner
    if owner then
        owner:addOwnedEntity(self)
    end
    
    return self
end

function Entity:addOwnedEntity(entity)
    entity:setOwner(self)
    self.ownedEntities[entity.id] = entity
end

function Entity:releaseEntity(id)
        if self.ownedEntities[id] then
            self.ownedEntities[id].owner = nil
            self.ownedEntities[id] = nil
        end
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
    -- error("Entity must implement draw method")
    -- print(tostring(self) .. ' Entity has no draw method')
end

function Entity:drawAll()
    -- Draw this entity first
    self:draw()
    
    -- Then draw all owned entities
    if self.ownedEntities then
        for _, ownedEntity in pairs(self.ownedEntities) do
            ownedEntity:drawAll()
        end
    end
end

-- function Entity:generateUUID()
--     local template = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
--     return template:gsub("%x", function(c)
--         local v = math.random(0, 15)
--         return string.format("%x", v)
--     end)
-- end



function Entity:generateUUID()
    math.randomseed(self.seed)
local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return (string.gsub(template, '[xy]', function(c)
        local v = c == 'x' and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end))
end

return Entity

-- Example usage in love.draw():
-- function love.draw()
--     -- Assuming rootEntity contains all top-level entities
--     rootEntity:drawAll()
-- end



-- Example usage
-- local player = Entity.new("player")
-- local weapon = Entity.new("sword")

-- -- Player owns weapon
-- player:addOwnedEntity(weapon)

-- -- Transfer ownership to another entity
-- local inventory = Entity.new("inventory")
-- weapon:setOwner(inventory) 