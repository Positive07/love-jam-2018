local Fluid = require("lib.fluid")

local JumpForce = Fluid.component(function(e, force)
   e.force = force or 500
end)

return JumpForce
