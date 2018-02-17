local Class  = require("libs.class")
local Vector = require("libs.vector")

local Flux  = require("src.states.game.flux")
local World = require("src.world")

local Object = require("src.classes.object")

local Cube = Class("Cube", Object)

function Cube:initialize(t)
   t = t or {}

   t.size = t.size or Vector(64, 64)

   Object.initialize(self, t)

   self.moveSpeed = t.moveSpeed or 0.125
   self.direction = t.direction or Vector.up

   self.prefPos  = self.position:clone()
   self.attached = {}
end

function Cube:resolveCollision(col)
   --col.other:destroy() -- TODO Make this less destructive
end

function Cube:move()
   Flux:to(self.position, self.moveSpeed, {
      x = self.position.x + self.size.x * self.direction.x,
      y = self.position.y + self.size.y * self.direction.y}
   ):ease("quadout")
end

function Cube:update(dt)
   local nx, ny, cols, len = World:move(self, self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.filter)
   self.position.x, self.position.y = nx + self.size.x/2, ny + self.size.y/2

   for i = 1, len do
      self:resolveCollision(cols[i])
   end

   local delta = self.position:clone() - self.prefPos
   for other, _ in pairs(self.attached) do
      other.position:add(delta)
      self.attached[other] = nil
   end

   self.prefPos = self.position:clone()
end

return Cube
