tile_ = {}
tile_.type = 0
tile_.x = 0
tile_.y = 0

function tile_:new(type, x, y)

    self.type = 0 or type
    self.x = 0 or x
    self.y = 0 or y

end

function tile_:get()
    return self.type, self.x, self.y
end

return tile_