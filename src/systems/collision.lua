local Fluid = require("lib.fluid")
local Bump  = require("lib.bump")

local C = require("src.components")

local Collider = Fluid.system({C.transform, C.collider})

function Collider:init()
   self.world = Bump.newWorld(64)
end

function Collider:update()
   local e
   for i = 1, self.pool.size do
      local e = self.pool:get(i)

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite)

      love.graphics.draw(sprite.quad, transform.position.x, transform.position.y, nil, nil, nil, sprite.origin.x, sprite.origin.y)
   end
end

return Collider
