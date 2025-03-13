local Object = require "classic"

local Bucket = Object:extend()

    Bucket.tileBucket = {}

    function Bucket:new(id)

        self.id = id
        self.type = 'bucket'
        
    end

    function Bucket:addTiles(tile)
        
            table.insert(Bucket.tileBucket, tile)
        
    end

    return Bucket