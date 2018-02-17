local Fluid = require("lib.fluid")

local Body      = require("src.components.body")
local MoveSpeed = require("src.components.moveSpeed")
local JumpForce = require("src.components.jumpForce")
local Grounded  = require("src.components.grounded")

local basicResponses = {}

function basicResponses.move (e, input, dt)
   local body      = e:get(Body)
   local moveSpeed = e:get(MoveSpeed)

   if body and moveSpeed then
      local multiplier = input:get('move') * dt
      body.velocity.x = body.velocity.x + moveSpeed.speed * multiplier
   end
end

function basicResponses.jump (e, input, _) --dt
   local body      = e:get(Body)
   local jumpForce = e:get(JumpForce)
   local grounded  = e:get(Grounded)

   if body and jumpForce and grounded  then
      if input:down('jump') then
         body.velocity.y = -jumpForce.force
      end
   end
end

local InputResponse = Fluid.component(function(e, responses)
   for action, response in pairs(responses or basicResponses) do
      e[action] = response
   end
end)

return InputResponse
