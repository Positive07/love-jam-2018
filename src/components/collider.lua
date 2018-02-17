local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local defFilter  = function(item, other) return "slide" end
local defResolve = function(col) end

local Collider = Fluid.component(function(e, filter, resolve)
   e.filter  = filter  or defFilter
   e.resolve = resolve or defResolve
   e.world   = nil
end)

return Collider
