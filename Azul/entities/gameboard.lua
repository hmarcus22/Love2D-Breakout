local Entity = require "entities/entity"

local Gameboard = Entity:extend()

    function Gameboard:new()
        Gameboard.super.new(self, id)
        self.tileMatrix = { {1}, {2}, {3}, {4}, {5},
                            {5}, {1}, {2}, {3}, {4},
                            {4}, {5}, {1}, {2}, {3},
                            {3}, {4}, {5}, {1}, {2},
                            {2}, {3}, {4}, {5}, {1} }
        self.tileInput = { {}, {}, {}, {}, {} }
        self.minusRow = {}
        self.selectedTiles =  {}
        self.selectedRow = 0
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
    
    function Gameboard:selecedtTiles()

        
    end
    
    function Gameboard:addTiles(tileSet, row)


    end

    -- Untested
    function Gameboard:insertTiles(tiles)
        for index = 1 , #tiles do
            if index <= #tiles then
                self.tileInput[self.selectedRow] = tiles[index].id
            else
                for _, tile in pairs(tiles) do
                    table.insert(self.minusRow, tile.id)
                end
            end
        end
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

    --Gamebord has input rows, first is 1 tile second is 2 .... last is 5 tiles.
    --Has tilematrix, 5 x 5 tiles. each row has a spcesified place for 1 tile of each tiletype.
    
    --Should take ownership of tiles when selected from bucket.
    
    --Add tiles - Fill an input row with all selected tiles. If full put leftovers in minusrow

    --Moves tiles from inputrow to tilematrix att end of round and counts score.
    --subtracts potential minus score last.
    