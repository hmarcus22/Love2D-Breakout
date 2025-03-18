-- local Object = require "classic"
local state = require "state"
local world = require "world"
local Entity = require "entities/entity"

local Tile = Entity:extend()  

    function Tile:new(type, x, y)
        Tile.super.new(self, id)
        self.tType = (type or 5)
        self.size = 30
        self.x = x
        self.y = (y or 20)
        self.body = love.physics.newBody(world, self.x, self.y, 'dynamic')
        self.body:setLinearVelocity(0,0)
        self.body:setFixedRotation(true)
        self.body:setMassData(0,0,0,0)       
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

    function Tile:draw()
        if self.inPlay then
            -- print('Drawn tile with ID: ' .. self.id)
            local self_x, self_y = self.body:getWorldCenter()
            love.graphics.setColor(state.palette[self.tType])
            love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.draw(
                self.texture, 
                self_x, 
                self_y, 
                1, -- Rotation
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
            love.graphics.print(self.tType, self.body:getX() -5, self.body:getY())
            love.graphics.print(tostring(self.contact), self.body:getX() +5, self.body:getY())
        end
    end
  
    function Tile:update(dt)
        if state.left_mouse_click then
            if self.fixture:testPoint(love.mouse.getPosition()) then
                self.drag = true
                -- self.body:setMass(0,0,0,0)
                -- self.contact = true
            end
        end
        if not state.left_mouse_click then
            self.drag = false
            -- self.body:setLinearVelocity(0,0)
            -- self.contact = false
        end
        if self.drag then
            
            local x, y = love.mouse:getPosition()
            self.body:setPosition(x, y)
            self.x = x
            self.y = y
            
        end

    end

    function Tile:setInplay()
        
        self.inPlay = not self.inPlay
        
        -- local newX = x 
        -- local newY = y 

        -- self.body:setPosition(newX, newY)
        -- self.x = newX
        -- self.y = newY
    end

    -- function Tile:post_contact()

    --     self.contact = true
    -- end

    -- function Tile:end_contact()

    --     self.contact = false
    -- end

    
return Tile