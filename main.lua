love.graphics.setDefaultFilter("nearest", "nearest")

local Fluid = require("lib.fluid").init({
   useEvents = true
})
local Vector = require("lib.vector")

local C = require("src.components")
local S = require("src.systems")

local Game = require("src.instances.game")
Fluid.addInstance(Game)

Game:addSystem(S.physics(), "update")

Game:addSystem(S.spriteRenderer(), "draw")

local Cube = Fluid.entity()
:give(C.transform, Vector(100, 100))
:give(C.sprite, love.graphics.newImage("assets/cube.png"))
:give(C.body, Vector(0, 0))

Game:addEntity(Cube)
