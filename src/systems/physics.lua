local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local C = require("src.components")

local Physics = Fluid.system({C.transform, C.body})

function Physics:init(gravity)
   self.gravity = gravity or Vector(0, 1000)
   self.epsilon = 0.5
end

function Physics:update(dt)
   local e
   for i = 1, self.pool.size do
      local e = self.pool:get(i)

      local transform = e:get(C.transform)
      local body      = e:get(C.body)

      -- Gravity
      body.velocity:add(self.gravity * body.gravityScale * dt)

      -- Air friction
      local friction = body.velocity:clone()
      friction:mul(-1)
      friction:normalizeInplace()
      friction:mul(body.airCoef)
      friction:mul(dt)
      body.velocity:add(friction)

      -- Ground friction
      if e:has(C.grounded) then
         local friction = body.velocity.x
         friction = friction - 1
         friction = friction * body.groundCoef
         friction = friction * dt

         body.velocity.x = v.velocity.x - friction * dt
      end

      -- Clamping
      if body.velocity.x > -self.epsilon and body.velocity.x < self.epsilon then
         body.velocity.x = 0
      end

      -- Movement
      transform.position:add(body.velocity * dt)
   end
end

return Physics
