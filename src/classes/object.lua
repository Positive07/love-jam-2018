local Class  = require("libs.class")
local List   = require("libs.list")
local Vector = require("libs.vector")

local World = require("src.world")

local Object = Class("Object")
Object.list        = List()
Object.dyanmicList = List()

function Object:initialize(t)
   self.position = t and t.position or Vector(0, 0)
   self.velocity = t and t.velocity or Vector(0, 0)
   self.size     = t and t.size     or Vector(0, 0)

   self.body   = t and t.body
   self.filter = t and t.filter

   self.dynamic = t and t.dynamic

   self:checkBody()

   Object.list:add(self)
   if self.dynamic then
      Object.dyanmicList:add(self)
   end
end

function Object:destroy()
   Object.list:remove(self)
   if self.dynamic then
      Object.dyanmicList:remove(self)
   end
end

function Object:addBody()
   World:add(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.size.x, self.size.y)
end

function Object:removeBody()
   World:remove(self)
end

function Object:checkBody()
   if self.body then
      if not World:hasItem(self) then
         self:addBody()
      end
   elseif World:hasItem(self) then
      self:removeBody()
   end
end

function Object:updateBody()
   World:update(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.size.x, self.size.y)
end

function Object:move(dt)
   self.position:add(self.velocity * dt)

   if self.body then
      local nx, ny, cols, len = World:move(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2)
      self.position.x, self.position.y = nx + self.size.x/2, ny + self.size.y/2

      for i = 1, len do
         self:resolveCollision(cols[i])
      end
   end
end

function Object:resolveCollision(col)
end

function Object:update(dt)
   self:checkBody()
   self:move(dt)
end

function Object:draw()
   love.graphics.rectangle("fill", self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.size.x, self.size.y)
end

return Object
