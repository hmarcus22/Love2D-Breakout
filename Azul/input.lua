local Object = require "classic"
local state = require "state"

local input = Object:extend()
    
    input.releaseFunc = {}

    function input:new()
  
    end

    function input:release(key, code)

        if self.releaseFunc[key] then
            self.releaseFunc[key]()
        end
    end

    function input:mouseRelease(button)
        local old_mouse_click = state.left_mouse_click
        if button == 1 and old_mouse_click then
            state.left_mouse_click = false
           
        end
        
        -- print('Left Release:', state.left_mouse_click)
        old_mouse_click = state.right_mouse_click
        if button == 2 and old_mouse_click then
            state.right_mouse_click = false
            
        end 
        -- print('Right Release:', state.right_mouse_click)
    end

    function input:mousePress(button)
        -- print('Pressed button: ', button)
        if button == 1 then
            state.left_mouse_click = true
            
        elseif button == 2 then
            state.right_mouse_click = true
            
        end
        
        -- print('Left Click: ', state.left_mouse_click)
        -- print('Right Click: ', state.right_mouse_click)
    end
   
    function input.releaseFunc.escape()
        love.event.quit()
   end

return input