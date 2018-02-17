local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local MoveOnBeat = Fluid.component(function(e, direction, moveTime)
   e.direction = direction or Vector.up
   e.moveTime  = moveTime  or 0.25
end)

return MoveOnBeat
