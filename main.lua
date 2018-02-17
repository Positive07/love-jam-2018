love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(255, 255, 255)

local Fluid = require("lib.fluid").init({
   useEvents = true
})
local Vector = require("lib.vector")

local C = require("src.components")
local S = require("src.systems")

local Game = require("src.instances.game")
Fluid.addInstance(Game)

local collision = S.collision()

Game:addSystem(S.physics(), "update")
Game:addSystem(collision, "update")
Game:addSystem(S.input(), "update")
Game:addSystem(S.onBeatMover("music/boss_song_1.wav", 140), "update")

Game:addSystem(S.spriteRenderer(), "draw")
Game:addSystem(collision, "draw")

for i = 1, 20 do
   local Pattern = Fluid.entity()
   :give(C.transform, Vector(100 + i * 40, 100), Vector(32, 32))
   :give(C.sprite, love.graphics.newImage("assets/cube.png"))
   :give(C.body, Vector(0, 0), nil, nil, 1)
   :give(C.collider)

   Game:addEntity(Pattern)
end

local Cube = Fluid.entity()
:give(C.transform, Vector(10, 10), Vector(32, 32))
:give(C.sprite, love.graphics.newImage("assets/cube.png"))
:give(C.body, Vector(0, 0), nil, nil, 0)
:give(C.collider)
:give(C.moveOnBeat, Vector.right)

Game:addEntity(Cube)


local Floor = Fluid.entity()
:give(C.transform, Vector(200, 500), Vector(420, 32))
:give(C.sprite)
:give(C.collider)

Game:addEntity(Floor)

local Player = Fluid.entity()
:give(C.transform, Vector(200, 50), Vector(32, 32))
:give(C.sprite)
:give(C.body, Vector(0, 0), nil, nil, 1)
:give(C.collider)
:give(C.controls)
:give(C.inputResponse)
:give(C.moveSpeed, 300)
:give(C.jumpForce, 400)

Game:addEntity(Player)
