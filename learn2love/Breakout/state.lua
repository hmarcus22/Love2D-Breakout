return {
    button_left = false,
    button_right = false,
    mouse_click = false,
    mouse_grab = true,
    serve = true,
    game_over = false,
    palette = {
        {0.0, 0.6, 0.0, 1.0},  -- dark green
        {0.0, 1.0, 0.0, 1.0},  -- green
        {0.4, 0.4, 1.0, 1.0},  -- blue
        {0.9, 1.0, 0.2, 1.0},  -- yellow
        {1.0, 1.0, 1.0, 1.0}   -- white
    },
    paused = false,
    stage_cleared = false,
    lives = 2,
    paddle_pos = {x = 0, y = 0},
    current_level = 1
}