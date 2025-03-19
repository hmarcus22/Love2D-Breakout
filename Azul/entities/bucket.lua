local Entity = require "entities/entity"

local Bucket = Entity:extend()

    

    function Bucket:new(nr, x_pos)
        Bucket.super.new(self, id)
        self.nr = nr
        self.type = 'bucket'
        self.tileBucket = {}
        self.isNotFull = true
        self.width = (love.graphics.getWidth() - 40) / 4 
        self.height = self.width
        self.x = x_pos
        self.y = self.height / 2 + 10
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newRectangleShape(self.width, self.height)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:isSensor(true)
        self.fixture:setUserData(self)
        self.contact = false
        self.ox = self.body:getX() - (self.width / 2 - 5)
        self.oy = self.body:getY() - (self.height / 2 - 5)
        
    end

    function Bucket:draw()

        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        love.graphics.print('Bucket :' .. self.nr, self.x - (self.width / 2 - 5), self.y - (self.height / 2 - 5))
    end

    function Bucket:update(dt)
         -- Update positions of all owned tiles
        if self.ownedEntities then
            local x = self.body:getX()
            local y = self.body:getY()
            local tileCount = 1
            
            for _, tile in pairs(self.ownedEntities) do
                if tile:is(Tile) then
                    local tileX = x + ((tileCount - 1) * 15) % self.width
                    local tileY = y + math.floor((tileCount-1)/2) * 35
                    tile:setPos(tileX, tileY)
                    tileCount = tileCount + 1
                end
            end
        end

    end


    function Bucket:setOwnedEntityPos()
        if self.ownedEntities then
       
            local x, y = self.ox, self.oy
            print ('Coordinates: ' .. x, y)
            for _, entity in pairs(self.ownedEntities) do
                if entity:is(Tile) then
                    print('Tile is in play when updating coordinates: ' .. tostring(entity.InPlay))
                    entity:setPos(x, y)
                    x = x + 35
                    
                end
            end
        end

    end

    return Bucket