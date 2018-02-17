local Fluid = require("lib.fluid")

local MoveSpeed = Fluid.component(function(e, speed)
   e.speed = speed or 100
end)

return MoveSpeed
