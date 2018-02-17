local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local defFilter     = function(item, other) return "slide" end
local defResolution = function(col) end

local Collider = Fluid.component(function(e, filter, resolution)
   e.filter        = filter     or defFilter
   e.defResolution = resolution or defResolution
end)

return Collider
