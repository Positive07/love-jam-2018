local Fluid = require("lib.fluid")

local none = function(e) print("hello i was selected") end

local Selectable = Fluid.component(function(e, func)
   e.func = func or none
end)

return Selectable
