local Fluid = require("lib.fluid")

local Grounded = Fluid.component(function(e, surface)
   e.surface = surface
end)

return Grounded
