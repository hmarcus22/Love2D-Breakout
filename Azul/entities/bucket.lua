local Entity = require "entities/entity"

local Bucket = Entity:extend()

    

    function Bucket:new(nr, x_pos)
        Bucket.super.new(self, id)
        self.nr = nr
        self.type = 'bucket'
        self.tileBucket = {}
        self.isNotFull = true
        self.width = (love.graphics.getWidth() - 20) / 4 
        self.height = self.width
        self.x = x_pos
        self.y = self.height / 2
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newRectangleShape(self.width, self.height)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:isSensor(true)
        self.fixture:setUserData(self)
        self.contact = false
        
    end

    function Bucket:addTile(ctile)
        print("Starting addTile:", type(ctile))
        if not ctile then
            print("ERROR: ctile became nil inside addTile!")
            return
        end
        print("Before insertion:", type(ctile))
        table.insert(self.tileBucket, ctile)
        print("After insertion:", type(ctile))
        -- if #self.tileBucket == 5 then
            self.isNotFull = false
        -- end
    end
   
   
    -- function Bucket:addTile(ctile)

        
    --     print(type(ctile))
        
    --     table.insert(self.tileBucket, ctile)
        
    --     if #self.tileBucket == 5 then
    --         self.isNotFull = false
    --     end
    
        
    -- end

    function Bucket:isNotFull()
        
        return self.isNotFull
    end

    function Bucket:draw()

        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        
        for _, tile in ipairs(self.tileBucket) do
            if tile.draw then tile:draw() end
        end
    end

    function Bucket:begin_contact()
        print('contact!')
        self.contact = true
    end

    function Bucket:end_contact()
        
        self.contact = false
    end

    return Bucket