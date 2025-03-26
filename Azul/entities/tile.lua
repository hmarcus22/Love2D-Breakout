-- local Object = require "classic"
local state = require "state"
local world = require "world"
local Entity = require "entities/entity"

local Tile = Entity:extend()  

    function Tile:new(type, x, y)
        Tile.super.new(self)
        self.tType = (type or 5)
        self.size = 50
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
        self.highlight = false
        self.scale = .5
        self.scaleT = self.scale
        self.scaleSpeed = 20
        self.mouseOver = false
        self.selected = false
        self.choosen = false
        self.minus = false
        self.input = false
        self.placed = false
        self.targetX = self.body:getX()
        self.targetY = self.body:getY()
        self.speed = 15
        self.transform = nil
        self.rotation = 0
        self.idle = true
        self.skewX = 0
        self.skewY = 0
    end

    function Tile:setPos(x, y, id)
        if id == self.id then
            -- print('setPos x, y: ' .. x, y)
            self.body:setPosition(x, y)
        end
        
    end

    function Tile:setTarget(x, y, id)
        if id == self.id then
            -- print('setPos x, y: ' .. x, y)
            self.targetX = x
            self.targetY = y
        end
        
    end

    function Tile:update(dt)
        --Check if mouse over
        if self.fixture:testPoint(love.mouse.getPosition()) and not self.placed then
            self.mouseOver = true
            
            -- print('MouseOver!')
        else
            self.mouseOver = false
            self.idle = true
        end
        --Set scale
        if self.highlight and self.mouseOver then
            self.scaleT = .6
            self.idle = false
        elseif self.highlight and not self.choosen then
            self.scaleT = .55
            self.idle = false
        -- elseif self.choosen and self.highlight then
        --     self.scaleT = .5
        --     self.idle = false
        else
            self.scaleT = .5
            self.idle = true

        end
        

         --Smooth scaling
         if self.scale ~= self.scaleT then
            local ds = self.scaleT - self.scale
            self.scale = self.scale + ds * self.scaleSpeed * dt
        end

       
       
        --Handle mouse click interaction
        if state.left_mouse_click then
            if self.fixture:testPoint(love.mouse.getPosition()) and not self.placed then
                self.selected = not self.selected
            end
        end
        if not state.left_mouse_click then
            
        end
        -- if self.drag then
            
        --     local x, y = love.mouse:getPosition()
        --     -- x = x +200
        --     self.body:setPosition(x, y)
        --     self.x = x
        --     self.y = y
        -- end

        --Transform
        -- if self.idle then
        --     self.rotation = self.rotation + dt * 0.5
        --     self.skewX = math.sin(self.rotation) * 0.2
        --     self.skewY = math.sin(self.rotation + ((math.pi /2))) * 0.1
           
        -- else
        --     self.rotation = 0
        --     self.skewX = 0
        --     self.skewY = 0
        -- end
    end

    function Tile:draw()
        if self.inPlay then
            local self_x, self_y = self.body:getWorldCenter()
            love.graphics.setColor(state.palette[self.tType])
            -- love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.push()
            -- if self.idle then
            --     love.graphics.applyTransform(self.transform)
            -- end
            love.graphics.draw(
                self.texture, 
                self_x, 
                self_y, 
                0,      -- Rotation
                self.scale,     -- Scale factor x
                self.scale,     -- Scale factor y
                self.texture:getWidth()/2,
                self.texture:getHeight()/2,
                self.skewX,
                self.skewY
            )
            love.graphics.pop()
            love.graphics.setColor(state.palette[5])  -- White
            love.graphics.print('O: ' .. tostring(self.owner.nr), self.body:getX() - 20, self.body:getY())
        end
    end

    function Tile:gettType()
        return self.tType
        
    end

    function Tile:getMouseOver()
        print('returning Mouseover true!')
        return self.mouseOver
        
    end

    function Tile:getHighlight()
        return self.highlight
        
    end
    
    function Tile:hilightToggle(toggle)
        self.highlight = toggle
    end

    function Tile:setInplay()
                
        self.inPlay = true
    end

    -- function Tile:createDestroy()
    --     if self.inPlay then
            
            
    --     elseif not self.inPlay then
    --         if self.fixture then            
    --             self.fixture:destroy()
    --         end
    --     end
    -- end

  

    
return Tile