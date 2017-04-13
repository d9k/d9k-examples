#!env lua

refresh_tag = "<meta http-equiv=\"refresh\" content=\"0; url=http://pasekaglazova.ru\">"

require 'luarocks.loader'

-- https://keplerproject.github.io/luafilesystem/manual.html#reference
require 'lfs'
-- https://stevedonovan.github.io/Penlight/api/libraries/pl.path.html
local pl_path = require 'pl.path'
-- http://rrthomas.github.io/lrexlib/manual.html
pcre = require 'rex_pcre'

function get_script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

script_name = pl_path.basename(arg[0])
local debug_info = debug.getinfo(1,'S');
script_path = debug_info.source
if string.sub(script_path, 1, 1) == '@' then
    script_path = string.sub(script_path, 2)
end
script_path = pl_path.abspath(script_path)

print(script_path)

script_dir = pl_path.dirname(script_path)

package.path = script_dir..'/?.lua;'..package.path
package.cpath = script_dir..'/сmodules/?.dll;./сmodules/?.so;'..package.cpath

lib = require 'lib'

function usage()
    print('Usage: '..script_name..' path_to_folder')
end

local folder_to_process_path = arg[1]
if folder_to_process_path == nil then
    usage()
    os.exit()
end

folder_to_process_path = pl_path.abspath(folder_to_process_path)

print('Processing "'..folder_to_process_path..'"...')

local pattern_refresh = pcre.new("\"refresh\"")

files_with_refresh = {}
files_to_add_refresh = {}

for file_path in lib.dirtree(folder_to_process_path) do
  if not string.find(file_path, "/%.") and lib.string_ends(file_path, ".html") then
    file_contents = lib.file_get_contents(file_path)
    if pattern_refresh:find(file_contents) then
        -- print(file_path)
        table.insert(files_with_refresh, file_path)
    else
        table.insert(files_to_add_refresh, file_path)
    end
  end
end

print()
print("Pages with refresh:")
lib.print_files_list(files_with_refresh, folder_to_process_path)

print()
print("Pages to add refresh:")
lib.print_files_list(files_to_add_refresh, folder_to_process_path)

print()
io.write("Add redirect to the files above (y/n)?\n> ")
answer = io.read()
if answer ~= "y" then
    print('You choose not to continue...')
    os.exit()
end

print('Adding redirect...')

local pattern_head_begin = pcre.new("<head>")

for n, file_path in ipairs(files_to_add_refresh) do
    file_contents = lib.file_get_contents(file_path)

    file_contents = pcre.gsub(file_contents, pattern_head_begin, "<head>\n"..refresh_tag.."\n")
    lib.file_put_contents(file_path, file_contents)
end