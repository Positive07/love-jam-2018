local Game = {}

function Game:update(propagate, dt)

   propagate(dt)
end

function Game:draw(propagate)
   propagate()
end

return Game
