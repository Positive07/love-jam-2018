local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Sprite = Fluid.component(function(e, quad)
   --local w, h = quad:getViewport()
   local w, h = quad:getDimensions()

   e.quad   = quad
   e.origin = Vector(w/2, h/2)
end)

return Sprite
