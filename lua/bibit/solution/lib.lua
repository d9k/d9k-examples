---
-- see related module tests at test-lib.lua
-- @module bibit.lib

local lib = {}

--- for debug output
-- (got from this [tutorial at coronalabs](https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents))
-- @tparam any t any object
--
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


--- with help of [stackoverflow: print integer as binary](http://stackoverflow.com/questions/9079853/lua-print-integer-as-a-binary)
-- @tparam int number  input
-- @treturn {int,...} table of integers (0 or 1 each)
-- 
function lib.to_binary(number)
  local result = {}
  -- frexp: number = multiplier * 2 ^ power
  local multiplier, power = math.frexp(number)
  local bits_count = math.max(1, power)
  -- for: begin, end, step
  for bit_index = bits_count, 1, -1 do
    local rest = math.fmod(number, 2)
    result[bit_index] = rest
    number = bit32.rshift(number-rest, 1)
  end
  return result
end -- lib.to_binary

---
-- Converts binary array to triangle table. First row of resulting table has one int element.
-- Each subsequent row has elements quantity bigger by 2.
--
-- @tparam {int,...}|string binary_array
-- @treturn {{int,...},...} table of tables of int. Inner tables are triangle's rows
--
function lib.to_triangle(binary_array)
  local triangle = {}
  local row = {}
  local row_end = 1
  local pos
  local is_string = type(binary_array) == "string"
  for pos = 1, #binary_array do
    if is_string then
      element = tonumber(string.sub(binary_array, pos, pos))
    else -- array
      element = binary_array[pos]
    end -- type binary_array if switch
    table.insert(row, element)
    
    if #row >= row_end then
      table.insert(triangle, row)
      row = {}
      row_end = row_end + 2
    end -- last row
  end -- pos
  return triangle
end -- lib.to_triangle

---
-- @tparam int y
-- @tparam int x
-- @treturn int y index
-- @treturn int x index
function lib.coords_to_indices(y_coord, x_coord)
  return y_coord, x_coord + y_coord
end


-- get element from triangle with `x` coordinate transformation
--
--            ^                              ^ 
--           / \                            / \ 
--          /   \                          /   \ 
--         / 0,1 \                        / 1,1 \
--        *-------*      ------->        *-------*
--       / \ 0,2 / \                    / \ 2,2 / \ 
--      /   \   /   \                  /   \   /   \
--     /-1,2 \ / 1,2 \                / 1,2 \ / 3,2 \
--    *-------*-------*              *-------*-------*
--
-- @tparam {{int,...},...} triangle
-- @tparam int y is just a row number
-- @tparam int x is x coordinate. first row has `[0: 0]` available `x` coordinates, second `[-1; 1]`, third `[-2; 2]` and so on
-- @treturn int requested triangle element
function lib.triangle_get_element(triangle, y_coord, x_coord)
  local y_index, x_index = lib.coords_to_indices(y_coord, x_coord)
  
  return triangle[y_index][x_index]
end


function lib.triangle_put_element(triangle, y_coord, x_coord, value)
  local y_index, x_index = lib.coords_to_indices(y_coord, x_coord)
  
  if triangle[y_index] == nil then
    triangle[y_index] = {}
  end

  triangle[y_index][x_index] = value
end

---
-- Function converts triangle table to pyramid table. Each pyramid tree level has 4 children elements:
-- 
--        ^
--       /1\      <-- first row
--      *---*
--     /2\3/4\    <-- second row
--    *---*---*
--
-- If triangle is inverted (`top_y > bottom_y`; `y` axis goes from top to bottom):
--
--    *---*---*
--     \2/3\4/    <-- second row
--      *---*
--       \1/      <-- first row
--        *
--
--
-- x coordinate: `[-(line_num-1); line_num-1]`, where line_num is `y`. See coords.svg, divide.svg for explanation
--
-- @tparam {{int,...},...} triangle big triangle table consisted of rows of integer
-- @tparam int top_x
-- @tparam int top_y `>= 1` and `<= triangle height`
-- @tparam int bottom_y can be `< top_x` so triangle would be inverted
--
-- @treturn {{int|string|table,...},...}
--
function lib.to_pyramid_tree(triangle, top_x, top_y, bottom_y)
  local result = {}
  -- default params values:
  top_x = top_x or 0
  top_y = top_y or 1
  bottom_y = bottom_y or #triangle
  
  local inverted = top_y > bottom_y  

  local true_top_y = math.min(top_y, bottom_y)
  local true_bottom_y = math.max(top_y, bottom_y)
  
  local height = math.abs(bottom_y - top_y) + 1
  
  -- calculating new triangles rows
  local row1_top = true_top_y
  local row1_bottom = math.floor((top_y + bottom_y) / 2)
  local row2_top = row1_bottom + 1
  local row2_bottom = true_bottom_y

  if inverted then -- swap rows
    row1_top, row1_bottom, row2_top, row2_bottom = row2_bottom, row2_top, row1_bottom, row1_top
  end

  local new_height = math.floor(height/2)
  local x_delta = new_height
    
  if height <= 2 then
    result = ""
    result = result .. tostring(lib.triangle_get_element(triangle, row1_top, top_x))
    result = result .. tostring(lib.triangle_get_element(triangle, row2_bottom, top_x - x_delta))
    result = result .. tostring(lib.triangle_get_element(triangle, row2_bottom, top_x))
    result = result .. tostring(lib.triangle_get_element(triangle, row2_bottom, top_x + x_delta))
  else -- (height > 2) => go recursive
    result[1] = lib.to_pyramid_tree(triangle, top_x, row1_top, row1_bottom)
    result[2] = lib.to_pyramid_tree(triangle, top_x - x_delta, row2_top, row2_bottom)
    result[3] = lib.to_pyramid_tree(triangle, top_x, row2_bottom, row2_top)
    result[4] = lib.to_pyramid_tree(triangle, top_x + x_delta, row2_top, row2_bottom)
  end -- height

  return result
  
end -- lib.to_pyramid_tree


---
-- from [lua-users CopyTable page](http://lua-users.org/wiki/CopyTable )
-- @tparam table orig
-- @treturn table copied table
--
function lib.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[lib.deepcopy(orig_key)] = lib.deepcopy(orig_value)
        end
        setmetatable(copy, lib.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


local bibit_mutations = {
  ['0000'] = '0000',
  ['0001'] = '1000',
  ['0010'] = '0001',
  ['0011'] = '0010',
  ['0100'] = '0000',
  ['0101'] = '0010',
  ['0110'] = '1011',
  ['0111'] = '1011',
  ['1000'] = '0100',
  ['1001'] = '0101',
  ['1010'] = '0111',
  ['1011'] = '1111',
  ['1100'] = '1101',
  ['1101'] = '1110',
  ['1110'] = '0111',
  ['1111'] = '1111',
}

---
-- @tparam string pyramid_leaf
-- @treturn bool
--
function lib.pyramid_leaf_reducible(pyramid_leaf)
  return type(pyramid_leaf) == 'string' and (pyramid_leaf == '0000' or pyramid_leaf == '1111')
end

---
-- @tparam string pyramid_leaf
-- @treturn string|int reduced leaf
--
function lib.pyramid_leaf_reduce(pyramid_leaf)
    if pyramid_leaf == '1111' then
      return 1
    end -- if 1111
    if pyramid_leaf == '0000' then
      return 0
    end -- if 0000
    -- no reduce found:
    return pyramid_leaf
end

---
-- One iteration of bibit checksum count algorithm
--
-- @tparam {{int|string|table,...},...} pyramid_tree_part pyramid tree or it's part
-- @treturn {{int|string|table,...},...} pyramid_tree_part after bibit algorithm apply
-- 
function lib.bibit_step(pyramid_tree_part)
  local result = lib.deepcopy(pyramid_tree_part)
  
  if (type(result) == 'string') then
    local old_value = result
    local new_value = bibit_mutations[old_value]
    result = new_value
  else -- type(result) == 'table' begin
    for index=1, 4 do
      result[index] = lib.bibit_step(result[index])
    end -- for index
  end -- type(result) == 'table' end
  
  return result
end

---
-- @tparam table pyramid_tree_part
--
-- @treturn bool reducible
function lib.pyramid_reducible(pyramid)
  if (type(pyramid) == 'string') then
    return lib.pyramid_leaf_reducible(pyramid)
  else -- table
    local result = true
    -- reducible if all children reducible
    for index = 1, 4 do
      result = result and lib.pyramid_reducible(pyramid[index])
    end -- for index
    
    return result
  end -- pyramid_tree_part type switch
end

function lib.pyramid_reduce(pyramid)
  if (type(pyramid) == 'string') then
    return lib.pyramid_leaf_reduce(pyramid)    
  else -- pyramid is table:
    local reduced_to_numbers = true
    for index=1, 4 do
      pyramid[index] = lib.pyramid_reduce(pyramid[index])
      reduced_to_numbers = reduced_to_numbers and type(pyramid[index]) == 'number'
    end -- for index
    
    if reduced_to_numbers then
      local result_string = ""
      for index=1, 4 do
        result_string = result_string .. pyramid[index]
      end
      return result_string
    else
      return pyramid
    end
    
  end -- pyramid type check
end

---
-- @tparam table trianglw
-- @treturn string
function lib.triangle_render(data_triangle)
  local height = #data_triangle
  local last_row = data_triangle[height]
  local max_row_length = #last_row
  local render_top_row_length = height * 2 + 1
  local render_bottom_row_length = height * 5 - (height - 1)
  
  local result = ""
  local render_height = height * 2 + 1
  
  for render_y = 1, render_height do
    -- local render_line_length =
    local render_left_border_x = render_top_row_length - (render_y - 1)
    local render_right_border_x = render_top_row_length + (render_y - 1)
    local render_data_begin = render_left_border_x + 1
    local render_data_end = render_right_border_x - 1
    
    local data_y = nil
    
    if math.fmod(render_y, 2) == 0 then
      data_y = math.floor(render_y / 2)
    end
    
    local open_dash = true -- "/" or "\" if false
    for render_x = 1, render_right_border_x do
      -- render data element
      
      local render_delta_since_data_begin = render_x - render_data_begin
      local render_delta_since_left_border_begin = render_x - render_left_border_x
      local data_x = nil
      
      if render_x >= render_data_begin
        and render_x <= render_data_end          
        and math.fmod(render_delta_since_data_begin, 2) == 0
      then
        data_x = math.floor(render_delta_since_data_begin/ 2) + 1  
      end
      
      if render_x < render_left_border_x then
        -- render padding at the left
        result = result .. " "        
      elseif data_y ~= nil and data_x ~= nil then      
        local data_element = data_triangle[data_y][data_x]
        result = result .. data_element
      else
        -- border or triangle top
        if render_y == 1 then
          -- triangle top
          result = result .. "^"
        else -- regular row
          
          local render_dash = true
          
          if data_y == nil then
            
            if math.fmod(render_delta_since_left_border_begin, 4) == 0 then
              result = result .. "*"
            else
              result = result .. "-"
            end
          else -- data row
            if open_dash then
              result = result .. "/"
            else
              result = result .. "\\"
            end -- open dash check
            
            open_dash = not open_dash
          end -- data row check
        end -- triangle top check
      end -- symbol type switch
      
    end -- for render_x
    
    if render_y ~= render_height then
      result = result .. "\n"
    end
  end -- for render_y
  
  return result
end


function lib.pyramid_debug_trace(pyramid)
  if type(pyramid) ~= "table" and type(pyramid) ~= "string" then
    print("pyramid_debug_trace: pyramid is not table. Regular print:", pyramid)
    return
  end
  
  local triangle = lib.pyramid_tree_to_triangle(pyramid)
  
--  print('pyramid =')
--  lib.print_r(pyramid)
--  print('triangle =')
--  lib.print_r(triangle)
  print()
--  print('triangle render: ')
  print(lib.triangle_render(triangle))
  print()
end

---
-- @tparam table pyramid_tree_part
-- @treturn int bibit checksum
--
function lib.bibit(pyramid)
  --- global debug_mode is used
  local debug_mode = debug_mode
  local iteration = 1

  while iteration <= 1024 do
    pyramid = lib.bibit_step(pyramid)
    if debug_mode then
      print()
      print('----- iteration #'..iteration..' -----')
      print()
      lib.pyramid_debug_trace(pyramid)
    end -- if debug mode
       
    if lib.pyramid_reducible(pyramid) then
      pyramid = lib.pyramid_reduce(pyramid)
      if debug_mode then
        print()
        print('== after reduce ==')
        print()
        lib.pyramid_debug_trace(pyramid)
      end -- if debug mode
    end -- if reducible
    
    if type(pyramid) == "number" then
      return pyramid
    else
      local triangle = lib.pyramid_tree_to_triangle(pyramid)
      local binary = lib.triangle_to_binary(triangle)
      print(table.concat(binary, ""))
    end
    
--    if lib.pyramid_leaf_reducible(pyramid) then
--      return lib.pyramid_leaf_reduce(pyramid)
--    end
    iteration = iteration + 1
  end -- while iteration < limit
  
  error('to much iterations!')
end

---
-- get max branch level
function lib.tree_max_level(tree_part)
  if type(tree_part) == "table" then
    local child_max_level = 0
    
    for index=1, #tree_part do
      local child_level = lib.tree_max_level(tree_part[index])
      if child_level > child_max_level then
        child_max_level = child_level
      end -- max level check
    end -- for index
    
    return 1 + child_max_level
    
  else -- not table:
    return 0
  end -- type check
end

---
-- Smaill triangle indices:
--
--        ^
--       /1\      <-- first row
--      *---*
--     /2\3/4\    <-- second row
--    *---*---*
--
-- @tparam table big_triangle
-- @tparam int triangle_index
-- @tparam table small_triangle
--
-- @treturn table result triangle
function lib.write_triangle_to_triangle(big_triangle, triangle_index, small_triangle)
  local small_height = #small_triangle
  local big_height = small_height * 2 
  local big_row1_bottom = math.floor(big_height / 2)
  local big_row2_top = math.floor(big_height / 2) + 1

  local write_top, write_bottom, write_x

  if triangle_index == 1 then -- top
    write_top = 1
    write_x = 0
    write_bottom = big_row1_bottom
  elseif triangle_index == 2 then -- left
    write_top = big_row2_top
    write_x = -small_height
    write_bottom = big_height
  elseif triangle_index == 3 then -- bottom
    write_top = big_height
    write_x = 0
    write_bottom = big_row2_top
  elseif triangle_index == 4 then -- right
    write_top = big_row2_top
    write_x = small_height
    write_bottom = big_height
  else
    error("triangle index must be in [1..4]")
  end
  
  local write_inverted = write_bottom < write_top
  
  for small_y = 1, small_height, 1 do
    local max_x = small_y - 1
    for small_x = -max_x, max_x do
      local small_element = lib.triangle_get_element(small_triangle, small_y, small_x)
      local big_x = write_x + small_x
      local big_y = write_top
      
      if write_inverted then
        big_y = big_y - (small_y - 1)
      else -- write not inverted:
        big_y = big_y + (small_y - 1)
      end -- write check end
      
      lib.triangle_put_element(big_triangle, big_y, big_x, small_element)
    end -- for sm_x
  end -- for sm_y
  
  return big_triangle
end

function lib.pyramid_tree_to_triangle(pyramid_tree_part)
  local result = {}
  
  if type(pyramid_tree_part) == "table" then   
    for triangle_index = 1, 4 do
      local element = pyramid_tree_part[triangle_index]
      
      local sub_triangle = lib.pyramid_tree_to_triangle(element)
      lib.write_triangle_to_triangle(result, triangle_index, sub_triangle)
    end -- for triangle index
  else -- not table:
    result = {{}, {}}
    
    if type(pyramid_tree_part) ~= "string" then
      error("table or string expected!")
    end
    
    for pos = 1, 4 do
      local element = tonumber(string.sub(pyramid_tree_part, pos, pos))
      if pos == 1 then result[1][1] = element
      elseif pos == 2 then result[2][1] = element
      elseif pos == 3 then result[2][2] = element
      elseif pos == 4 then result[2][3] = element
      end
    end -- for pos
  end -- type check
  
  return result
end

function lib.triangle_to_binary(pyramid_tree)
  local result = {}
  
  for row_index=1, #pyramid_tree do
    local row = pyramid_tree[row_index]
    for el_index=1, #row do      
      table.insert(result, row[el_index])
    end -- for element index
  end -- for row index
  
  return result
end

return lib