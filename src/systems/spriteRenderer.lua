local Fluid  = require("lib.fluid")
local Camera = require("lib.camera")

local C = require("src.components")

local SpriteRenderer = Fluid.system({C.transform, C.sprite})

local function newLayer(atlas, maxSprites)
   local layer = {
      batch = love.graphics.newSpriteBatch(atlas, maxSprites),
      open  = {},
   }

   for i = 1, maxSprites do
      layer.open[i] = layer.batch:add(nil, nil, nil, 0, 0)
   end

   return layer
end

function SpriteRenderer:init()
   self.atlas = love.graphics.newImage("assets/tileset.png")
   self.open  = {}

   self.layers = {
      background = newLayer(self.atlas, 10000),
      props      = newLayer(self.atlas, 500),
      entities   = newLayer(self.atlas, 100),
   }
   self.layers[1] = self.layers.background
   self.layers[2] = self.layers.props
   self.layers[3] = self.layers.entities

   self.camera = Camera.new()
   self.buffer = love.graphics.newCanvas(love.graphics.getDimensions())
   self.shader = love.graphics.newShader("assets/shader.frag")

   self.target = nil

   self.camera:zoomTo(1)


   self.shader:send("width", 1)
   self.shader:send("phase", 0)
   self.shader:send("thickness", 1)
   self.shader:send("opacity", 0.6)
   self.shader:send("color", {0, 0, 0})
   self.shader:send("direction", {1 / love.graphics.getWidth(), 2 / love.graphics.getHeight()})
end

function SpriteRenderer:entityAdded(e)
   local transform = e:get(C.transform)
   local sprite    = e:get(C.sprite)

   local layer = self.layers[sprite.layer]

   for i, quad in ipairs(sprite.quads) do
      local position = transform.position + quad[2]
      local origin   = sprite.origins[i]
      local id       = #layer.open

      sprite.ids[i] = id
      layer.batch:set(id, quad[1], position.x, position.y, nil, nil, nil, origin.x, origin.y)

      layer.open[id] = nil
   end
end

function SpriteRenderer:entityRemoved(e)
   local transform = e:get(C.transform)
   local sprite    = e:get(C.sprite)

   local layer = self.layers[sprite.layer]

   for _, id in ipairs(sprite.ids) do
      layer.batch:set(id, nil, nil, nil, 0, 0)
      layer.open[#layer.open + 1] = id
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

   love.graphics.setColor(255, 255, 255)

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite)

      local layer = self.layers[sprite.layer]

      for i, quad in ipairs(sprite.quads) do
         local position = transform.position + quad[2]
         local origin   = sprite.origins[i]
         local id       = sprite.ids[i]

         layer.batch:set(id, quad[1], position.x, position.y, nil, nil, nil, origin.x, origin.y)
      end
   end

   love.graphics.setCanvas(self.buffer)
      love.graphics.clear(love.graphics.getBackgroundColor())

      self.camera:attach()
         for _, layer in ipairs(self.layers) do
            love.graphics.draw(layer.batch)
         end
      self.camera:detach()
   love.graphics.setCanvas()

   love.graphics.setShader(self.shader)
   love.graphics.setBlendMode("alpha", "premultiplied")
   love.graphics.draw(self.buffer)
   love.graphics.setBlendMode("alpha")
   love.graphics.setShader()
end

return SpriteRenderer
