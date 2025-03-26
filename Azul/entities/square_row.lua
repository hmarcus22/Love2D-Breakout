local Entity = require "entities/entity"
local Square = require "entities/square"

local SquareRow = Entity:extend()  

    function SquareRow:new()
        SquareRow.super.new(self)
        self.width = love.graphics.getWidth()
        self.offsetX = 80
        self.squareMatrix = self:initSquareMatrix()
        self:setOwner(self)
        
    end

    function SquareRow:initSquareMatrix()
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
                local square = Square(x_pos, y_pos)
                sRow[i] = square
                x_pos = x_pos - 50
            end
            grid[j] = sRow
            y_pos = y_pos + 50
        end
        return grid
        
    end

    function SquareRow:getPos(row, index)
        return self.squareMatrix[row][index]:getPos()
    end

    return SquareRow