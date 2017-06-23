#!/usr/bin/env lua5.2

require 'luarocks.loader'

local STP = require "StackTracePlus"

--debug.traceback = STP.stacktrace
function test1()
  local s = "this is a string"
  local n = 42
  local t = { foo = "bar" }
  local co = coroutine
  local cr = coroutine.create  
end

function test2()
  local s = "this is a string"
  local n = 42
  local t = { foo = "bar" }
  local co = coroutine
  local cr = coroutine.create
  
  error("an internal error")
end

function test_recursion1()
  status, ret = xpcall(test1, STP.stacktrace)
  if not status then
    print(ret)
  end
  error("an external error")
end

function test_recursion2()
  status, ret = xpcall(test2, STP.stacktrace)
  if not status then
    print(ret)
  end
end

status, ret = xpcall(test_recursion1, STP.stacktrace)
if not status then
  print(ret)
end

print("\n\n\n = = = = = = = = = = = = = = = = = = = =\n\n\n")

status, ret = xpcall(test_recursion2, STP.stacktrace)
if not status then
  print(ret)
end