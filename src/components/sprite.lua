local Fluid  = require("lib.fluid")

local Sprite = Fluid.component(function(e, sprites)
   e.sprites = sprites
end)

return Sprite
