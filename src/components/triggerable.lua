local Fluid = require("lib.fluid")

local function none(e, other) end --luacheck: ignore

local Triggerable = Fluid.component(function(e, func)
   e.func = func or none
end)

return Triggerable
