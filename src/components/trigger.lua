local Fluid = require("lib.fluid")

local Trigger = Fluid.component(function(e, name)
   e.name = name or "default"
end)

return Trigger
