world = love.physics.newWorld(0, 0)

local end_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.end_contact then entity_a:end_contact() end
    if entity_b.end_contact then entity_b:end_contact() end
end

local begin_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.begin_contact then entity_a:begin_contact() end
    if entity_b.begin_contact then entity_b:begin_contact() end
end

local pre_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.pre_contact then entity_a:pre_contact() end
    if entity_b.pre_contact then entity_b:pre_contact() end
end

local post_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.post_contact then entity_a:post_contact() end
    if entity_b.post_contact then entity_b:post_contact() end
end

world:setCallbacks(
    begin_contact_callback,
    end_contact_callback,
    pre_solve_callback,
    post_solve_callback
)

return world
