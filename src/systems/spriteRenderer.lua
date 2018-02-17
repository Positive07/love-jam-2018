local Fluid = require("lib.fluid")

local C = require("src.components")

local SpriteRenderer = Fluid.system({C.transform, C.sprite})
function SpriteRenderer:draw()
   local e
   for i = 1, self.pool.size do
      local e = self.pool:get(i)

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite)

      love.graphics.draw(sprite.quad, transform.position.x, transform.position.y, nil, nil, nil, sprite.origin.x, sprite.origin.y)
   end
end

return SpriteRenderer
