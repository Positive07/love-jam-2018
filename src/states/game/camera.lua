local Camera = require("libs.camera")
local camera = Camera(love.graphics.getWidth(), love.graphics.getHeight(), true)
camera:setViewport(360, 640)

return camera
