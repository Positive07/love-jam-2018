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

   self.hasBody    = t and t.hasBody
   self.filter     = t and t.filter
   self.isGrounded = false

   self.groundFrictionCoef = 100
   self.airFrictionCoef    = 20
   self.epsilon            = 0.75

   self.sprite = t and t.sprite

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
   if self.hasBody then
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

   if self.hasBody then
      local nx, ny, cols, len = World:move(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2)
      self.position.x, self.position.y = nx + self.size.x/2, ny + self.size.y/2

      for i = 1, len do
         self:resolveCollision(cols[i])
      end
   end
end

function Object:applyGravity(dt)
   self.velocity:add(World.gravity * dt)
end

function Object:applyFriction(dt)
   if self.isGrounded then
      local friction = self.velocity.x
      friction = friction - 1
      friction = friction * self.groundFrictionCoef
      friction = friction * dt

      self.velocity.x = self.velocity.x - friction * dt
   end

   local friction = self.velocity:clone()
   friction:mul(-1)
   friction:normalizeInplace()
   friction:mul(self.airFrictionCoef)
   friction:mul(dt)
   self.velocity:add(friction)

   if self.velocity.x > -self.epsilon and self.velocity.x < self.epsilon then
      self.velocity.x = 0
   end
end

function Object:resolveCollision(col)
   if col.normal.x ~= 0 then
      self.velocity.x = 0
   end

   if col.normal.y ~= 0 then
      self.velocity.y = 0

      if col.normal.y == -1 then
         self.isGrounded = true
      end
   end
end

function Object:update(dt)
   self:checkBody()
   self:applyGravity(dt)
   self:applyFriction(dt)

   self.isGrounded = false
   self:move(dt)
end

function Object:draw()
   if self.sprite then
      love.graphics.draw(self.sprite, self.position.x, self.position.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
   else
      love.graphics.rectangle("fill", math.floor(self.position.x - self.size.x/2), math.floor(self.position.y - self.size.y/2), self.size.x, self.size.y)
   end

   love.graphics.print(string.format("Position: %d, %d\nVelocity: %d, %d\nGrounded: %s", self.position.x, self.position.y, self.velocity.x, self.velocity.y, self.isGrounded), self.position.x + self.size.x/2, self.position.y - self.size.y/2)
end

return Object
