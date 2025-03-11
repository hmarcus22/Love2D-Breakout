local Object = require "classic"

local bucket = Object:extend()

    bucket.tileBucket = {}

    function bucket:new(id)

        self.id = id
        
        self.type = 'bucket'
    end

    function bucket:addTiles(tile)
        
            table.insert(bucket.tileBucket, tile)
        
    end

    return bucket