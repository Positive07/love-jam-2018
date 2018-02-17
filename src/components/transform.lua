local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Transform = Fluid.component(function(e, position, size)
   e.position = position or Vector(0, 0)
   e.size     = size     or Vector(1, 1)
end)

return Transform
