love.graphics.setDefaultFilter("nearest", "nearest")

local ScreenManager = require("libs.manager")

function love.load ()
   local states = require("src.states")

   ScreenManager.registerCallbacks()
   ScreenManager.init(states.game)
end
