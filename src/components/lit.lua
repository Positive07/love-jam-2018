local Fluid = require("lib.fluid")

local Lit = Fluid.component(function(e, direction)
   e.direction = direction
end)

return Lit
