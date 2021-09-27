local packPool = (CommonPool.New)(function()
  -- function num : 0_0 , upvalues : _ENV
  return setmetatable({}, {__mode = "v"})
end
, nil)
if not unpack then
  local unpack = table.unpack
end
SafePack = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local params = {...}
  params.n = select("#", ...)
  return params
end

SafeUnpack = function(safe_pack_tb)
  -- function num : 0_2 , upvalues : unpack
  return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

ConcatSafePackNoGC = function(concat, safe_pack_l, ...)
  -- function num : 0_3 , upvalues : _ENV
  for i = 1, safe_pack_l.n do
    concat[i] = safe_pack_l[i]
  end
  local rn = select("#", ...)
  for i = 1, rn do
    concat[safe_pack_l.n + i] = select(i, ...)
  end
  concat.n = safe_pack_l.n + rn
end

Bind = function(self, func, ...)
  -- function num : 0_4 , upvalues : _ENV, packPool
  assert(self == nil or type(self) == "table")
  assert(func ~= nil and type(func) == "function")
  local params = nil
  if self == nil then
    params = SafePack(...)
  else
    params = SafePack(self, ...)
  end
  do return function(...)
    -- function num : 0_4_0 , upvalues : _ENV, packPool, params, func
    if select("#", ...) > 0 then
      local args = packPool:PoolGet()
      ConcatSafePackNoGC(args, params, ...)
      local ret, ret2 = func(SafeUnpack(args))
      packPool:PoolPut(args)
      return ret, ret2
    end
    do
      return func(SafeUnpack(params))
    end
  end
 end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BindCallback = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local bindFunc = nil
  local argCount = select("#", ...)
  assert(argCount >= 1, "BindCallback : error params count!")
  if type(select(1, ...)) == "table" and type(select(2, ...)) == "function" then
    bindFunc = Bind(...)
  elseif type(select(1, ...)) == "function" then
    bindFunc = Bind(nil, ...)
  else
    error("BindCallback : error params list!")
  end
  do return bindFunc end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
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
  if not n then
    n = 0
  end
  local floor = (math.floor)(num)
  local isInt = n == 0 or num == floor
  local value = nil
  if isInt then
    value = tostring(floor)
  else
    local scale = (Mathf.Pow)(10, n)
    num = num * scale
    value = tostring((math.floor)(num) / scale)
  end
  do return value end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

string.isNumber = function(str)
  -- function num : 0_14 , upvalues : _ENV
  if (string.len)(str) < 1 then
    return false
  end
  for i = 1, (string.len)(str) do
    if (string.byte)(str, i, i) < 48 or (string.byte)(str, i, i) > 57 then
      return false
    end
  end
  return true
end


