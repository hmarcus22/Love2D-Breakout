local Object = require "classic"
local state = require "state"
local world = require "world"

local Tile = Object:extend()  

    function Tile:new(type, x, y)
        
        self.tType = (type or 5)
        self.size = 30
        self.x = x
        self.y = (y or 20)
        self.body = love.physics.newBody(world, x, y, 'static')       
        self.shape = love.physics.newRectangleShape(self.size, self.size)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:setUserData(self)
        self.hasDraw = true
        self.bucket = 0
        self.inPlay = false
        self.contact = false
        self.drag = false
        self.texture = love.graphics.newImage('img/0' .. self.tType .. '.png')

    end

    function Tile:pType()
        print(self.tType)
    end

    function Tile:render()
        
        local self_x, self_y = self.body:getWorldCenter()
        love.graphics.setColor(state.palette[self.tType])
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.draw(
            self.texture, 
            self_x, 
            self_y, 
            0, -- Rotation
            .2, -- Scale factor x
            .2, -- Scale factor y
            self.texture:getWidth()/2, 
            self.texture:getHeight()/2
        )
        
        -- Use a different color for the text based on the tile type
        if self.tType == 5 or self.tType == 2 then
            love.graphics.setColor(state.palette[4])  -- Black
        else
            love.graphics.setColor(state.palette[5])  -- White
        end
        
        --Debug stuff
        love.graphics.print(self.tType, self.x -5, self.y)
        love.graphics.print(tostring(self.contact), self.x +5, self.y)
    end
  
    function Tile:update(dt)
        if state.left_mouse_click then
            if self.fixture:testPoint(love.mouse.getPosition()) then
                self.drag = true
                -- self.body:setMass(0,0,0,0)
                self.contact = true
            end
        end
        if not state.left_mouse_click then
            self.drag = false
            -- self.body:setLinearVelocity(0,0)
            self.contact = false
        end
        if self.drag then
            
            local x, y = love.mouse:getPosition()
            self.body:setPosition(x, y)
            self.x = x
            self.y = y
            
        end

    end

    function Tile:setBucket(nr, x, y)
        self.bucket = (nr)
        if self.bucket > 0 then self.inPlay = not self.inPlay end
        
        local newX = x 
        local newY = y 

        self.body:setPosition(newX, newY)
        self.x = newX
        self.y = newY
    end

    -- function Tile:post_contact()

    --     self.contact = true
    -- end

    -- function Tile:end_contact()

    --     self.contact = false
    -- end

    
return Tile