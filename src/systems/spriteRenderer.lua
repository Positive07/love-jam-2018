local Fluid = require("lib.fluid")

local C = require("src.components")

local SpriteRenderer = Fluid.system({C.transform, C.sprite})
function SpriteRenderer:init()
   self.atlas = love.graphics.newImage("assets/tileset.png")
   self.batch = love.graphics.newSpriteBatch(self.atlas, 10000)

   --self.camera =
   --self.shader =

   self.open = {}

   for i = 1, 10000 do
      self.batch:add(nil, nil, nil, 0, 0)
      self.open[i] = i
   end
end

function SpriteRenderer:entityAdded(e)
   local sprite = e:get(C.sprite)

   sprite.id = self.open[#self.open]
   self.open[#self.open] = nil
end

function SpriteRenderer:entityRemoved()
   local sprite = e:get(C.sprite)

   self.open[#self.open + 1] = sprite.id
   self.batch:set(sprite.id, nil, nil, nil, 0, 0)
end


local function sort(a, b)
   return a:get(C.sprite).layer < b:get(C.sprite).layer
end

function SpriteRenderer:draw()
   table.sort(self.pool, sort)

   love.graphics.setColor(255, 255, 255)

   local e
   for i = 1, self.pool.size do
      local e = self.pool:get(i)

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite)

      self.batch:set(sprite.id, sprite.quad, transform.position.x, transform.position.y, nil, nil, nil, sprite.origin.x, sprite.origin.y)
   end

   love.graphics.draw(self.batch)
end

return SpriteRenderer
