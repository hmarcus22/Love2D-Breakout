local Entity = require "entities/entity"
local Square = require "entities/square"
local state = require "state"
local inputRow = require "entities/input_row"
local SquareRow = require "entities/square_row"
local Button = require "entities/button"

local Gameboard = Entity:extend()

    function Gameboard:new(playerNr)
        Gameboard.super.new(self, id)
        self.player = playerNr
        self.squareMatrix = nil
        self.tileMatrix = {}
        self.tileInputSquare = nil -- upp to 5 tiles
        self.tileInputRow = {
            inputRow(1),
            inputRow(2),
            inputRow(3),
            inputRow(4),
            inputRow(5)
        }
        self.minusSquare = {} -- 7 tiles
        self.minusRow = {inputRow(7)}
        self.minusRowCount = 0
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
        self.z = 2
        
    end
    
    
    function Gameboard:update(dt)
        --If choosen chase mouse
       --Set target
       local tileCount = 0
       local step = 50
       for _, tile in pairs(self.ownedEntities) do
           if tile.choosen then
                local offX = tileCount * step
                tileCount = tileCount +1
               
               tile.targetX = love.mouse.getX() - offX - 30
               tile.targetY = love.mouse.getY()
           
               
               
           end
       end
          --Insert tiles to selected input row
          self:getSelectedRow()
          if self.selectedRow >= 1 and self.selectedRow <= 5 and state.left_mouse_click then
            for _, tile in pairs(self.ownedEntities) do
              if tile.choosen then
                -- Check if row is full    
                if not self.tileInputRow[self.selectedRow]:isFull() then
                        --Check wich index is to be used
                        local col = self.tileInputRow[self.selectedRow]:size() + 1
                        --Get position for index to be used
                        local x, y = self.tileInputSquare[self.selectedRow][col]:getPos()
                        --Set tile position
                        tile:setTarget(x, y, tile.id)
                        --Add tile to inputRow
                        self.tileInputRow[self.selectedRow]:add(tile)
                    else -- If no room in inputrow add to minusRow
                        local col = self.minusRow[1]:size() + 1
                        local x, y = self.minusSquare[col]:getPos()
                        tile:setTarget(x, y, tile.id)
                        self.minusRow[1]:add(tile)
                    end
                    --Uppdate states of tile
                    tile.choosen = false
                    tile.highlight = false
                    tile.placed = true
              end
            end
        --Insert Tiles directly to minusRow
        elseif self.selectedRow == 6 and state.left_mouse_click then
            for _, tile in pairs(self.ownedEntities) do
                if tile.choosen then
                    if not self.minusRow[1]:isFull() then
                        local col = self.minusRow[1]:size() + 1
                        local x, y = self.minusSquare[col]:getPos()
                        tile:setTarget(x, y, tile.id)
                        self.minusRow[1]:add(tile)
                    end
                    tile.choosen = false
                    tile.highlight = false
                    tile.placed = true
                end
            end
        end

        --Tile Chase target smoothly
        if self.ownedEntities then
            for _, tile in pairs(self.ownedEntities) do
                if not tile:is(Button) then
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
        end

       
   end

   function Gameboard:resolve()
    
   end

   function Gameboard:getSelectedRow()

        --Dectect wich row is selected
        self.selectedRow = 0
        self.isRow = false
        for ir, row in ipairs(self.tileInputSquare) do
            for is, square in ipairs(row) do
                if square.fixture:testPoint(love.mouse.getPosition()) then
                    self.selectedRow = ir
                    self.isRow = true
                    break
                end
            end
        end
        for mr, square in ipairs(self.minusSquare) do
            if square.fixture:testPoint(love.mouse.getPosition()) then
                self.selectedRow = 6
                self.isRow = true
            end
        end
    
   end

   function Gameboard:draw()
    if state.curentPlayer == self.player then
        love.graphics.print('Player' .. self.player, self.x, self.y, 0, 1, 1, self.width * .5 - 10, self.height * .5 -10)
        love.graphics.print('Selected row: ' .. self.selectedRow, self.x, self.y, 0, 1, 1, self.width * .5 - 10, self.height * .5 -25)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
        -- love.graphics.print(tostring(self.contact), self.x + 40, self.y - 40)
        for _, row  in ipairs(self.squareMatrix) do
            for _, square in pairs(row) do
                love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
                love.graphics.printf(square.tType, square.body:getX(), square.body:getY(), square.width, 'center', 0, 2, 2, square.width/2, square.width/6)
            end
        end
        for _, row  in ipairs(self.tileInputSquare) do
            for _, square in pairs(row) do
                love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
            end
        end
        for _, square in pairs(self.minusSquare) do
            love.graphics.polygon('line', square.body:getWorldPoints(square.shape:getPoints()))
        end
    end
end
    
    function Gameboard:initBoard()
        self:initSquareMatrix()
        self:initTileInputSquare()
        self:initMinusSquare()
        
    end
    
    function Gameboard:initSquareMatrix()
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
        self.squareMatrix = grid
    end

    function Gameboard:initTileInputSquare()
        local y_pos = 420
        local matrix = {{1},
                        {5, 1},
                        {4, 5, 1},
                        {3, 4, 5, 1},
                        {2, 3, 4, 5, 1}}
        local grid = {}
        for j, row in ipairs(matrix) do
            local x_pos = (self.width * .5) - self.offsetX
            local sRow = {}
            for i, type in ipairs(row) do
                local square = Square(x_pos, y_pos, type)
                sRow[i] = square
                x_pos = x_pos - 50
            end
            grid[j] = sRow
            y_pos = y_pos + 50
        end
        self.tileInputSquare = grid
    end
    
    function Gameboard:initMinusSquare()
        local y_pos = 725
        local x_pos = (self.width * .5) + 180
        for number = 1, 7 do
            
            local square = Square(x_pos, y_pos, type)
            table.insert(self.minusSquare, square)
            x_pos = x_pos - 50
        end
    end

    function Gameboard:resolveBoard()

    end

    function Gameboard:begin_contact()
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
    