local Fluid = require("lib.fluid")

local C = require("src.components")

local Lighter = Fluid.system({C.lit}, {C.moveOnBeat, "target"})

function Lighter:entityAddedTo(e, pool)
   print(e)
   if pool.name == "pool" then
      for i = self.pool.size, 1, -1 do
         local o = self.pool:get(i)
         print(o)
         if o ~= e then
            o:remove(C.lit)
            o:check()
         end
      end

      for i = 1, self.target.size do
         local target = self.target:get(i)
         local mob = target:get(C.moveOnBeat)
         self.target:get(i):get(C.moveOnBeat).direction = e:get(C.lit).direction
      end
   end
end

function Lighter:update(dt)
end

return Lighter
