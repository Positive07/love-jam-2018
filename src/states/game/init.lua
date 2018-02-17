local Vector = require("libs.vector")
local Wave   = require("libs.wave")

local World = require("src.world")
local Batch = require("src.states.game.batch")

local Object = require("src.classes.object")
local Player = require("src.classes.player")
local Cube   = require("src.classes.cube")

local player = Player({
   position = Vector(0, 0),
})

local cube = Cube({
   position = Vector(100, 200),
   size = Vector(48, 48),

   hasBody = true,
   dynamic = true,

   quad = Batch.quads["cube"],
})

for x = 1, 8 do
   for y = 1, 8 do
      Object({
         position = Vector(252 + (x * 32), 100 + (y * 32)),
         size = Vector(32, 32),

         quad = Batch.quads["pattern"],
         hasBody = true,
      })
   end
end

Object({
   position = Vector(0, 200),
   size = Vector(32, 16),

   quad = Batch.quads["pillar_top"],
   hasBody = true,
})

for i = 1, 10 do
   Object({
      position = Vector(0, 200 + i * 16),
      size = Vector(16, 16),

      quad = Batch.quads["pillar_mid"],
      hasBody = true,
   })
end

Object({
   position = Vector(0, 376),
   size = Vector(32, 16),

   quad = Batch.quads["pillar_bot"],
   hasBody = true,
})

for i = 1, 10 do
   Object({
      position = Vector(i * 32, 400),
      size = Vector(32, 32),

      quad = Batch.quads["pattern"],
      hasBody = true,
   })
end

local Game = {}

function Game:init()
   love.graphics.setBackgroundColor(30, 30, 30)

   Game.camera = require("src.states.game.camera")
   Game.camera:zoomTo(2)

   Game.flux = require("src.states.game.flux")

   Game.music = Wave:newSource("music/boss_song_1.wav", "static")
   Game.batch = require("src.states.game.batch")

   Game.music:setIntensity(20)
   Game.music:setVolume(0)
   Game.music:setBPM(70)
   Game.music:onBeat(function()
      cube:move()
   end)

   Game.music:play(true)
end

function Game:update(propagate, dt)
   for i = 1, Object.dyanmicList.size do
      Object.dyanmicList:get(i):update(dt)
   end

   Game.camera:lookAt(player.position.x, player.position.y)

   Game.flux:update(dt)
   Game.music:update(dt)

   propagate(dt)
end

function Game:draw(propagate)
   Game.camera:attach()
      love.graphics.setColor(255, 255, 255)
      for i = 1, Object.list.size do
         Object.list:get(i):draw()
      end

      Game.batch.render()

      love.graphics.setColor(225, 30, 30)
      local items, len = World:getItems()
      for i = 1, len do
         local x, y, w, h = World:getRect(items[i])
         love.graphics.rectangle("line", x, y, w, h)
      end
   Game.camera:detach()

   propagate()
end

return Game
