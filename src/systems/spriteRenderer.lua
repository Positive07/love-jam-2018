local Fluid  = require("lib.fluid")
local Camera = require("lib.camera")

local C = require("src.components")

local SpriteRenderer = Fluid.system({C.transform, C.sprite})
function SpriteRenderer:init()
   self.atlas = love.graphics.newImage("assets/tileset.png")
   self.batch = love.graphics.newSpriteBatch(self.atlas, 10000)
   self.quads = {}

   self.dirty = false

   for _ = 1, 10000 do
      self.batch:add(nil, nil, nil, 0, 0)
   end

   self.camera = Camera.new()
   self.buffer = love.graphics.newCanvas(love.graphics.getDimensions())
   self.shader = love.graphics.newShader("assets/shader.frag")

   self.target = nil

   self.camera:zoomTo(2)

   self.shader:send("width", 1)
   self.shader:send("phase", 0)
   self.shader:send("thickness", 1)
   self.shader:send("opacity", 0.6)
   self.shader:send("color", {0, 0, 0})
   self.shader:send("direction", {1 / love.graphics.getWidth(), 2 / love.graphics.getHeight()})
end

function SpriteRenderer:entityAdded(e)
   local sprites = e:get(C.sprite).sprites

   for key, quad in ipairs(sprites) do
      table.insert(self.quads, {
         layer = quad.layer,
         key   = key,
         e     = e,
      })

      self.dirty = true
   end
end

function SpriteRenderer:entityRemoved(e)
   --This is a custom filtering code
   --It removes values from a list without changing it's order
   local j = 1
   local len = #self.quads
   local left = len

   for i = 1, len do
      if self.quads[i].e == e then
         --Reuse the id
         local id = self.quads[i].id
         table.insert(self.open, id)

         left = left - 1
      else
         --Move quad
         if j ~= i then
            self.quads[j] = self.quads[i]
         end
         j = j + 1
      end
   end

   --Delete repeated quads
   for i = left + 1, len do
      self.batch:set(i, nil, nil, nil, 0, 0)
      self.quads[i] = nil
   end
end


local function sort(a, b)
   return a.layer < b.layer
end

function SpriteRenderer:draw()
   if self.target then
      local transform = self.target:get(C.transform)

      if transform then
         self.camera:lookAt(transform.position.x, transform.position.y)
      end
   end

   if self.dirty then
      self.dirty = false
      table.sort(self.quads, sort)
   end

   love.graphics.setColor(255, 255, 255)

   for i, quad in ipairs(self.quads) do
      local e = quad.e

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite).sprites[quad.key]

      self.batch:set(
         i,
         sprite.quad,
         transform.position.x, transform.position.y,
         nil,
         sprite.flip and -1 or 1, 1,
         sprite.offset.x, sprite.offset.y
      )
   end

   love.graphics.setCanvas(self.buffer)
      love.graphics.clear(love.graphics.getBackgroundColor())

      self.camera:attach()
         love.graphics.draw(self.batch)
      self.camera:detach()
   love.graphics.setCanvas()

   love.graphics.setShader(self.shader)
   love.graphics.setBlendMode("alpha", "premultiplied")
   love.graphics.draw(self.buffer)
   love.graphics.setBlendMode("alpha")
   love.graphics.setShader()
end

return SpriteRenderer
