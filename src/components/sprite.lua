local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Sprite = Fluid.component(function(e, sprites)
   e.sprites = sprites
end)

return Sprite
