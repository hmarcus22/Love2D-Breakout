local Entity = require "entities/entity"
local Square = require "entities/square"
local state = require "state"

local Gameboard = Entity:extend()

    function Gameboard:new(playerNr)
        Gameboard.super.new(self, id)
        self.player = playerNr
        self.tileMatrix = nil
        self.tileInput = nil -- upp to 5 tiles
        self.minusRow = {} -- 7 tiles
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
        self.offsetX = 80
        self.selectedRow = 0
        self.isRow = false
    end
    
    function Gameboard:update(dt)
        --If choosen chase mouse
       --Set target
       local tileCount = 0
       local step = 60
       for _, tile in pairs(self.ownedEntities) do
           if tile.choosen then
               tileCount = tileCount +1
               local offX = tileCount * step
               tile.targetX = love.mouse.getX() - offX
               tile.targetY = love.mouse.getY()
           
               --Chase target smoothly
               if tile.body:getX() ~= tile.targetX or tile.body:getY() ~= tile.targetY then
                   
                   local dx = tile.targetX - tile.body:getX()
                   local dy = tile.targetY - tile.body:getY()
                   local newX = tile.body:getX() + dx * tile.speed * dt
                   local newY = tile.body:getY() + dy * tile.speed * dt
                   
                   tile.body:setPosition(newX, newY)
                   tile.x = newX
                   tile.y = newY
               end
           end
       end
       
       --Dectect wich row is selected
       self.selectedRow = 0
       self.isRow = false
       for ir, row in ipairs(self.tileInput) do
           for is, square in ipairs(row) do
               if square.fixture:testPoint(love.mouse.getPosition()) then
                   self.selectedRow = ir
                   self.isRow = true
                   break
               end
           end
       end

       --Insert tiles to selected input row
       if state.left_mouse_click then
            if self.selectedRow > 0 then
                local pos = #self.tileInput[self.selectedRow]
                for _, tile in pairs(self.ownedEntities) do
                    
                    tile.choosen = false
                    tile.setTarget(self.tileInput[self.selectedRow][pos]:getPos())

                end
            end
       end
   end

   function Gameboard:draw()
    if state.curentPlayer == self.player then
        love.graphics.print('Player' .. self.player, self.x, self.y, 0, 1, 1, self.width * .5 - 10, self.height * .5 -10)
        love.graphics.print('Selected row: ' .. self.selectedRow, self.x, self.y, 0, 1, 1, self.width * .5 - 10, self.height * .5 -25)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        for _, row  in ipairs(self.tileMatrix) do
            for _, square in pairs(row) do
                love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
                -- print(square.x, square.y)
            end
        end
        for _, row  in ipairs(self.tileInput) do
            for _, square in pairs(row) do
                love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
                -- print(square.x, square.y)
            end
        end
        for _, square in pairs(self.minusRow) do
            love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
            -- print(square.x, square.y)
        end
    end
end
    
    function Gameboard:initBoard()
        self:initTileMatrix()
        self:initTileInput()
        self:initMinusRow()
        
    end
    
    function Gameboard:initTileMatrix()
        local y_pos = 420
        local matrix = {{1, 2, 3, 4, 5},
                        {5, 1, 2, 3, 4},
                        {4, 5, 1, 2, 3},
                        {3, 4, 5, 1, 2},
                        {2, 3, 4, 5, 1}}
        local grid = {}
        for _, row in ipairs(matrix) do
            local x_pos = (self.width * .5) + 10
            local sRow = {}
            for _, type in pairs(row) do
                local square = Square(x_pos, y_pos, type)
                table.insert(sRow, square)
                x_pos = x_pos + 50
            end
            table.insert(grid, sRow)
            y_pos = y_pos + 50
        end
        self.tileMatrix = grid
    end

    function Gameboard:initTileInput()
        local y_pos = 420
        local matrix = {{1},
                        {5, 1},
                        {4, 5, 1},
                        {3, 4, 5, 1},
                        {2, 3, 4, 5, 1}}
        local grid = {}
        for _, row in ipairs(matrix) do
            local x_pos = (self.width * .5) - self.offsetX
            local sRow = {}
            for _, type in pairs(row) do
                local square = Square(x_pos, y_pos, type)
                table.insert(sRow, square)
                x_pos = x_pos - 50
            end
            table.insert(grid, sRow)
            y_pos = y_pos + 50
        end
        self.tileInput = grid
        
    end
    
    function Gameboard:initMinusRow()
        local y_pos = 725

        local matrix = {1, 2, 3, 4, 5, 6, 7}
        local x_pos = (self.width * .5) + 180
        for number = 1, 7 do
            
            local square = Square(x_pos, y_pos, type)
            table.insert(self.minusRow, square)
            x_pos = x_pos - 50
        end
        
        
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
    