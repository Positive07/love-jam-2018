--[[
   ScreenManager v2.1.1: Screen/State Management for the LÖVE framework
   <https://github.com/rm-code/ScreenManager>

   Zlib License - Copyright (c) 2014 - 2017 Robert Machmer

   This software is provided 'as-is', without any express or implied
   warranty. In no event will the authors be held liable for any damages
   arising from the use of this software.

   Permission is granted to anyone to use this software for any purpose,
   including commercial applications, and to alter it and redistribute it
   freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
]]

---
-- The Manager library is a state manager at heart which allows some nifty
-- things, like stacking multiple screens on top of each other.
-- @module Manager
--
local Manager = {}

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local BAD_ARG = [[Bad argument #1 to '%s' (table expected, got %s)]]
local ACTION_POP = {action = 'pop'}

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

local stack

local changes = {}
local height = 0 --Stack height

-- ------------------------------------------------
-- Private Functions
-- ------------------------------------------------

---
-- Determines if a value is callable (function or table with a __call metamethod)
--
local isCallable = function(x)
   if type(x) == "function" then return true end
   local mt = getmetatable(x)
   return mt and mt.__call ~= nil
 end

---
-- Close and remove all screens from the stack.
--
local function clear()
   for i = #stack, 1, -1 do
      if isCallable(stack[i].close) then stack[i]:close() end
      stack[i] = nil
   end
end

---
-- Close and pop the current active state and activate the one beneath it
--
local function pop()
   -- Close the currently active screen.
   local old = Manager.peek()

   -- Remove the now inactive screen from the stack.
   stack[#stack] = nil

   -- Close the previous screen.
   if isCallable(old.close) then
      old:close()
   end

   -- Activate next screen on the stack.
   local current = Manager.peek()
   if isCallable(current.setActive) then
      current:setActive(true)
   end
end

---
-- Deactivate the current state, push a new state and initialize it
--
local function push(screen, args)
   local current = Manager.peek()

   if current and current.setActive then
      current:setActive(false)
   end

   -- Push the new screen onto the stack.
   stack[#stack + 1] = screen

   -- Create the new screen and initialise it.
   if isCallable(screen.init) then
      screen:init(unpack(args, 1, args.n))
   end
end

---
-- Delegates a callback to the stack, with the apropiate propagate function
-- callback is the callback name
-- args a table containing the event arguments
-- level is the level of the stack to delegate to (defaults to the top)
--
local function delegate(callback, level, a,b,c,d,e,f,g,h,i,j)
   level = level or #stack
   local state = stack[level]

   if not state or not isCallable(state[callback]) then return end

   local function propagate()
      return delegate(callback, level - 1, a,b,c,d,e,f,g,h,i,j)
   end

   return state[callback](state, propagate, a,b,c,d,e,f,g,h,i,j)
end

-- ------------------------------------------------
-- Public Functions
-- ------------------------------------------------

---
-- This function is used internally by the Manager library.
-- It performs all changes that have been added to the changes queue (FIFO) and
-- resets the queue afterwards.
-- @see push, pop, switch
--
function Manager.performChanges()
   for i=1, #changes do
      local change = changes[i]
      changes[i] = nil

      if change.action == 'pop' then
         pop()
      elseif change.action == 'switch' then
         clear()
         push(change.screen, change.args)
      elseif change.action == 'push' then
         push(change.screen, change.args)
      end
   end
end

---
-- Initialises the Manager library.
-- It sets up the stack table, the list of screens to use and then proceeds with
-- validating and switching to the initial screen.
-- @tparam table nscreens
--                 A table containing pointers to the different screen classes.
--                 The keys will are used to call a specific screen.
-- @tparam string screen
--                 The key of the first screen to push to the stack. Use the
--                 key under which the screen in question is stored in the
--                 nscreens table.
-- @tparam[opt] vararg ...
--                 Aditional arguments which will be passed to the new
--                 screen's init function.
--
function Manager.init(screen, ...)
   stack = {}
   Manager.switch(screen, ...)
   Manager.performChanges()
end

---
-- Switches to a screen.
-- Removes all screens from the stack, creates a new screen and switches to it.
-- Use this if you don't want to stack onto other screens.
-- @tparam string screen
--                 The key of the screen to switch to.
-- @tparam[opt] vararg ...
--                 One or multiple arguments passed to the new screen's init
--                 function.
--
function Manager.switch(screen, ...)
   if type(screen) ~= 'table' then
      error(BAD_ARG:format('Manager.switch', type(screen)), 2)
   end

   height = 1
   changes[#changes + 1] = {
      action = 'switch',
      screen = screen,
      args = {..., n = select('#', ...)}
   }
end

---
-- Pushes a new screen to the stack.
-- Creates a new screen and pushes it onto the stack, where it will overlay the
-- other screens below it. Screens below this new screen will be set inactive.
-- @tparam string screen
--                 The key of the screen to push to the stack.
-- @tparam[opt] vararg ...
--                 One or multiple arguments passed to the new screen's init
--                 function.
--
function Manager.push(screen, ...)
   if type(screen) ~= 'table' then
      error(BAD_ARG:format('Manager.push', type(screen)), 2)
   end

   height = height + 1
   changes[#changes + 1] = {
      action = 'push',
      screen = screen,
      args = {..., n = select('#', ...)}
   }
end

---
-- Returns the screen on top of the screen stack without removing it.
-- @treturn table
--                 The screen on top of the stack.
--
function Manager.peek()
   return stack[#stack]
end

---
-- Removes the topmost screen of the stack.
-- @raise Throws an error if the screen to pop is the last one on the stack.
--
function Manager.pop()
   if height > 1 then
      height = height - 1
      changes[#changes + 1] = ACTION_POP
   else
      error("Can't close the last screen. Use switch() to clear the screen manager and add a new screen.", 2)
   end
end

---
-- Publishes a message to all screens which have a public receive function.
-- @tparam string event A string by which the message can be identified.
-- @tparam varargs ...  Multiple parameters to push to the receiver.
--
function Manager.publish(event, ...)
   for i = 1, #stack do
      if stack[i].receive then
         stack[i]:receive(event, ...)
      end
   end
end

-- ------------------------------------------------
-- LOVE Callbacks
-- ------------------------------------------------

---
-- Register to multiple LÖVE callbacks, defaults to all.
-- @param callbacks (table) Table with the names of the callbacks to register to.
--
function Manager.registerCallbacks(callbacks)
   local function null() end

   if type(callbacks) ~= 'table' then
      callbacks = {'update', 'draw'}

      for name in pairs(love.handlers) do --luacheck: ignore
         callbacks[#callbacks + 1] = name
      end
   end

   for _, f in ipairs(callbacks) do
      local old = love[f] or null

      love[f] = function (...)
         old(...)
         delegate(f, ...)
         if f == 'draw' then Manager.performChanges() end
      end
   end
end

-- ------------------------------------------------
-- Return Module
-- ------------------------------------------------

return Manager
