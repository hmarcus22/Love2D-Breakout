local Entity = require "entities/entity"

local Bucket = Entity:extend()

    

    function Bucket:new(nr, x_pos)
        Bucket.super.new(self, id)
        self.nr = nr
        self.type = 'bucket'
        self.tileBucket = {}
        self.isNotFull = true
        self.radius = ((love.graphics.getWidth() - 20) / 9) * 0.5
        self.height = self.radius
        self.x = x_pos
        self.y = self.height 
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newCircleShape(self.radius / 2)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:isSensor(true)
        self.fixture:setUserData(self)
        self.contact = false
        self.ox = self.body:getX() - (self.radius / 2)
        self.oy = self.body:getY() - (self.height / 2)
        
    end

    function Bucket:draw()

        love.graphics.circle('line', self.x, self.y , self.radius)
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        love.graphics.print('Bucket :' .. self.nr, self.x - (self.radius / 2 - 5), self.y - (self.height / 2 - 5))
    end

    function Bucket:calculateTilePosition(tileIndex)
        
        local index = tileIndex -1
        local step = 50
        local gap = 10
        local x = self.body:getX() - ((step + gap)/2)
        local y = self.body:getY() - ((step + gap)/2)
        if tileIndex <= 2 then
            x = x + ((step + gap) * index)
        elseif tileIndex >=3 then
            index = index - 2
            x = self.body:getX() - ((step + gap)/2)
            x = x + ((step + gap) * index)        
            y = self.body:getY() + ((step + gap)/2)
        end
        return x, y
    end
    
    function Bucket:update(dt)
        
        
    end


    function Bucket:setOwnedEntityPos(id)
        if self.id == id then
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
            
        end

    end

    return Bucket