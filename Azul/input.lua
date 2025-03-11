local Object = require "classic"

local input = Object:extend()
    
    input.releaseFunc = {}

    function input:new()
  
    end

    function input:release(key, code)

        if self.releaseFunc[key] then
            self.releaseFunc[key]()
        end
    end

   function input.releaseFunc.escape()
        love.event.quit()
   end

return input