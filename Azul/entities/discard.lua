local Entity = require "entities/entity"

local Discard = Entity:extend()

    

    function Discard:new(nr, x_pos, y_pos, discard)
        Discard.super.new(self, id)
        self.nr = nr
        self.type = 'bucket'
        self.tileBucket = {}
        self.isNotFull = true
        self.radius = ((love.graphics.getWidth() - 20) / 9) * 0.5
        self.height = self.radius
        self.x = x_pos
        self.y = y_pos or self.height + 10
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newCircleShape(self.radius / 2)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:isSensor(true)
        self.fixture:setUserData(self)
        self.contact = false
        self.ox = self.body:getX() - (self.radius / 2)
        self.oy = self.body:getY() - (self.height / 2)
        self.texture = love.graphics.newImage('img/bucket.png')
        self.tType = 0
        self.discard = discard or false
        self.owned = 0
    end

    function Discard:update(dt)
        for _, tile in pairs(self.ownedEntities) do
            if tile.body:getX() ~= tile.targetX or tile.body:getY() ~= tile.targetY then
                        
                local dx = tile.targetX - tile.body:getX()
                local dy = tile.targetY - tile.body:getY()
                local newX = tile.body:getX() + dx * tile.speed * dt
                local newY = tile.body:getY() + dy * tile.speed * dt
                
                tile.body:setPosition(newX, newY)
                tile.x = newX
                tile.y = newY
            end
        end
        
        if self.ownedEntities then
            
                local tileIndex = 1
            for _, tile in pairs(self.ownedEntities) do
                -- if tile:is(Tile) then
                    local x, y = self:calculateTilePosition(tileIndex)
                    -- print('Updateing bodys owned entities position to x: ' .. x .. ' y: ' .. y)
                    tile:setTarget(x, y, tile.id)
                    tileIndex = tileIndex + 1
                -- end
            end
            
        end
        
        -- First determine if we're hovering over any tile
        local isHovering = false
        for _, tile in pairs(self.ownedEntities) do
            if tile.mouseOver then
                self.tType = tile:gettType()
                isHovering = true
                break  -- Stop checking once we found a hovered tile
            end
        end
        
        -- If no hover, reset tType
        if not isHovering then
            self.tType = 0
        end
        
        -- Process highlighting in a single pass
        for _, tile in pairs(self.ownedEntities) do
            tile.highlight = (tile.tType == self.tType)
        end

        
            if self.ownedEntities then
                local count = 0
                for _, tile in pairs(self.ownedEntities)do
                    
                        count = count + 1
                    
                end
                self.owned = count
            end
    end

    function Discard:draw()
        love.graphics.draw(
                self.texture, 
                self.x, 
                self.y, 
                0,      -- Rotation
                .5,     -- Scale factor x
                .5,     -- Scale factor y
                self.texture:getWidth()/2, 
                self.texture:getHeight()/2
            )        
        love.graphics.circle('line', self.x, self.y , self.radius)
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        love.graphics.print('Owns :' .. self.owned, self.x - (self.radius / 2 - 5), self.y - (self.height / 2 - 5))
    end

    function Discard:calculateTilePosition(tileIndex)
        
        local index = tileIndex -1
        local step = 50
        local gap = 10
        local x = self.body:getX() - ((step + gap)/2)
        local y = self.body:getY() - ((step + gap)/2)
        if tileIndex <= 8 then
            x = x + ((step + gap) * index)
        elseif tileIndex >=9 then
            index = index - 8
            x = self.body:getX() - ((step + gap)/2)
            x = x + ((step + gap) * index)        
            y = self.body:getY() + ((step + gap)/2)
        end
        return x, y
    end
    function Discard:setOwnedEntityPos()
        -- if self.id == id then
            print('Bucket nr: ' .. self.nr)
            local tileIndex = 1
            for _, tile in pairs(self.ownedEntities) do
                -- if tile:is(Tile) then
                    local x, y = self:calculateTilePosition(tileIndex)
                    print('Updateing bodys owned entities position to x: ' .. x .. ' y: ' .. y)
                    tile:setPos(x, y, tile.id)
                    tileIndex = tileIndex + 1
                -- end
            end
            
        -- end

    end

    return Discard