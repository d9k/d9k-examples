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

-- crashes crashes on argparse module require, so disabled
-- require 'patch_strings'
lib = require 'lib'

local argparse = require "argparse"

local parser = argparse(
  script_name, -- name
  "transforms birthday to binary according to bibit task rules", -- description
  "Example:\n   "..script_name.." 1001010101001110", -- epilog
  "" --usage (TODO why not working?)
)
parser:argument("binary_number")
parser:flag("-d --debug", "debugmode switch")

local args = parser:parse()
if debug_mode then lib.print_r(args) end

local binary_number = args.binary_number
debug_mode = args.debug

if debug_mode then print("binary_number ="); lib.print_r(binary_number) end

binary_array = binary_number
triangle = lib.to_triangle(binary_array)
if debug_mode then
  print("triangle ="); lib.print_r(triangle)
  print()
  print('triangle render: ')
  print(lib.triangle_render(triangle))
  print()
end

pyramid_tree = lib.to_pyramid_tree(triangle)
if debug_mode then lib.print_r(pyramid_tree) end

bibit = lib.bibit(pyramid_tree)
-- if debug_mode then lib.print_r(bibit) end
print(bibit)
