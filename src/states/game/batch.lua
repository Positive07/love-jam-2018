local Batch = {
   batch = love.graphics.newSpriteBatch(love.graphics.newImage("assets/tileset.png"), 10000)
}

function Batch.draw(id, ...)
   if not id then
      id = Batch.batch:add(...)
   else
      Batch.batch:set(id, ...)
   end

   return id
end

function Batch.render()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.draw(Batch.batch)
end

return Batch
