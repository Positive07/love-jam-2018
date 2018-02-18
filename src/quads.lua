local Quads = {}

local quad, sw, sh = love.graphics.newQuad, 512, 512

local corners = {
  '_top_left',    '_top',    '_top_right',
  '_left',        '_middle', '_right',
  '_bottom_left', '_bottom', '_bottom_right'
}
local function patch (name, x, y)
  for i, corner in ipairs(corners) do
    local offx, offy = (i - 1) % 3, math.floor(i/3)
    Quads[name..corner] = quad(x + offx * 16, y + offy * 16, 16, 16, sw, sh)
  end
end

patch('breakable',    0,  0)
patch('platform',    48,  0)
patch('metal',        0, 48)
patch('background',  48, 48)
patch('fade_border', 96,  0)
patch('fade',        96, 48)

Quads["cube"]  = quad(0, 96, 48, 48, sw, sh)

Quads["spike_up"]    = quad(144, 70, 16,  9, sw, sh)
Quads["spike_right"] = quad(160, 64,  9, 16, sw, sh)
Quads["spike_down"]  = quad(160, 80, 16,  9, sw, sh)
Quads["spike_left"]  = quad(151, 80,  9, 16, sw, sh)

Quads["lantern"]     = quad(130, 144, 16, 21, sw, sh)
Quads["lantern_lit"] = quad(146, 144, 16, 21, sw, sh)

Quads["light_1"] = quad(144,  0, 32, 32, sw, sh)
Quads["light_2"] = quad(144, 32, 32, 32, sw, sh)

Quads["background"] = quad(48, 96, 16, 16, sw, sh)

Quads["arrow_left_lit"]  = quad( 0, 144, 16, 16, sw, sh)
Quads["arrow_down_lit"]  = quad( 0, 160, 16, 16, sw, sh)
Quads["arrow_right_lit"] = quad(16, 160, 16, 16, sw, sh)
Quads["arrow_up_lit"]    = quad(16, 144, 16, 16, sw, sh)

Quads["arrow_left"]  = quad(32, 144, 16, 16, sw, sh)
Quads["arrow_down"]  = quad(32, 160, 16, 16, sw, sh)
Quads["arrow_right"] = quad(48, 160, 16, 16, sw, sh)
Quads["arrow_up"]    = quad(48, 144, 16, 16, sw, sh)

Quads['background_flower']        = quad(64, 96, 32, 32, sw, sh)
Quads['background_pillar_top']    = quad(64, 128, 32, 16, sw, sh)
Quads['background_pillar_middle'] = quad(64, 144, 32, 16, sw, sh)
Quads['background_pillar_bottom'] = quad(64, 160, 32, 16, sw, sh)

Quads['flower']        = quad(96,  96, 32, 32, sw, sh)
Quads['pillar_top']    = quad(96, 128, 32, 16, sw, sh)
Quads['pillar_middle'] = quad(96, 144, 32, 16, sw, sh)
Quads['pillar_bottom'] = quad(96, 160, 32, 16, sw, sh)

Quads['glass_top']    = quad(144,  96, 16, 16, sw, sh)
Quads['glass_middle'] = quad(144, 112, 16, 16, sw, sh)
Quads['glass_bottom'] = quad(144, 128, 16, 16, sw, sh)

Quads['glass_top_broken']    = quad(128,  96, 16, 16, sw, sh)
Quads['glass_bottom_broken'] = quad(128, 128, 16, 16, sw, sh)

Quads['player_static_1'] = quad(176, 0, 20, 32, sw, sh)
Quads['player_static_2'] = quad(208, 0, 20, 32, sw, sh)
Quads['player_static_3'] = quad(240, 0, 20, 32, sw, sh)

Quads['player_transition_1'] = quad(176, 32, 20, 32, sw, sh)
Quads['player_transition_2'] = quad(208, 32, 20, 32, sw, sh)
Quads['player_transition_3'] = quad(240, 32, 20, 32, sw, sh)

Quads['player_run_1'] = quad(176, 64, 20, 32, sw, sh)
Quads['player_run_2'] = quad(208, 64, 20, 32, sw, sh)
Quads['player_run_3'] = quad(240, 64, 20, 32, sw, sh)

return Quads
