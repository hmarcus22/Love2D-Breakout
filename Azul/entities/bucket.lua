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
        self.pos = nil
        
    end

    function Bucket:draw()

        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        love.graphics.print('Bucket :' .. self.nr, self.x - (self.width / 2 - 5), self.y - (self.height / 2 - 5))
    end

    function Bucket:calculateTilePosition(tileIndex)
        -- Calculate perimeter positions clockwise starting from top-left
        local centerX = self.body:getX()
        local centerY = self.body:getY()
        local halfWidth = self.width / 2
        local halfHeight = self.height / 2
        local space = 10
        local tileWidth = 60
        local step = (tileIndex * tileWidth) - 40
        print(centerX, centerY)
        -- Get upper left corner of bucket
        local oX = centerX - halfWidth
        local newY = 60

        local x = oX + step + space 
        local y =  newY + space

        
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