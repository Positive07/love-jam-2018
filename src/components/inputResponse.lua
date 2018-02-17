local Fluid = require("lib.fluid")

local Body      = require("src.components.body")
local MoveSpeed = require("src.components.moveSpeed")
local JumpForce = require("src.components.jumpForce")
local Grounded  = require("src.components.grounded")

local defLeft = function(e, dt)
   local body      = e:get(Body)
   local moveSpeed = e:get(MoveSpeed)

   if body and moveSpeed then
      body.velocity.x = body.velocity.x - moveSpeed.speed * dt
   end
end

local defRight = function(e, dt)
   local body      = e:get(Body)
   local moveSpeed = e:get(MoveSpeed)

   if body and moveSpeed then
      body.velocity.x = body.velocity.x + moveSpeed.speed * dt
   end
end

local defJump = function(e, dt)
   local body      = e:get(Body)
   local jumpForce = e:get(JumpForce)
   local grounded  = e:get(Grounded)

   if body and jumpForce and grounded then
      body.velocity.y = -jumpForce.force
   end
end

local InputResponse = Fluid.component(function(e, left, right, jump)
   e.left  = left  or defLeft
   e.right = right or defRight
   e.jump  = jump  or defJump
end)

return InputResponse
