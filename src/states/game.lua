local Vector = require("libs.vector")

local World = require("src.world")

local Object = require("src.classes.object")

Object({
   position = Vector(100, 100),
   velocity = Vector(20, 20),
   size     = Vector(64, 64),

   hasBody = true,
   dynamic = true,

   sprite = love.graphics.newImage("assets/cube.png"),
})

Object({
   position = Vector(100, 400),
   velocity = Vector(0, 0),
   size     = Vector(300, 50),

   hasBody = true,
   dynamic = false,
})

local Game = {}

function Game:init()
   love.graphics.setBackgroundColor(225, 225, 225)
end

function Game:update(propagate, dt)
   for i = 1, Object.dyanmicList.size do
      Object.dyanmicList:get(i):update(dt)
   end

   propagate(dt)
end

function Game:draw(propagate)
   love.graphics.setColor(255, 255, 255)
   for i = 1, Object.list.size do
      Object.list:get(i):draw()
   end

   love.graphics.setColor(225, 30, 30)
   local items, len = World:getItems()
   for i = 1, len do
      local x, y, w, h = World:getRect(items[i])
      --love.graphics.rectangle("line", x, y, w, h)
   end

   propagate()
end

return Game
