#!/usr/bin/env lua5.2

-- run install.sh first!

-- loading init begin
-- TODO rewrite using repos examples
require 'luarocks.loader'

-- see https://stevedonovan.github.io/Penlight/api/libraries/pl.path.html
local pl_path = require 'pl.path'

script_path = debug.getinfo(1,'S').source
script_name = pl_path.basename (script_path)
if string.sub(script_path, 1, 1) == '@' then
    script_path = string.sub(script_path, 2)
end
script_path = pl_path.abspath(script_path)
script_dir = pl_path.dirname(script_path)
package.path = script_dir..'/?.lua;'..package.path
package.cpath = script_dir..'/сmodules/?.dll;'..script_dir..'./сmodules/?.so;'..package.cpath

-- loading init end

-- global
debug_mode = false

lib = require 'lib'

local argparse = require "argparse"

local parser = argparse(
  script_name, -- name (auto detect)
  "transforms birthday to binary according to bibit task rules", -- description
  "Example:\n   "..script_name.." 1992 5 25", -- epilog
  "" --usage (TODO why not working?)
)
parser:argument("year", "4 digits")
parser:argument("month", "2 digits")
parser:argument("day", "2 digits")
parser:flag("-d --debug", "debugmode switch")

local args = parser:parse()
if debug_mode then lib.print_r(args) end

local year = args.year
local month = args.month
local day = args.day

debug_mode = args.debug

local birthdate = os.time{year=year, month=month, day=day}

if debug_mode then print("birthdate =", birthdate) end
local birthdate_formatted = os.date("%m%d%y", birthdate)
if debug_mode then print("birthdate_formatted =", birthdate_formatted) end
local birthdate_halved = math.floor(tonumber(birthdate_formatted)/2)
if debug_mode then print("birthdate_halved =", birthdate_halved) end

local binary_array = lib.to_binary(birthdate_halved)
if debug_mode then print("binary_array ="); lib.print_r(binary_array) end
local result = table.concat(binary_array)
print(result)
