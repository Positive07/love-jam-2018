local Fluid = require("lib.fluid")
local Baton = require("lib.baton")

local Controls = Fluid.component(function(e, config)
   e.input = Baton.new(config)
end)

return Controls
