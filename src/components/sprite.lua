local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Sprite = Fluid.component(function(e, layer, quads)
   e.layer   = layer
   e.quads   = quads
   e.origins = {}
   e.ids     = {}

   for i, quad in ipairs(e.quads) do
      local _, _, w, h = quad[1]:getViewport()
      e.origins[i] = Vector(w/2, h/2)
   end
end)

return Sprite
