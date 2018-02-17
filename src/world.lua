local Bump   = require("libs.bump")
local Vector = require("libs.vector")

local World   = Bump.newWorld(96)
World.gravity = Vector(0, 1000)

return World
