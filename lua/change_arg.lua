#!env lua

local pretty_format = require 'inspect'


local f = function(a, b, s)
  a = 4
  b.c = 2
  s = 'dooper'
end

local a = 5
local b = {c = 14, d = 6}
local s = 'super'

f(a, b)

print('a: '..a)
print('b: '..pretty_format(b))
print('s: '..s)

--[[ result:

a: 5 -- unchanged
b: { -- passed by referense, changed
  c = 2,
  d = 6
}
s: super

--]]
