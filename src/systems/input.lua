local Fluid = require("lib.fluid")
local Baton = require("lib.baton")

local C = require("src.components")

local Input = Fluid.system({C.controls, C.inputResponse})

function Input:entityAdded(e)
   local controls = e:get(C.controls)
   controls.input = Baton:new({
      controls = {
         left = {'key:left', 'axis:leftx-', 'button:dpleft'},
         right = {'key:right', 'axis:leftx+', 'button:dpright'},
         down = {'key:down', 'axis:lefty+', 'button:dpdown'},
         jump = {'key:up', 'button:a'},
      },
      pairs = {
         move = {'left', 'right', 'down'}
      },
   })
end

function Input:entityRemoved(e)
   local controls = e:get(C.controls)

   if controls then
      controls.input = nil
   end
end

function Input:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local controls      = e:get(C.controls)
      local inputResponse = e:get(C.inputResponse)

      controls.input:update(dt)

      for action, func in pairs(inputResponse) do
         if controls.input.controls[action] and controls.input:pressed(action) then
            inputResponse[action](e, dt)
         elseif controls.input.pairs[action] then
            local x, y = controls.input:get(action)
            inputResponse[action](e, x, y, dt)
         end
      end
   end
end

return Input
