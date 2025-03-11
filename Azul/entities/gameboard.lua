local Object = require "classic"

local gameboard = Object:extend()

    function gameboard:new()

        self.tileBoard = {}
        self.tileInput = {}
        self.minusRow = {}
    end

    function gameboard:insertTileToTileInput(tileSet, row)


    end

    function gameboard:resolveTiles()

        
    end

    return gameboard