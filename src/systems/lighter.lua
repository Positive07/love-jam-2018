local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local C = require("src.components")

local Lighter = Fluid.system({C.lit}, {C.lightable, "lightable"}, {C.moveOnBeat, "target"})

function Lighter:init(direction)
   self.default_direction = direction or Vector(1, 0)
end

function Lighter:entityAddedTo(e, pool)
   if pool.name == "pool" then

      for i = self.pool.size, 1, -1 do
         local o = self.pool:get(i)
         if o ~= e then
            o:remove(C.lit)
            o:check()
         end
      end

      for i = 1, self.target.size do
         local target = self.target:get(i)
         local mob = target:get(C.moveOnBeat)
         mob.direction = e:get(C.lit).direction
      end

      for i = 1, self.lightable.size do
        local lightable = self.lightable:get(i)
        local light = lightable:get(C.lightable)
        light.lighted = light.direction == e:get(C.lit).direction
      end

   elseif pool.name == "target" then

      local mob = e:get(C.moveOnBeat)
      if self.pool.size > 0 then
         mob.direction = self.pool:get(1):get(C.lit).direction
      else
         mob.direction = self.default_direction
      end

   elseif pool.name == "lightable" then

      local light = e:get(C.lightable)
      if self.pool.size > 0 then
         light.lighted = light.direction == self.pool:get(1):get(C.lit).direction
      else
         light.lighted = light.direction == self.default_direction
      end

   end
end

function Lighter:update(dt)
end

return Lighter
