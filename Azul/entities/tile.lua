-- local Object = require "classic"
local state = require "state"
local world = require "world"
local Entity = require "entities/entity"

local Tile = Entity:extend()  

    function Tile:new(type, x, y)
        Tile.super.new(self)
        self.tType = (type or 5)
        self.size = 30
        self.x = x
        self.y = (y or 20)
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
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
        self.texture = love.graphics.newImage('img/gem.png')
        

    end

    function Tile:setPos(x, y, id)
        if id == self.id then
            -- print('setPos x, y: ' .. x, y)
            self.body:setPosition(x, y)
        end
        
    end

    function Tile:draw()
        if self.inPlay then
            local self_x, self_y = self.body:getWorldCenter()
            love.graphics.setColor(state.palette[self.tType])
            -- love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.draw(
                self.texture, 
                self_x, 
                self_y, 
                0,      -- Rotation
                .5,     -- Scale factor x
                .5,     -- Scale factor y
                self.texture:getWidth()/2, 
                self.texture:getHeight()/2
            )
            
            
            -- Use a different color for the text based on the tile type
            -- if self.tType == 5 then
            --     love.graphics.setColor(state.palette[4])  -- Black
            -- else
                love.graphics.setColor(state.palette[5])  -- White
            -- end
            
            --Debug stuff
            -- love.graphics.print(self.tType, self.body:getX() -5, self.body:getY())
            love.graphics.print('O: ' .. tostring(self.owner.nr), self.body:getX() - 20, self.body:getY())
        end
    end
  
    function Tile:update(dt)
        
        
        

        if state.left_mouse_click then
            if self.fixture:testPoint(love.mouse.getPosition()) then
                self.drag = true
            end
        end
        if not state.left_mouse_click then
            self.drag = false
        end
        if self.drag then
            
            local x, y = love.mouse:getPosition()
            x = x +200
            self.body:setPosition(x, y)
            self.x = x
            self.y = y
        end

    end

    function Tile:setInplay()
                
        self.inPlay = true
    end

    function Tile:createDestroy()
        if self.inPlay then
            
            
        elseif not self.inPlay then
            if self.fixture then            
                self.fixture:destroy()
            end
        end
    end

  

    
return Tile