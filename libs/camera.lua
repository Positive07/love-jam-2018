--[[
   Camera: Basic pixelart camera library <https://github.com/Positive07/love-jam-2018>

   MIT License - Copyright (c) 2018 Pablo A. Mayobre

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
]]
local class = require "libs.class"
local Camera = class "Camera"

function Camera:initialize (w, h, pixelperfect)
  self.w, self.h = w, h
  self.pixelPerfect = pixelperfect

  self.tx, self.ty = 0, 0
  self.scale = 1

  self.canvas = love.graphics.newCanvas(w, h)
  self.canvas:setFilter('nearest', 'nearest')
end

function Camera:setPosition (x, y)
  self.tx = math.floor(x)
  self.ty = math.floor(y)
end

function Camera:setViewport (w, h)
  self.scale = math.min(w/self.w, h/self.h)
  if self.pixelPerfect then
    self.scale = math.floor(self.scale)
  end

  self.x = math.floor((w - self.w * self.scale)/2)
  self.y = math.floor((h - self.h * self.scale)/2)
end

function Camera:renderTo (render, ...)
  love.graphics.push("all")
  love.graphics.setCanvas(self.canvas)

  love.graphics.translate(-self.tx, -self.ty)

  render(self.tx, self.ty, self.w, self.h, ...)

  love.graphics.pop()
end

function Camera:draw ()
  love.graphics.push("all")
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(self.canvas, self.x, self.y, 0, self.scale)
  love.graphics.pop()
end

function Camera:toWorld (x, y)
  x, y = x - self.x, y - self.y
  if x < 0 or y < 0 or x > self.w * self.scale or y > self.h * self.scale then
    return --The mouse is not over the world
  end

  x, y = x / self.scale, y /self.scale
  return x + self.tx, y + self.ty
end

function Camera:toScreen (x, y)
  x, y = x - self.tx, y - self.ty
  x, y = x * self.scale, y * self.scale
  return x + self.x, y + self.y
end

return Camera