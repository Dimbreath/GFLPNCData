-- params : ...
-- function num : 0 , upvalues : _ENV
local count = function(hashtable)
  -- function num : 0_0 , upvalues : _ENV
  local count = 0
  for _,_ in pairs(hashtable) do
    count = count + 1
  end
  return count
end

local length = function(array)
  -- function num : 0_1 , upvalues : _ENV
  if array.n ~= nil then
    return array.n
  end
  local count = 0
  for i,_ in pairs(array) do
    if count < i then
      count = i
    end
  end
  return count
end

local setlen = function(array, n)
  -- function num : 0_2
  array.n = n
end

local keys = function(hashtable)
  -- function num : 0_3 , upvalues : _ENV
  local keys = {}
  for k,v in pairs(hashtable) do
    keys[#keys + 1] = k
  end
  return keys
end

local values = function(hashtable)
  -- function num : 0_4 , upvalues : _ENV
  local values = {}
  for k,v in pairs(hashtable) do
    values[#values + 1] = v
  end
  return values
end

local merge = function(dest_hashtable, src_hashtable)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(src_hashtable) do
    dest_hashtable[k] = v
  end
end

local insertto = function(dest_array, src_array, begin)
  -- function num : 0_6 , upvalues : _ENV
  assert(begin == nil or type(begin) == "number")
  if begin == nil or begin <= 0 then
    begin = #dest_array + 1
  end
  local src_len = #src_array
  for i = 0, src_len - 1 do
    dest_array[i + (begin)] = src_array[i + 1]
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local indexof = function(array, value, begin)
  -- function num : 0_7
  for i = begin or 1, #array do
    if array[i] == value then
      return i
    end
  end
  return false
end

local keyof = function(hashtable, value)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in pairs(hashtable) do
    if v == value then
      return k
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

table.removebyvalue = function(array, value, removeall)
  -- function num : 0_9 , upvalues : _ENV
  local remove_count = 0
  for i = #array, 1, -1 do
    if array[i] == value then
      (table.remove)(array, i)
      remove_count = remove_count + 1
    end
  end
  do
    if removeall then
      return remove_count
    end
  end
end

local map = function(tb, func)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(tb) do
    tb[k] = func(k, v)
  end
end

local walk = function(tb, func)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in pairs(tb) do
    func(k, v)
  end
end

local walksort = function(tb, sort_func, walk_func)
  -- function num : 0_12 , upvalues : _ENV
  local keys = (table.keys)(tb)
  ;
  (table.sort)(keys, function(lkey, rkey)
    -- function num : 0_12_0 , upvalues : sort_func
    return sort_func(lkey, rkey)
  end
)
  for i = 1, (table.length)(keys) do
    walk_func(keys[i], tb[keys[i]])
  end
end

local filter = function(tb, func)
  -- function num : 0_13 , upvalues : _ENV
  local filter = {}
  for k,v in pairs(tb) do
    if not func(k, v) then
      filter[k] = v
    end
  end
  return filter
end

local choose = function(tb, func)
  -- function num : 0_14 , upvalues : _ENV
  local choose = {}
  for k,v in pairs(tb) do
    if func(k, v) then
      choose[k] = v
    end
  end
  return choose
end

local circulator = function(array)
  -- function num : 0_15
  local i = 1
  local iter = function()
    -- function num : 0_15_0 , upvalues : i, array
    if #array > i or not 1 then
      i = i + 1
      return array[i]
    end
  end

  return iter
end

local dump = function(tb, dump_metatable, max_level)
  -- function num : 0_16 , upvalues : _ENV
  local lookup_table = {}
  local level = 0
  local rep = string.rep
  local dump_metatable = dump_metatable
  local max_level = max_level or 1
  local _dump = function(tb, level)
    -- function num : 0_16_0 , upvalues : rep, _ENV, lookup_table, max_level, _dump, dump_metatable
    local str = "\n" .. rep("\t", level) .. "{\n"
    for k,v in pairs(tb) do
      local k_is_str = type(k) == "string" and 1 or 0
      local v_is_str = type(v) == "string" and 1 or 0
      if not tostring(k) then
        str = str .. rep("\t", level + 1) .. "[" .. rep("\"", k_is_str) .. type(k) .. rep("\"", k_is_str) .. "]" .. " = "
        if type(v) == "table" then
          if not lookup_table[v] and (not max_level or level < max_level) then
            lookup_table[v] = true
            str = str .. _dump(v, level + 1, dump_metatable) .. "\n"
          else
            if not tostring(v) then
              str = str .. type(v) .. ",\n"
              if not tostring(v) then
                do
                  str = str .. rep("\"", v_is_str) .. type(v) .. rep("\"", v_is_str) .. ",\n"
                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
    if dump_metatable then
      local mt = getmetatable(tb)
      if mt ~= nil and type(mt) == "table" then
        str = str .. rep("\t", level + 1) .. "[\"__metatable\"]" .. " = "
        if not lookup_table[mt] and (not max_level or level < max_level) then
          lookup_table[mt] = true
          str = str .. _dump(mt, level + 1, dump_metatable) .. "\n"
        else
          if not tostring(v) then
            do
              str = str .. type(v) .. ",\n"
              str = str .. rep("\t", level) .. "},"
              return str
            end
          end
        end
      end
    end
  end

  return _dump(tb, level)
end

local contain = function(tb, value)
  -- function num : 0_17 , upvalues : _ENV
  for k,v in pairs(tb) do
    if v == value then
      return true
    end
  end
  return false
end

local deepCopy = function(object)
  -- function num : 0_18 , upvalues : _ENV
  local lookup_table = {}
  local _copy = function(object)
    -- function num : 0_18_0 , upvalues : _ENV, lookup_table, _copy
    if type(object) ~= "table" then
      return object
    else
      if lookup_table[object] then
        return lookup_table[object]
      end
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key,value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end

  return _copy(object)
end

local GetDefaulValueTable = function(defaultValue)
  -- function num : 0_19 , upvalues : _ENV
  return setmetatable({}, {__index = function(tab, key)
    -- function num : 0_19_0 , upvalues : defaultValue
    return defaultValue
  end
})
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R19 in 'UnsetPending'

table.count = count
-- DECOMPILER ERROR at PC25: Confused about usage of register: R19 in 'UnsetPending'

table.length = length
-- DECOMPILER ERROR at PC27: Confused about usage of register: R19 in 'UnsetPending'

table.setlen = setlen
-- DECOMPILER ERROR at PC29: Confused about usage of register: R19 in 'UnsetPending'

table.keys = keys
-- DECOMPILER ERROR at PC31: Confused about usage of register: R19 in 'UnsetPending'

table.values = values
-- DECOMPILER ERROR at PC33: Confused about usage of register: R19 in 'UnsetPending'

table.merge = merge
-- DECOMPILER ERROR at PC35: Confused about usage of register: R19 in 'UnsetPending'

table.insertto = insertto
-- DECOMPILER ERROR at PC37: Confused about usage of register: R19 in 'UnsetPending'

table.indexof = indexof
-- DECOMPILER ERROR at PC39: Confused about usage of register: R19 in 'UnsetPending'

table.keyof = keyof
-- DECOMPILER ERROR at PC41: Confused about usage of register: R19 in 'UnsetPending'

table.map = map
-- DECOMPILER ERROR at PC43: Confused about usage of register: R19 in 'UnsetPending'

table.walk = walk
-- DECOMPILER ERROR at PC45: Confused about usage of register: R19 in 'UnsetPending'

table.walksort = walksort
-- DECOMPILER ERROR at PC47: Confused about usage of register: R19 in 'UnsetPending'

table.filter = filter
-- DECOMPILER ERROR at PC49: Confused about usage of register: R19 in 'UnsetPending'

table.choose = choose
-- DECOMPILER ERROR at PC51: Confused about usage of register: R19 in 'UnsetPending'

table.circulator = circulator
-- DECOMPILER ERROR at PC53: Confused about usage of register: R19 in 'UnsetPending'

table.dump = dump
-- DECOMPILER ERROR at PC55: Confused about usage of register: R19 in 'UnsetPending'

table.contain = contain
-- DECOMPILER ERROR at PC58: Confused about usage of register: R19 in 'UnsetPending'

table.emptytable = {}
-- DECOMPILER ERROR at PC60: Confused about usage of register: R19 in 'UnsetPending'

table.deepCopy = deepCopy
-- DECOMPILER ERROR at PC62: Confused about usage of register: R19 in 'UnsetPending'

table.GetDefaulValueTable = GetDefaulValueTable

