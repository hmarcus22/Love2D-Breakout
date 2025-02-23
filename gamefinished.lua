local gamefinished = {}

function gamefinished.keyreleased(key, code)
    if key == 'return' then
        gamestates.set_state("game", {current_level = 1})
    elseif key == 'escape' then
        love.event.quit()
    end
end

function gamefinished.draw()
    love.graphics.print("Congratulations! You Won! Press enter to restart or Esc to exit.",
                                200, 100)
end

return gamefinished