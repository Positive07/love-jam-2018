local Class  = require("libs.class")
local Vector = require("libs.vector")

local Object = require("src.classes.object")

local Player = Class("Player", Object)

function Player:initialize(t)
   t = t or {}

   t.size    = Vector(32, 32)
   t.hasBody = true
   t.dynamic = true

   Object.initialize(self, t)

   self.speed = 500
   self.jumpPower = 500
end

function Player:update(dt)
   if love.keyboard.isDown("w") and self.isGrounded then
      self.velocity:add(Vector.up * self.jumpPower)
   end

   if love.keyboard.isDown("a") then self.velocity:add(Vector.left  * self.speed * dt) end
   if love.keyboard.isDown("d") then self.velocity:add(Vector.right * self.speed * dt) end

   Object.update(self, dt)
end

function Player:keypressed(_, scancode)
end

return Player