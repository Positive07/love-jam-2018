local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Sprite = Fluid.component(function(e, quad, layer)
   local _, _, w, h = quad:getViewport()

   e.quad   = quad
   e.layer  = layer
   e.id     = nil
   e.origin = Vector(w/2, h/2)
end)

return Sprite
