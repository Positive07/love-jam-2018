local ScreenManager = require("libs.manager")

function love.load ()
   local screens = {
      menu = require("src.states.menu"),
      game = require("src.states.game"),
   }

   ScreenManager.registerCallbacks()
   ScreenManager.init(screens.game)
end
