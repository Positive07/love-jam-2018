local Vector = require("libs.vector")

local Object = require("src.classes.object")

Object({
   position = Vector(100, 100),
   size     = Vector(50, 50),
})

local Game = {}

function Game:update(propagate, dt)
   for i = 1, Object.dyanmicList.size do
      Object.dyanmicList:get(i):update(dt)
   end

   propagate(dt)
end

function Game:draw(propagate)
   for i = 1, Object.list.size do
      Object.list:get(i):draw()
   end


   propagate()
end

return Game
