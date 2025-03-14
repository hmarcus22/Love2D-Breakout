local Object = require "classic"

local Bucket = Object:extend()

    

    function Bucket:new(id)

        self.id = id
        self.type = 'bucket'
        self.tileBucket = {}
        self.isFull = false
        
    end

    function Bucket:addTiles(tile)
        local nTile = tile
            table.insert(self.tileBucket, nTile)
        
    end

    function Bucket:isFull()
        if #self.tileBucket == 5 then
            self.isFull = true
        end
        return self.isFull
    end

    return Bucket