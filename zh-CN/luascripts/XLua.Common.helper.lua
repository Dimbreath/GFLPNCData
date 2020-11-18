-- params : ...
-- function num : 0 , upvalues : _ENV
if not unpack then
  local unpack = table.unpack
end
local try_get_value = function(dic, key)
  -- function num : 0_0
  local ret, value = dic:TryGetValue(key)
  return ret and value or nil
end

local new_object = function(obj_type)
  -- function num : 0_1 , upvalues : _ENV
  return (((CS.System).Activator).CreateInstance)(obj_type)
end

local new_array = function(item_type, item_count)
  -- function num : 0_2 , upvalues : _ENV
  return ((CS.XLuaHelper).CreateArrayInstance)(item_type, item_count)
end

local new_list = function(item_type)
  -- function num : 0_3 , upvalues : _ENV
  return ((CS.XLuaHelper).CreateListInstance)(item_type)
end

local new_dictionary = function(key_type, value_type)
  -- function num : 0_4 , upvalues : _ENV
  return ((CS.XLuaHelper).CreateDictionaryInstance)(key_type, value_type)
end

local new_action = function(cs_obj, method_name, ...)
  -- function num : 0_5 , upvalues : _ENV
  return ((CS.XLuaHelper).CreateActionDelegate)(cs_obj, method_name, ...)
end

local new_callback = function(cs_obj, method_name, ...)
  -- function num : 0_6 , upvalues : _ENV
  return ((CS.XLuaHelper).CreateCallbackDelegate)(cs_obj, method_name, ...)
end

local list_iter = function(cs_ilist, index)
  -- function num : 0_7
  index = index + 1
  if index < cs_ilist.Count then
    return index, cs_ilist[index]
  end
end

local list_ipairs = function(cs_ilist)
  -- function num : 0_8 , upvalues : list_iter
  return list_iter, cs_ilist, -1
end

local dictionary_iter = function(cs_enumerator)
  -- function num : 0_9
  if cs_enumerator:MoveNext() then
    local current = cs_enumerator.Current
    return current.Key, current.Value
  end
end

local dictionary_ipairs = function(cs_idictionary)
  -- function num : 0_10 , upvalues : dictionary_iter
  local cs_enumerator = cs_idictionary:GetEnumerator()
  return dictionary_iter, cs_enumerator
end

local make_generic_list_type = function(item_type)
  -- function num : 0_11 , upvalues : _ENV
  return ((CS.XLuaHelper).MakeGenericListType)(item_type)
end

local make_generic_dictionary_type = function(key_type, value_type)
  -- function num : 0_12 , upvalues : _ENV
  return ((CS.XLuaHelper).MakeGenericDictionaryType)(key_type, value_type)
end

local make_generic_callback_type = function(...)
  -- function num : 0_13 , upvalues : _ENV
  return ((CS.XLuaHelper).MakeGenericCallbackType)(...)
end

local make_generic_action_type = function(...)
  -- function num : 0_14 , upvalues : _ENV
  return ((CS.XLuaHelper).MakeGenericActionType)(...)
end

local hotfix_safe = function(cs, field, func)
  -- function num : 0_15 , upvalues : _ENV, unpack
  assert(type(field) == "string" and type(func) == "function", "invalid argument: #2 string needed, #3 function needed!")
  local func_safe = function(self, ...)
    -- function num : 0_15_0 , upvalues : _ENV, cs, field, func, func_safe, unpack
    (xlua.hotfix)(cs, field, nil)
    local ret = {pcall(func, self, ...)}
    local status, err = ret[1], ret[2]
    ;
    (table.remove)(ret, 1)
    if not status and self then
      error("hotfix_safe " .. field .. " failed(call cs func instead) with err : " .. err)
      local cs_func = load("return function(self, ...) self:" .. field .. "(...) end")
      ret = {(cs_func())(self, ...)}
    end
    do
      ;
      (xlua.hotfix)(cs, field, func_safe)
      return unpack(ret)
    end
  end

  ;
  (xlua.hotfix)(cs, field, func_safe)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return {try_get_value = try_get_value, new_object = new_object, new_array = new_array, new_list = new_list, new_dictionary = new_dictionary, new_action = new_action, new_callback = new_callback, list_ipairs = list_ipairs, dictionary_ipairs = dictionary_ipairs, make_generic_list_type = make_generic_list_type, make_generic_dictionary_type = make_generic_dictionary_type, make_generic_callback_type = make_generic_callback_type, make_generic_action_type = make_generic_action_type, hotfix_safe = hotfix_safe}

