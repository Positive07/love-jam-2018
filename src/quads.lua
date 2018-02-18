local Quads = {}

local sw, sh = 512, 512

Quads["pattern"] = love.graphics.newQuad(96, 0, 32, 32, sw, sh)

Quads["pillar_top"] = love.graphics.newQuad(96, 32, 32, 16, sw, sh)
Quads["pillar_mid"] = love.graphics.newQuad(112, 48, 32, 16, sw, sh)
Quads["pillar_bot"] = love.graphics.newQuad(128, 64, 32, 16, sw, sh)

Quads["cube"] = love.graphics.newQuad(128, 96, 48, 48, sw, sh)

return Quads
