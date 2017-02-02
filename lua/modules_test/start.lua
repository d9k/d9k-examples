#!/usr/bin/env lua5.2

-- tutorial from http://ilovelua.narod.ru/about_lua.html#OOP_modules

package.path = './luamodules/?.lua;'..package.path
package.cpath = './сmodules/?.dll;./сmodules/?.so;'..package.cpath

print("package.path="..package.path)
print("package.cpath="..package.cpath)

require('Base')
require('Child')

print()

local base = Base.new()
print(base:getField())
base:setField(1)
print(base:getField())

local child = Child.new(1, 2)
-- see watches:
--
-- getmetatable(child) 
-- > {__index = {_NAME="Child", ...}}
--
-- getmetatable(getmetatable(child).__index)
-- > {__index = {_NAME="Base", ...}}
print(child.getField())
child:setField(1)
print(child:getField())