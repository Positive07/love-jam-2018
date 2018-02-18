local Fluid = require("lib.fluid")

local Lightable = Fluid.component(function(e, direction)
   e.direction = direction
   e.lighted = false
end)

return Lightable
