local Fluid = require("lib.fluid")

local Animation = Fluid.component(function(e, animation)
   e.animation = animation
end)

return Animation
