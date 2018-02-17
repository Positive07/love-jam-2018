local Fluid = require("lib.fluid")

local C = require("src.components")

local Input = Fluid.system({C.controls, C.inputResponse})

function Input:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local controls      = e:get(C.controls)
      local inputResponse = e:get(C.inputResponse)

      for action, key in pairs(controls) do
         if love.keyboard.isDown(key) then
            inputResponse[action](e, dt)
         end
      end
   end
end

return Input
