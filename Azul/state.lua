return {
    nrPlayers = 2,
    nrTiles = 100,
    nrBuckets = 5,
    seed = os.time(),
    curentPlayer = 1,
    left_mouse_click = false,
    right_mouse_click = false,
    update = false,
    palette = {
        {.4, .4, 1, .9}, -- Blue
        {1, 1, .4, .9}, -- Yellow
        {1, .4, .4, .9}, -- Red
        {.4, .4, .4, .9}, -- Black
        {1, 1, 1, .9} -- White
    }
}