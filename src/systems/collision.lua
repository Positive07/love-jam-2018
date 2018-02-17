local Fluid = require("lib.fluid")
local Bump  = require("lib.bump")

local C = require("src.components")

local Collider = Fluid.system({C.transform, C.collider})

function Collider:init()
   self.world = Bump.newWorld(64)
end

function Collider:entityAdded(e)
   local transform = e:get(C.transform)
   local collider  = e:get(C.collider)

   collider.world = self.world
   self.world:add(e, transform.position.x - transform.size.x/2, transform.position.y - transform.size.y/2, transform.size.x, transform.size.y)
end

function Collider:entityRemoved(e)
   self.world:remove(e)

   local collider  = e:get(C.collider)
   if collider then
      collider.world = nil
   end
end

function Collider:update()
   local e
   for i = 1, self.pool.size do
      local e = self.pool:get(i)

      local transform = e:get(C.transform)
      local collider  = e:get(C.collider)

      local newx, newy, cols, len = self.world:move(e, transform.position.x - transform.size.x/2, transform.position.y - transform.size.y/2, collider.filter)
      transform.position:set(newx + transform.size.x/2, newy + transform.size.y/2)

      for i = 1, len do
         collider.resolve(cols[i])
      end
   end
end

function Collider:draw()
   love.graphics.setColor(0, 255, 0)
   local items, len = self.world:getItems()

   for i = 1, len do
      local x, y, w, h = self.world:getRect(items[i])
      love.graphics.rectangle("line", x, y, w, h)
   end
end

return Collider
