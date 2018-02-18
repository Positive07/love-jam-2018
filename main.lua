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
--Game:addSystem(collision, "draw")

local Cube = Fluid.entity()
:give(C.transform, Vector(10, 10), Vector(48, 48))
:give(C.sprite, "entities", {
   {Quads.cube, Vector(0, 0)},
})
:give(C.body, Vector(0, 0), nil, nil, 0)
:give(C.collider)
:give(C.moveOnBeat, Vector.right)

Game:addEntity(Cube)

local Floor = Fluid.entity()
:give(C.transform, Vector(200, 500), Vector(48, 48))
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

Game:addEntity(Floor)

--[[
local Player = Fluid.entity()
:give(C.transform, Vector(200, 50), Vector(48, 48))
:give(C.sprite, {{quad = Quads.cube, offset = Vector(24, 24), layer = 3}})
:give(C.body, Vector(0, 0), nil, nil, 1)
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
:give(C.inputResponse) --basicResponses
:give(C.moveSpeed, 300)
:give(C.jumpForce, 400)

Game:addEntity(Player)
]]
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
