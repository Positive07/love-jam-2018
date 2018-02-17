local Class  = require("libs.class")
local Vector = require("libs.vector")

local Flux  = require("src.states.game.flux")
local World = require("src.world")

local Object = require("src.classes.object")

local Cube = Class("Cube", Object)

function Cube:initialize(t)
   t = t or {}

   t.size = t.size or Vector(64, 64)

   self.maxTimeMove  = t.maxTimeMove or 2
   self.timeLeftMove = self.maxTimeMove
   self.moveSpeed    = t.moveSpeed or 0.125
   self.direction    = t.direction or Vector.right

   Object.initialize(self, t)
end

function Cube:move()
   Flux:to(self.position, self.moveSpeed, {x = self.position.x + self.size.x * self.direction.x, y = self.position.y + self.size.y * self.direction.y}):ease("quadout")
end

function Cube:update(dt)
   --[[
   self.timeLeftMove = self.timeLeftMove - dt

   if self.timeLeftMove <= 0 then
      self:move()
      self.timeLeftMove = self.maxTimeMove
   end
   ]]

   local nx, ny, cols, len = World:move(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.filter)
   self.position.x, self.position.y = nx + self.size.x/2, ny + self.size.y/2

   for i = 1, len do
      self:resolveCollision(cols[i])
   end
end

return Cube
