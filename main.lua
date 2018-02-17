love.graphics.setDefaultFilter("nearest", "nearest")

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

Game:addSystem(S.spriteRenderer(), "draw")
Game:addSystem(collision, "draw")

for i = 1, 20 do
   local Cube = Fluid.entity()
   :give(C.transform, Vector(100 + i * 40, 100), Vector(32, 32))
   :give(C.sprite, love.graphics.newImage("assets/cube.png"))
   :give(C.body, Vector(0, 0), nil, nil, 1/i)
   :give(C.collider)

   Game:addEntity(Cube)
end
