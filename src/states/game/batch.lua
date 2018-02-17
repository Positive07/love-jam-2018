local Batch = {
   tileset = love.graphics.newImage("assets/tileset.png")
}
Batch.batch = love.graphics.newSpriteBatch(Batch.tileset, 10000)

function buildQuads()
   local quads = {}

   local sw, sh = Batch.tileset:getDimensions()

   -- Pattern
   quads["pattern"] = love.graphics.newQuad(0, 0, 32, 32, sw, sh)

   -- Pillar
   quads["pillar_top"] = love.graphics.newQuad(0, 32, 32, 16, sw, sh)
   quads["pillar_mid"] = love.graphics.newQuad(0, 48, 32, 16, sw, sh)
   quads["pillar_bot"] = love.graphics.newQuad(0, 64, 32, 16, sw, sh)

   -- Cube
   quads["cube"] = love.graphics.newQuad(0, 80, 48, 48, sw, sh)

   -- Tiles
   for y = 0, 3 do
      for x = 0, 5 do
         local i = (y * 6 + x + 1)
         local x = (x * 16) + 32
         local y = (y * 16)

         quads["tile_"..i] = love.graphics.newQuad(x, y, 16, 16, sw, sh)
      end
   end

   Batch.quads = quads
end
buildQuads()

function Batch.draw(...)
   Batch.batch:add(...)
end

function Batch.render()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.draw(Batch.batch)

   Batch.batch:clear()
end

return Batch
