-- fix strings indexing
-- see http://lua-users.org/wiki/StringIndexing
-- Upd: crashes crashes on argparse module require, so disabled
getmetatable('').__index = function(str,i) return string.sub(str,i,i) end
getmetatable('').__call = function(str,i,j)  
  if type(i)~='table' then return string.sub(str,i,j) 
    else local t={} 
    for k,v in ipairs(i) do t[k]=string.sub(str,v,v) end
    return table.concat(t)
    end
  end