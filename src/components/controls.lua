local Fluid = require("lib.fluid")

local Controls = Fluid.component(function(e, left, right, jump)
   e.left  = left  or "left"
   e.right = right or "right"
   e.jump  = jump  or "up"
end)

return Controls
