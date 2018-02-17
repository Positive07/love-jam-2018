local Class  = require("libs.class")
local Vector = require("libs.vector")

local Object = require("src.classes.object")

local Cube = Class("Cube", Object)

function Cube:initialize(t)
   t = t or {}

   t.size = t.size or Vector(64, 64)

   Object.initialize(t)


end

function Cube:update(dt)

end

return Cube
