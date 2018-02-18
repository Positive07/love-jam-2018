local Fluid = require("lib.fluid")
local Baton = require("lib.baton")

local C = require("src.components")

local Selecter = Fluid.system({C.transform, C.selectable}, {C.selected, "selected"})

function Selecter:init(collider)
   self.collider = collider
   self.controls = Baton:new({
      controls = {
         left  = {'key:left', 'axis:leftx-', 'button:dpleft'},
         right = {'key:right', 'axis:leftx+', 'button:dpright'},
         up    = {'key:up', 'key:up', 'axis:lefty-', 'button:dpup'},
         down  = {'key:down', 'axis:lefty+', 'button:dpdown'},
      },
      pairs = {
         move = {'left', 'right', 'up', 'down'},
      },
      joystick = love.joystick.getJoysticks()[1],
   })
end

function Selecter:update(dt)
   self.controls:update()

   local e
   for i = 1, self.selected.size do
      e = self.selected:get(i)
      e:remove(C.selected)
      e:check()
   end

   local mx, my = love.mouse.getPosition()
   local items, len = self.collider.world:queryPoint(mx, my)

   for i = 1, len do
      local e = items[i]

      if e:has(C.selectable) then
         e:give(C.selected)
         e:check()
      end
   end
end

return Selecter
