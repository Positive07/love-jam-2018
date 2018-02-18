love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(255, 255, 255)

local Fluid = require("lib.fluid").init({
   useEvents = true
})
local Vector = require("lib.vector")

local Quads = require("src.quads")

local C = require("src.components")
local S = require("src.systems")

local Game = require("src.instances.game")
Fluid.addInstance(Game)

local collision      = S.collision()
local spriteRenderer = S.spriteRenderer()

Game:addSystem(S.physics(), "update")
Game:addSystem(collision, "update")
Game:addSystem(S.input(), "update")
Game:addSystem(S.onBeatMover("music/boss_song_1.wav", 140), "update")

Game:addSystem(spriteRenderer, "draw")
Game:addSystem(collision, "draw")

local Cube = Fluid.entity()
:give(C.transform, Vector(10, 200), Vector(48, 48))
:give(C.sprite, "entities", {
   {Quads.cube, Vector(0, 0)},
})
:give(C.body, Vector(0, 0), nil, nil, 0)
:give(C.collider)
:give(C.moveOnBeat, Vector.right)

Game:addEntity(Cube)

local Floor = Fluid.entity()
:give(C.transform, Vector(200, 500), Vector(80, 48))
:give(C.sprite, "background", {
   {Quads.breakable_top_left,     Vector(-32, -16)},
   {Quads.breakable_top,          Vector(-16, -16)},
   {Quads.breakable_top,          Vector(  0, -16)},
   {Quads.breakable_top,          Vector( 16, -16)},
   {Quads.breakable_top_right,    Vector( 32, -16)},

   {Quads.breakable_left,         Vector(-32, 0)},
   {Quads.breakable_middle,       Vector(-16, 0)},
   {Quads.breakable_middle,       Vector(  0, 0)},
   {Quads.breakable_middle,       Vector( 16, 0)},
   {Quads.breakable_right,        Vector( 32, 0)},

   {Quads.breakable_bottom_left,  Vector(-32, 16)},
   {Quads.breakable_bottom,       Vector(-16, 16)},
   {Quads.breakable_bottom,       Vector(  0, 16)},
   {Quads.breakable_bottom,       Vector( 16, 16)},
   {Quads.breakable_bottom_right, Vector( 32, 16)},
})
:give(C.collider)
Floor.name = "Floor"

Game:addEntity(Floor)

local q = {}
for x = -20, 20 do
   for y = -20, 20 do
      q[#q + 1] = {Quads.breakable_middle, Vector(x * 16, y * 16)}
   end
end

local Wall = Fluid.entity()
:give(C.transform, Vector(500, 500), Vector(80, 48))
:give(C.sprite, "background", q)
:give(C.collider)

Game:addEntity(Wall)

local Player = Fluid.entity()
:give(C.transform, Vector(200, 450), Vector(48, 48))
:give(C.sprite, "entities", {
   {Quads.cube, Vector(0, 0)},
})
:give(C.body, Vector(0, 0), 800, 200, 1)
:give(C.collider)
:give(C.controls, {
   controls = {
      left  = {'key:left', 'axis:leftx-', 'button:dpleft'},
      right = {'key:right', 'axis:leftx+', 'button:dpright'},
      jump  = {'key:up', 'key:space', 'axis:lefty-', 'button:dpup'},
      down  = {'key:down', 'axis:lefty+', 'button:dpdown'},
   },
   pairs = {
      move = {'left', 'right', 'jump', 'down'}
   },
   joystick = love.joystick.getJoysticks()[1],
})
:give(C.inputResponse)
:give(C.moveSpeed, 700)
:give(C.jumpForce, 600)
Player.name = "Player"

Game:addEntity(Player)

local Platform = Fluid.entity()
:give(C.transform, Vector(200, 400), Vector(16, 9))
:give(C.sprite, "entities", {
   {Quads.spike_up, Vector(0, 0)},
})
:give(C.body, Vector(0, 0), nil, nil, 0)
:give(C.collider, function(item, other)
   local body = other:get(C.body)

   if body.velocity.y > 0 then
      return "slide"
   end
end, function(col)
   if col.type == "slide" then
      local body = col.other:get(C.body)

      if body then
         if col.normal.x ~= 0 then
            body.velocity.x = 0
         end

         if col.normal.y ~= 0 then
            body.velocity.y = 0

            if col.normal.y == -1 then
               col.other:give(C.grounded, col.item)
            end
         end
      end
   end
end)
--:give(C.moveOnBeat, Vector.right)

Game:addEntity(Platform)

spriteRenderer.target = Player
--[[
local Falling = Fluid.entity()
:give(C.transform, Vector(100, -100), Vector(16, 16))
:give(C.sprite, Quads.breakable_middle)
:give(C.body, nil, nil, nil, 0.5)
:give(C.collider)
:give(C.trigger)

Game:addEntity(Falling)

local Response = Fluid.entity()
:give(C.transform, Vector(100, 200), Vector(16, 16))
:give(C.sprite, Quads.breakable_middle)
:give(C.collider, function()
   return nil
end)
:give(C.triggerable, function(e, other)
   e:get(C.transform).position.y = e:get(C.transform).position.y + 32
end)

Game:addEntity(Response)
]]
