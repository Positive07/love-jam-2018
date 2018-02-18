local Quads = {}

local sw, sh = 512, 512

Quads["breakable_top_left"]     = love.graphics.newQuad(0,   0, 16, 16, 512, 512)
Quads["breakable_top"]          = love.graphics.newQuad(16,  0, 16, 16, 512, 512)
Quads["breakable_top_right"]    = love.graphics.newQuad(32,  0, 16, 16, 512, 512)
Quads["breakable_left"]         = love.graphics.newQuad( 0, 16, 16, 16, 512, 512)
Quads["breakable_middle"]       = love.graphics.newQuad(16, 16, 16, 16, 512, 512)
Quads["breakable_right"]        = love.graphics.newQuad(32, 16, 16, 16, 512, 512)
Quads["breakable_bottom_left"]  = love.graphics.newQuad( 0, 32, 16, 16, 512, 512)
Quads["breakable_bottom"]       = love.graphics.newQuad(16, 32, 16, 16, 512, 512)
Quads["breakable_bottom_right"] = love.graphics.newQuad(32, 32, 16, 16, 512, 512)

Quads["breakable_top_left"]     = love.graphics.newQuad( 0,  0, 16, 16, 512, 512)
Quads["breakable_top"]          = love.graphics.newQuad(16,  0, 16, 16, 512, 512)
Quads["breakable_top_right"]    = love.graphics.newQuad(32,  0, 16, 16, 512, 512)
Quads["breakable_left"]         = love.graphics.newQuad( 0, 16, 16, 16, 512, 512)
Quads["breakable_middle"]       = love.graphics.newQuad(16, 16, 16, 16, 512, 512)
Quads["breakable_right"]        = love.graphics.newQuad(32, 16, 16, 16, 512, 512)
Quads["breakable_bottom_left"]  = love.graphics.newQuad( 0, 32, 16, 16, 512, 512)
Quads["breakable_bottom"]       = love.graphics.newQuad(16, 32, 16, 16, 512, 512)
Quads["breakable_bottom_right"] = love.graphics.newQuad(32, 32, 16, 16, 512, 512)

Quads["cube"]  = love.graphics.newQuad(0, 96, 48, 48, 512, 512)

Quads["spike_up"] = love.graphics.newQuad(144, 70, 16, 9, 512, 512)

Quads["lantern"]     = love.graphics.newQuad(130, 144, 16, 21, 512, 512)
Quads["lantern_lit"] = love.graphics.newQuad(146, 144, 16, 21, 512, 512)


return Quads
