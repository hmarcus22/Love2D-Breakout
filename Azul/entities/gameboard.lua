local Object = require "classic"

local Gameboard = Object:extend()

    function Gameboard:new()

        self.tileBoard = {}
        self.tileInput = {}
        self.minusRow = {}
        self.width = love.graphics.getWidth() - 40
        self.height = (love.graphics.getHeight() - 40) / 2
        self.x = (self.width +40) / 2
        self.y = self.height + (self.height / 2)
        self.body = love.physics.newBody(world, self.x, self.y, 'static')
        self.shape = love.physics.newRectangleShape(self.width, self.height)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        self.fixture:isSensor(true)
        self.fixture:setUserData(self)
        self.contact = false
        
    end
    
    function Gameboard:addTiles(tileSet, row)


    end

    function Gameboard:resolveBoard()

        
    end

    function Gameboard:draw()

        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
    end

    function Gameboard:begin_contact()
        print('contact!')
        self.contact = true
    end

    function Gameboard:end_contact()
        
        self.contact = false
    end
    

    return Gameboard