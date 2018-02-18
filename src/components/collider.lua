local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Body        = require("src.components.body")
local Grounded    = require("src.components.grounded")

local Collider = Fluid.component(function(e, filter, resolve)
   e.filter  = filter  or defFilter
   e.resolve = resolve or defResolve
   e.world   = nil
end, true)

Collider.filter  = function(item, other) return "slide" end
Collider.resolve = function(col)
   local body = col.other:get(Body)

   if body then
      if col.normal.x ~= 0 then
         body.velocity.x = 0
      end

      if col.normal.y ~= 0 then
         body.velocity.y = 0

         if col.normal.y == -1 then
            col.other:give(Grounded, col.item)
         end
      end
   end
end

return Collider
