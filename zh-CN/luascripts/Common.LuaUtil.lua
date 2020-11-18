-- params : ...
-- function num : 0 , upvalues : _ENV
if not unpack then
  local unpack = table.unpack
end
SafePack = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local params = {...}
  params.n = select("#", ...)
  return params
end

SafeUnpack = function(safe_pack_tb)
  -- function num : 0_1 , upvalues : unpack
  return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

ConcatSafePack = function(safe_pack_l, safe_pack_r)
  -- function num : 0_2
  local concat = {}
  for i = 1, safe_pack_l.n do
    concat[i] = safe_pack_l[i]
  end
  for i = 1, safe_pack_r.n do
    concat[safe_pack_l.n + i] = safe_pack_r[i]
  end
  concat.n = safe_pack_l.n + safe_pack_r.n
  return concat
end

Bind = function(self, func, ...)
  -- function num : 0_3 , upvalues : _ENV
  assert(self == nil or type(self) == "table")
  assert(func ~= nil and type(func) == "function")
  local params = nil
  if self == nil then
    params = SafePack(...)
  else
    params = SafePack(self, ...)
  end
  do return function(...)
    -- function num : 0_3_0 , upvalues : _ENV, params, func
    local args = ConcatSafePack(params, SafePack(...))
    return func(SafeUnpack(args))
  end
 end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BindCallback = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local bindFunc = nil
  local params = SafePack(...)
  assert(params.n >= 1, "BindCallback : error params count!")
  if type(params[1]) == "table" and type(params[2]) == "function" then
    bindFunc = Bind(...)
  elseif type(params[1]) == "function" then
    bindFunc = Bind(nil, ...)
  else
    error("BindCallback : error params list!")
  end
  do return bindFunc end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

ToBoolean = function(s)
  -- function num : 0_5
  local transform_map = {["true"] = true, ["false"] = false}
  return transform_map[s]
end

DeepCopy = function(object)
  -- function num : 0_6 , upvalues : _ENV
  local lookup_table = {}
  local _copy = function(object)
    -- function num : 0_6_0 , upvalues : _ENV, lookup_table, _copy
    if type(object) ~= "table" then
      return object
    else
      if lookup_table[object] then
        return lookup_table[object]
      end
    end
    local new_table = {}
    lookup_table[object] = new_table
    for index,value in pairs(object) do
      new_table[_copy(index)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end

  return _copy(object)
end

Serialize = function(tb, flag)
  -- function num : 0_7 , upvalues : _ENV
  local result = ""
  result = (string.format)("%s{", result)
  local filter = function(str)
    -- function num : 0_7_0 , upvalues : _ENV
    str = (string.gsub)(str, "%[", " ")
    str = (string.gsub)(str, "%]", " ")
    str = (string.gsub)(str, "\"", " ")
    str = (string.gsub)(str, "%\'", " ")
    str = (string.gsub)(str, "\\", " ")
    str = (string.gsub)(str, "%%", " ")
    return str
  end

  for k,v in pairs(tb) do
    if type(k) == "number" then
      if type(v) == "table" then
        result = (string.format)("%s[%d]=%s,", result, k, Serialize(v))
      else
        if type(v) == "number" then
          result = (string.format)("%s[%d]=%d,", result, k, v)
        else
          if type(v) == "string" then
            result = (string.format)("%s[%d]=%q,", result, k, v)
          else
            if type(v) == "boolean" then
              result = (string.format)("%s[%d]=%s,", result, k, tostring(v))
            else
              if flag then
                result = (string.format)("%s[%d]=%q,", result, k, type(v))
              else
                error("the type of value is a function or userdata")
              end
            end
          end
        end
      end
    else
      if type(v) == "table" then
        result = (string.format)("%s%s=%s,", result, k, Serialize(v, flag))
      else
        if type(v) == "number" then
          result = (string.format)("%s%s=%d,", result, k, v)
        else
          if type(v) == "string" then
            result = (string.format)("%s%s=%q,", result, k, v)
          else
            if type(v) == "boolean" then
              result = (string.format)("%s%s=%s,", result, k, tostring(v))
            else
              if flag then
                result = (string.format)("%s[%s]=%q,", result, k, type(v))
              else
                error("the type of value is a function or userdata")
              end
            end
          end
        end
      end
    end
  end
  result = (string.format)("%s}", result)
  return result
end

CreatEnumTable = function(tbl, index)
  -- function num : 0_8 , upvalues : _ENV
  assert(type(tbl) == "table")
  local enumtbl = {}
  local enumindex = index or 0
  for i,v in ipairs(tbl) do
    enumtbl[v] = enumindex + i
  end
  do return enumtbl end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

List2Table = function(list)
  -- function num : 0_9 , upvalues : _ENV
  local tab = {}
  for i = 0, list.Count - 1 do
    (table.insert)(tab, list[i])
  end
  return tab
end

Dictionary2Table = function(dic)
  -- function num : 0_10 , upvalues : _ENV
  local tab = {}
  for k,v in pairs(dic) do
    tab[k] = v
  end
  return tab
end

FormatNum = function(num)
  -- function num : 0_11 , upvalues : _ENV
  local t1, t2 = (math.modf)(num)
  if t2 > 0 then
    return num
  else
    return t1
  end
end

GetPreciseDecimalStr = function(num, n)
  -- function num : 0_12 , upvalues : _ENV
  num = FormatNum(num)
  local isInt = num == (math.floor)(num)
  local format = "%." .. tostring(n) .. "f"
  if not isInt or not tostring(num) then
    local value = (string.format)(format, num)
  end
  do return value end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

math.clamp = function(v, minValue, maxValue)
  -- function num : 0_13
  if v < minValue then
    return minValue
  end
  if maxValue < v then
    return maxValue
  end
  return v
end


