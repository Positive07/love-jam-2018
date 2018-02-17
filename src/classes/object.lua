local Class  = require("libs.class")
local List   = require("libs.list")
local Vector = require("libs.vector")

local World = require("src.world")
local Batch = require("src.states.game.batch")

local Object = Class("Object")
Object.list        = List()
Object.dyanmicList = List()

function Object:initialize(t)
   t = t or {}

   self.position = t.position or Vector(0, 0)
   self.velocity = t.velocity or Vector(0, 0)
   self.size     = t.size     or Vector(0, 0)

   self.hasBody    = t.hasBody
   self.filter     = t.filter
   self.isGrounded = false

   self.gravityScale       = t.gravityScale or 1
   self.groundFrictionCoef = 250
   self.airFrictionCoef    = 100
   self.epsilon            = 0.75

   self.quad = t.quad

   self.dynamic = t.dynamic

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

   if self.hasBody then
      self:removeBody()
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
      local nx, ny, cols, len = World:move(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.filter)
      self.position.x, self.position.y = nx + self.size.x/2, ny + self.size.y/2

      for i = 1, len do
         self:resolveCollision(cols[i])
      end
   end
end

function Object:applyGravity(dt)
   self.velocity:add(World.gravity * self.gravityScale * dt)
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
         if col.other.attached then
            col.other.attached[self] = true
         end
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
   if self.quad then
      local _, _, w, h = self.quad:getViewport()
      Batch.draw(self.quad, self.position.x, self.position.y, nil, nil, nil, w/2, h/2)
   end
end

return Object
