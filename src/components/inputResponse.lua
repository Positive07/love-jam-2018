local Fluid = require("lib.fluid")

local Body      = require("src.components.body")
local MoveSpeed = require("src.components.moveSpeed")
local JumpForce = require("src.components.jumpForce")
local Grounded  = require("src.components.grounded")

local defMove = function(e, x, y, dt)
   local body      = e:get(Body)
   local moveSpeed = e:get(MoveSpeed)

   if body and moveSpeed then
      body.velocity.x = body.velocity.x + moveSpeed.speed * x * dt
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

local InputResponse = Fluid.component(function(e, move, jump)
   e.move  = move or defMove
   e.jump  = jump or defJump
end)

return InputResponse
