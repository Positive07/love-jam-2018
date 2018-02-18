local Fluid = require("lib.fluid")

local C = require("src.components")

local Animator = Fluid.system({C.sprite, C.animation})

function Animator:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local quads     = e:get(C.sprite).sprites
      local animation = e:get(C.animation).animation

      animation(e, quads, dt)
   end
end

return Animator