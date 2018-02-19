local Quads = {}

local quad, sw, sh = love.graphics.newQuad, 512, 512

local corners = {
  '_top_left',    '_top',    '_top_right',
  '_left',        '_middle', '_right',
  '_bottom_left', '_bottom', '_bottom_right'
}
local function block (name, x, y)
  for i, corner in ipairs(corners) do
    local offx, offy = (i - 1) % 3, math.floor((i-1)/3)
    Quads[name..corner] = quad(x + offx * 16, y + offy * 16, 16, 16, sw, sh)
  end
end

local named = {
  [6] = 1, [14] = 2, [12] = 3,
  [7] = 4, [15] = 5, [13] = 6,
  [3] = 7, [11] = 8, [ 9] = 9
}

local function patch (name, x, y)
  for i=0, 15 do
    local n = name..'-'..i
    Quads[n] = quad(x + i * 16, y, 16, 16, sw, sh)
    if named[i] then
      Quads[name..corners[named[i]]] = Quads[n]
    end
  end
end

patch('platform',     0,  0)
patch('background',   0, 16)

block('metal',        0, 32)
block('breakable',   48, 32)
--block('fade_border', 96,  0)
--block('fade',        96, 48)

Quads["cube"]  = quad(96, 32, 48, 48, sw, sh)

Quads["light_1"] = quad(144,  32, 48, 48, sw, sh)
Quads["light_2"] = quad(192,  32, 48, 48, sw, sh)

Quads["spike_up"]    = quad( 0, 87, 16, 9, sw, sh)
Quads["spike_right"] = quad(16, 80, 9, 16, sw, sh)
Quads["spike_down"]  = quad(16, 96, 16, 9, sw, sh)
Quads["spike_left"]  = quad( 7, 96, 9, 16, sw, sh)

Quads["lantern"]     = quad(32, 80, 16, 32, sw, sh)
Quads["lantern_lit"] = quad(48, 80, 16, 32, sw, sh)

Quads['background_flower']        = quad(64,  80, 32, 32, sw, sh)
Quads['background_pillar_top']    = quad(64,  96, 32, 16, sw, sh)
Quads['background_pillar_middle'] = quad(64, 128, 32, 16, sw, sh)
Quads['background_pillar_bottom'] = quad(64, 144, 32, 16, sw, sh)

Quads['flower']        = quad(96,  80, 32, 32, sw, sh)
Quads['pillar_top']    = quad(96,  96, 32, 16, sw, sh)
Quads['pillar_middle'] = quad(96, 128, 32, 16, sw, sh)
Quads['pillar_bottom'] = quad(96, 144, 32, 16, sw, sh)

Quads["sign"]       = quad(128, 80, 16, 32, sw, sh)
Quads['none']       = quad(144, 80, 16, 16, sw, sh)
Quads["background"] = quad(144, 96, 16, 16, sw, sh)

Quads["arrow_left_lit"]  = quad( 0, 112, 16, 16, sw, sh)
Quads["arrow_down_lit"]  = quad( 0, 128, 16, 16, sw, sh)
Quads["arrow_right_lit"] = quad(16, 128, 16, 16, sw, sh)
Quads["arrow_up_lit"]    = quad(16, 112, 16, 16, sw, sh)

Quads["arrow_left"]  = quad(32, 112, 16, 16, sw, sh)
Quads["arrow_down"]  = quad(32, 128, 16, 16, sw, sh)
Quads["arrow_right"] = quad(48, 128, 16, 16, sw, sh)
Quads["arrow_up"]    = quad(48, 112, 16, 16, sw, sh)

Quads['glass_top']    = quad(128, 112, 16, 16, sw, sh)
Quads['glass_middle'] = quad(128, 128, 16, 16, sw, sh)
Quads['glass_bottom'] = quad(128, 144, 16, 16, sw, sh)

Quads['glass_top_broken']    = quad(144, 112, 16, 16, sw, sh)
Quads['glass_bottom_broken'] = quad(144, 144, 16, 16, sw, sh)

Quads['player_static_1'] = quad(160, 80, 20, 32, sw, sh)
Quads['player_static_2'] = quad(192, 80, 20, 32, sw, sh)
Quads['player_static_3'] = quad(224, 80, 20, 32, sw, sh)

Quads['player_transition_1'] = quad(160, 112, 20, 32, sw, sh)
Quads['player_transition_2'] = quad(192, 112, 20, 32, sw, sh)
Quads['player_transition_3'] = quad(224, 112, 20, 32, sw, sh)

Quads['player_run_1'] = quad(160, 144, 20, 32, sw, sh)
Quads['player_run_2'] = quad(192, 144, 20, 32, sw, sh)
Quads['player_run_3'] = quad(224, 144, 20, 32, sw, sh)

return Quads
