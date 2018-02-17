local Menu = {}

function Menu:update(propagate, dt)

   propagate(dt)
end

function Menu:draw(propagate)
   
   propagate()
end

return Menu
