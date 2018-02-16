uniform float width;
uniform float phase;
uniform float thickness;
uniform float opacity;
uniform vec3 color;
uniform vec2 direction;

vec4 effect(vec4 c, Image texture, vec2 tex_coords, vec2 screen_coords) {
  float v = .5*(sin(tex_coords.y * 3.14159 / width * love_ScreenSize.y + phase) + 1.);

  c *= vec4(
    Texel(texture, tex_coords - direction).r,
    Texel(texture, tex_coords).g,
    Texel(texture, tex_coords + direction).b,
    1.0
  );

  //c.rgb = mix(color, c.rgb, mix(1, pow(v, thickness), opacity));
  c.rgb -= (color - c.rgb) * (pow(v,thickness) - 1.0) * opacity;
  return c
}