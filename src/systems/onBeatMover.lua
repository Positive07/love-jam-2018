local Fluid = require("lib.fluid")
local Flux  = require("lib.flux")
local Wave  = require("lib.wave")

local C = require("src.components")

local OnBeatMover = Fluid.system({C.transform, C.moveOnBeat})

function OnBeatMover:init(track, bpm)
   self.flux = Flux.group()

   self.track = Wave:newSource(track, "static")
   self.track:setIntensity(20)
   self.track:setBPM(bpm / 2)

   self.track:setVolume(0)

   self.track:onBeat(function()
      local e
      for i = 1, self.pool.size do
         e = self.pool:get(i)

         local transform  = e:get(C.transform)
         local moveOnBeat = e:get(C.moveOnBeat)

         self.flux:to(transform.position, moveOnBeat.moveTime, {
            x = transform.position.x + moveOnBeat.direction.x * transform.size.x,
            y = transform.position.y + moveOnBeat.direction.y * transform.size.y,
         }):ease("quadout")
      end
   end)

   self.track:play()
end

function OnBeatMover:update(dt)
   self.flux:update(dt)
   self.track:update(dt)
end

return OnBeatMover
