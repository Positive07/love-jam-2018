local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Body = Fluid.component(function(e, velocity, groundCoef, airCoef, gravityScale)
   e.velocity     = velocity     or Vector(0, 0)
   e.groundCoef   = groundCoef   or 200
   e.airCoef      = airCoef      or 40
   e.gravityScale = gravityScale or 1
end)

return Body
