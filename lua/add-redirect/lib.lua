-- for debug
-- https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/

-- https://stevedonovan.github.io/Penlight/api/libraries/pl.path.html
local pl_path = require 'pl.path'

local lib = {}

function lib.print_r (t)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function lib.string_starts(String, Start)
   return string.sub(String,1,string.len(Start))==Start
end

function lib.string_ends(String, End)
   return string.sub(String, -string.len(End))==End
end

function lib.dirtree(dir)
  assert(dir and dir ~= "", "directory parameter is missing or empty")
  if string.sub(dir, -1) == "/" then
    dir=string.sub(dir, 1, -2)
  end

  local function yieldtree(dir)
    for entry in lfs.dir(dir) do
      if entry ~= "." and entry ~= ".." then
        entry=dir.."/"..entry
        local attr=lfs.attributes(entry)
        coroutine.yield(entry,attr)
        if attr.mode == "directory" then
          yieldtree(entry)
        end
      end
    end
  end

  return coroutine.wrap(function() yieldtree(dir) end)
end

function lib.file_get_contents(file_path)
    local f = io.open(file_path, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

function lib.file_put_contents(file_path, new_content)
    local f = io.open(file_path, "wb")
    a = f:write(new_content)
    f:close()
end

function lib.print_files_list(files_list, parent_folder)
 
    local parent_folder_len = string.len(parent_folder)
  
    for n, file_path in ipairs(files_list) do
        file_path_local = file_path
        if parent_folder then
            file_path_local = pl_path.relpath(file_path_local, parent_folder)
        end
        print('- '..file_path_local)
    end
end

return lib