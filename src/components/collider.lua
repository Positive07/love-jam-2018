local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Body     = require("src.components.body")
local Grounded = require("src.components.grounded")

local defFilter  = function(item, other) return "slide" end
local defResolve = function(col)
   local body = col.item:get(Body)

   if body then
      if col.normal.x ~= 0 then
         body.velocity.x = 0
      end

      if col.normal.y ~= 0 then
         body.velocity.y = 0

         if col.normal.y == -1 then
            col.item:give(Grounded, col.other)
         end
      end
   end
end

local Collider = Fluid.component(function(e, filter, resolve)
   e.filter  = filter  or defFilter
   e.resolve = resolve or defResolve
   e.world   = nil
end)

return Collider
