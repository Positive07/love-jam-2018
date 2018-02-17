local Fluid = require("lib.fluid")

local C = require("src.components")

local Input = Fluid.system({C.controls, C.inputResponse})

function Input:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local input = e:get(C.controls).input
      input:update()

      for _, response in pairs(e:get(C.inputResponse)) do
         response(e, input, dt)
      end
   end
end

return Input
