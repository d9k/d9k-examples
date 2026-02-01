#!/usr/bin/env lua5.2

-- loading init begin
-- TODO rewrite using repos examples

require 'luarocks.loader'

-- see https://stevedonovan.github.io/Penlight/api/libraries/pl.path.html
local pl_path = require 'pl.path'

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

-- print(script_path)

script_dir = pl_path.dirname(script_path)

package.path = script_dir..'/?.lua;'..package.path
package.cpath = script_dir..'/сmodules/?.dll;./сmodules/?.so;'..package.cpath

-- loading init end

lib = require 'lib'

-- Unit testing starts
luaunit = require('luaunit')

-- class
TestLib = {} 
  function TestLib:test_to_binary()
    luaunit.assertEquals( lib.to_binary(5), {1, 0, 1})
  end
  
  function TestLib:test_to_triangle()
    luaunit.assertEquals(
      lib.to_triangle({1, 0, 1, 1}),
      {{1}, {0, 1, 1}}
    )
    luaunit.assertEquals(
      lib.to_triangle("1011"),
      {{1}, {0, 1, 1}}
    )
    luaunit.assertEquals(
      lib.to_triangle({1, 0, 1, 1, 0 ,0, 1, 1, 0}),
      {{1}, {0, 1, 1}, {0, 0, 1, 1, 0}}
    )
    
    luaunit.assertEquals(
      lib.to_triangle({1, 0, 1, 1, 0 ,0, 1, 1, 0, 1, 0, 0, 1, 0}),
      {{1}, {0, 1, 1}, {0, 0, 1, 1, 0}}
    )
  end
  
  function TestLib:test_to_pyramid_tree()   
    -- local t = lib.to_pyramid_tree({0, 1, 1, 0})
        
    luaunit.assertEquals(
      lib.to_pyramid_tree(
        {
             {0},
          {1, 1, 0}
        }
      ), -- to_pyramid_tree call end
      '0110'
    )
    
--            ^
--           /1\
--          *---*
--         /0\0/1\
--        *---*---*
--       /1\0/1\1/0\
--      *---*---*---*
--     /0\1/1\1/0\0/1\
--    *---*---*---*---*    
    
    luaunit.assertEquals(
      lib.to_pyramid_tree(
        {
                   {1},
                {0, 0, 1},
             {1, 0, 1, 1, 0}, 
          {0, 1, 1, 1, 0, 0, 1}
        }
      ), -- to_pyramid_tree call end
      {
        '1001',
        '1011',
        '1011',
        '0001',
      }
    ) -- assert end
  end

  function TestLib:test_deepcopy()   
    -- local t = lib.to_pyramid_tree({0, 1, 1, 0})
        
    luaunit.assertEquals(
      lib.deepcopy(
        { {0},  {1, 1, 0} }
      ), -- deep_copy call end
      { {0},  {1, 1, 0} }
    )
    
    luaunit.assertEquals(lib.deepcopy(nil), nil)
  end
  
  function TestLib:test_pyramid_leaf_reducible()
    luaunit.assertEquals(
      lib.pyramid_leaf_reducible(
        { {0},  {1, 1, 0} }
      ), -- pyramid_leaf_reducible call end
      false
    )
    
    luaunit.assertEquals(lib.pyramid_leaf_reducible("0100"), false)
    luaunit.assertEquals(lib.pyramid_leaf_reducible(0), false)
    luaunit.assertEquals(lib.pyramid_leaf_reducible("000000"), false)
    luaunit.assertEquals(lib.pyramid_leaf_reducible("0000"), true)
  end
  
  function TestLib:test_pyramid_leaf_reduce()
    luaunit.assertEquals(
      lib.pyramid_leaf_reduce(
        { {0},  {1, 1, 0} }
      ), -- pyramid_leaf_reduce call end
      { {0},  {1, 1, 0} }
    )
    
    luaunit.assertEquals(lib.pyramid_leaf_reduce("0100"), "0100")
    luaunit.assertEquals(lib.pyramid_leaf_reduce("000000"), "000000")    
    luaunit.assertEquals(lib.pyramid_leaf_reduce("0000"), 0)    
  end
  
  function TestLib:test_tree_max_level()
    luaunit.assertEquals(
      lib.tree_max_level(
        { {0},  {1, 1, 0} }
      ), -- tree_max_level call end
      2
    )
    
    luaunit.assertEquals(lib.tree_max_level("0100"), 0)
    
    luaunit.assertEquals(
      lib.tree_max_level(
        { {0, 1},  {1, {0}} }
      ), -- tree_max_level call end
      3
    )
  end -- test_tree_max_level
  
  --function TestLib:test_pyramid_tree_to_triangle(pyramid_tree_part)
    -- TODO
  --end

  function TestLib:test_triangle_to_binary()
    luaunit.assertEquals(
      lib.triangle_to_binary({{1}, {0, 1, 1}}),
      {1, 0, 1, 1}
    )
    luaunit.assertEquals(
      lib.triangle_to_binary({{1}, {0, 1, 1}, {0, 0, 1, 1, 0}}),
      {1, 0, 1, 1, 0 ,0, 1, 1, 0}
    )
  end -- test_triangle_to_binary
  
  function TestLib:test_coords_to_indices()
    local y, x
    y,x = lib.coords_to_indices(2, 1)
    luaunit.assertEquals(x, 3)
    luaunit.assertEquals(y, 2)
    
    y, x = lib.coords_to_indices(4, -3)
    luaunit.assertEquals(x, 1)
    luaunit.assertEquals(y, 4)
  end -- test_coords_to_indices
  
  function TestLib:test_write_triangle_to_triangle()
    local big_triangle_template = {
               {0},
            {1, 0, 0},
         {1, 0, 0, 1, 0},
      {0, 1, 1, 0, 1, 0, 0}
    }
    
    luaunit.assertEquals(
      lib.write_triangle_to_triangle(
        lib.deepcopy(big_triangle_template),
        1, -- top
        {
             {1},
          {0, 1, 0}
        }
      ), {
                 {1},
              {0, 1, 0},
           {1, 0, 0, 1, 0},
        {0, 1, 1, 0, 1, 0, 0}
      }
    )
    
      luaunit.assertEquals(
        lib.write_triangle_to_triangle(
          lib.deepcopy(big_triangle_template),
          3, -- bottom
          {
               {1},
            {0, 1, 1}
          }
        ), {
                 {0},
              {1, 0, 0},
           {1, 0, 1, 1, 0},
        {0, 1, 1, 1, 1, 0, 0}
      }
    )
  end -- test_write_triangle_to_triangle

  function TestLib:test_pyramid_tree_to_triangle()
    luaunit.assertEquals(
      lib.pyramid_tree_to_triangle(
        '0110'
      ), -- pyramid_tree_to_triangle call end
      {
           {0},
        {1, 1, 0}
      }
    )
    
    luaunit.assertEquals(
      lib.pyramid_tree_to_triangle(
        {
          '1001',
          '1011',
          '1011',
          '0001',
        }
      ), -- pyramid_tree_to_triangle call end
        {
                   {1},
                {0, 0, 1},
             {1, 0, 1, 1, 0}, 
          {0, 1, 1, 1, 0, 0, 1}
        }
    ) -- assert end
  
  end -- test_pyramid_tree_to_triangle

  function TestLib:test_triangle_render()
    luaunit.assertEquals(
      lib.triangle_render(
        {
             {0},
          {1, 1, 0}
        }
      ), -- triangle_render call end
[[    ^
   /0\
  *---*
 /1\1/0\
*---*---*]]
    )
  end -- test_triangle_render
-- end class TestLib  

-- run all tests
os.exit (luaunit.LuaUnit.run())
