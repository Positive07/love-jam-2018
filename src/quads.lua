local Quads = {}

local sw, sh = 512, 512

Quads["pattern"] = love.graphics.newQuad(0, 0, 32, 32, sw, sh)

Quads["pillar_top"] = love.graphics.newQuad(0, 32, 32, 16, sw, sh)
Quads["pillar_mid"] = love.graphics.newQuad(0, 48, 32, 16, sw, sh)
Quads["pillar_bot"] = love.graphics.newQuad(0, 64, 32, 16, sw, sh)

Quads["cube"] = love.graphics.newQuad(0, 80, 48, 48, sw, sh)

return Quads
