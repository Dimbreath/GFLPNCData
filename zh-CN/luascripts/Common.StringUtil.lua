-- params : ...
-- function num : 0 , upvalues : _ENV
if not unpack then
  local unpack = table.unpack
end
local split = function(split_string, pattern, search_pos_begin, plain)
  -- function num : 0_0 , upvalues : _ENV
  assert(type(split_string) == "string")
  assert(type(pattern) == "string" and #pattern > 0)
  if not search_pos_begin then
    search_pos_begin = 1
  end
  plain = plain ~= nil and plain
  local split_result = {}
  if (string.IsNullOrEmpty)(split_string) then
    return split_result
  end
  while 1 do
    local find_pos_begin, find_pos_end = (string.find)(split_string, pattern, search_pos_begin, plain)
    if find_pos_begin then
      do
        local cur_str = nil
        if search_pos_begin < find_pos_begin then
          cur_str = (string.sub)(split_string, search_pos_begin, find_pos_begin - 1)
        else
          cur_str = ""
        end
        split_result[#split_result + 1] = cur_str
        search_pos_begin = find_pos_end + 1
        -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if search_pos_begin <= (string.len)(split_string) then
    split_result[#split_result + 1] = (string.sub)(split_string, search_pos_begin)
  else
    split_result[#split_result + 1] = ""
  end
  do return split_result end
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

local join = function(join_table, joiner)
  -- function num : 0_1 , upvalues : _ENV, unpack
  if #join_table == 0 then
    return ""
  end
  local fmt = "%s"
  for i = 2, #join_table do
    fmt = fmt .. joiner .. "%s"
  end
  return (string.format)(fmt, unpack(join_table))
end

local contains = function(target_string, pattern, plain)
  -- function num : 0_2 , upvalues : _ENV
  if plain ~= nil or not true then
    local find_pos_begin, find_pos_end = (string.find)(target_string, pattern, 1, plain)
    do return find_pos_begin ~= nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

local startswith = function(target_string, start_pattern, plain)
  -- function num : 0_3 , upvalues : _ENV
  if plain ~= nil or not true then
    local find_pos_begin, find_pos_end = (string.find)(target_string, start_pattern, 1, plain)
    do return find_pos_begin == 1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

local endswith = function(target_string, start_pattern, plain)
  -- function num : 0_4 , upvalues : _ENV
  if plain ~= nil or not true then
    local find_pos_begin, find_pos_end = (string.find)(target_string, start_pattern, -#start_pattern, plain)
    do return find_pos_end == #target_string end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

local IsNullOrEmpty = function(target_string)
  -- function num : 0_5 , upvalues : _ENV
  if type(target_string) ~= "string" then
    return true
  end
  if target_string == "" or #target_string == 0 then
    return true
  end
  return false
end

local trim = function(s)
  -- function num : 0_6 , upvalues : _ENV
  return (string.gsub)(s, "^%s*(.-)%s*$", "%1")
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

string.split = split
-- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

string.join = join
-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

string.contains = contains
-- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

string.startswith = startswith
-- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

string.endswith = endswith
-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

string.IsNullOrEmpty = IsNullOrEmpty
-- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

string.trim = trim

