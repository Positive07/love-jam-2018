local Quads = {}

local sw, sh = 512, 512

Quads["pattern"] = love.graphics.newQuad(96, 0, 32, 32, sw, sh)

Quads["pillar_top"] = love.graphics.newQuad( 96, 32, 32, 16, sw, sh)
Quads["pillar_mid"] = love.graphics.newQuad(112, 48, 32, 16, sw, sh)
Quads["pillar_bot"] = love.graphics.newQuad(128, 64, 32, 16, sw, sh)

Quads["cube"] = love.graphics.newQuad(128, 96, 48, 48, sw, sh)

Quads["door_open"]   = love.graphics.newQuad( 96, 80, 16, 16, sw, sh)
Quads["door_closed"] = love.graphics.newQuad(112, 80, 16, 16, sw, sh)

Quads["lantern_lit"]   = love.graphics.newQuad( 0, 128, 16, 32, sw, sh)
Quads["lantern_lit_l"] = love.graphics.newQuad(16, 128, 16, 32, sw, sh)
Quads["lantern_lit_r"] = love.graphics.newQuad(32, 128, 16, 32, sw, sh)
Quads["lantern_lit_u"] = love.graphics.newQuad(48, 128, 16, 32, sw, sh)
Quads["lantern_lit_d"] = love.graphics.newQuad(64, 128, 16, 32, sw, sh)

Quads["lantern"]   = love.graphics.newQuad( 0, 160, 16, 32, sw, sh)
Quads["lantern_l"] = love.graphics.newQuad(16, 160, 16, 32, sw, sh)
Quads["lantern_r"] = love.graphics.newQuad(32, 160, 16, 32, sw, sh)
Quads["lantern_u"] = love.graphics.newQuad(48, 160, 16, 32, sw, sh)
Quads["lantern_d"] = love.graphics.newQuad(64, 160, 16, 32, sw, sh)

return Quads
