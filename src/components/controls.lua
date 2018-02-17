local Fluid = require("lib.fluid")

local Controls = Fluid.component(function(e, controls)
   e.controls = controls
   e.input    = nil
end)

return Controls
