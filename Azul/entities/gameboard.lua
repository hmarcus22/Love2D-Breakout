local Object = require "classic"

local gameboard = Object:extend()

    function gameboard:new()

        self.tileBoard = {}
        self.tileInput = {}
        self.minusRow = {}
    end

    function gameboard:addTiles(tileSet, row)


    end

    function gameboard:resolveBoard()

        
    end

    return gameboard