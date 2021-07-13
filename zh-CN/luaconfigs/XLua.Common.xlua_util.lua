-- params : ...
-- function num : 0 , upvalues : _ENV
if not unpack then
  local unpack = table.unpack
end
local async_to_sync = function(async_func, callback_pos)
  -- function num : 0_0 , upvalues : _ENV, unpack
  return function(...)
    -- function num : 0_0_0 , upvalues : _ENV, callback_pos, async_func, unpack
    if not (coroutine.running)() then
      local _co = (error("this function must be run in coroutine"))
    end
    local rets = nil
    local waiting = false
    local cb_func = function(...)
      -- function num : 0_0_0_0 , upvalues : waiting, _ENV, _co, rets
      if waiting then
        assert((coroutine.resume)(_co, ...))
      else
        rets = {...}
      end
    end

    local params = {...}
    if not callback_pos then
      (table.insert)(params, #params + 1, cb_func)
      async_func(unpack(params))
      if rets == nil then
        waiting = true
        rets = {(coroutine.yield)()}
      end
      return unpack(rets)
    end
  end

end

local coroutine_call = function(func)
  -- function num : 0_1 , upvalues : _ENV
  return function(...)
    -- function num : 0_1_0 , upvalues : _ENV, func
    local co = (coroutine.create)(func)
    assert((coroutine.resume)(co, ...))
  end

end

local move_end = {}
local generator_mt = {
__index = {MoveNext = function(self)
  -- function num : 0_2 , upvalues : move_end
  self.Current = (self.co)()
  if self.Current == move_end then
    self.Current = nil
    return false
  else
    return true
  end
end
, Reset = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.co = (coroutine.wrap)(self.w_func)
end
}
}
local cs_generator = function(func, ...)
  -- function num : 0_4 , upvalues : _ENV, unpack, move_end, generator_mt
  local params = {...}
  local generator = setmetatable({w_func = function()
    -- function num : 0_4_0 , upvalues : _ENV, func, unpack, params, move_end
    local status, current = xpcall(func, debug.traceback, unpack(params))
    if not status then
      error(current)
    end
    return move_end
  end
}, generator_mt)
  generator:Reset()
  return generator
end

local loadpackage = function(...)
  -- function num : 0_5 , upvalues : _ENV
  for _,loader in ipairs(package.searchers) do
    local func = loader(...)
    if type(func) == "function" then
      return func
    end
  end
end

local auto_id_map = function()
  -- function num : 0_6 , upvalues : _ENV
  local hotfix_id_map = require("hotfix_id_map")
  local org_hotfix = xlua.hotfix
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  xlua.hotfix = function(cs, field, func)
    -- function num : 0_6_0 , upvalues : hotfix_id_map, _ENV, org_hotfix
    local map_info_of_type = hotfix_id_map[(typeof(cs)):ToString()]
    if map_info_of_type then
      if func == nil then
        func = false
      end
      if type(field) ~= "table" or not field then
        local tbl = {[field] = func}
      end
      for k,v in pairs(tbl) do
        local map_info_of_methods = map_info_of_type[k]
        local f = type(v) == "function" and v or nil
        if not map_info_of_methods then
          for _,id in ipairs({}) do
            (((CS.XLua).HotfixDelegateBridge).Set)(id, f)
          end
          do
            -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      ;
      (xlua.private_accessible)(cs)
    else
      do
        do return org_hotfix(cs, field, func) end
      end
    end
  end

end

local hotfix_ex = function(cs, field, func)
  -- function num : 0_7 , upvalues : _ENV, unpack
  assert(type(field) == "string" and type(func) == "function", "invalid argument: #2 string needed, #3 function needed!")
  local func_after = function(...)
    -- function num : 0_7_0 , upvalues : _ENV, cs, field, func, func_after, unpack
    (xlua.hotfix)(cs, field, nil)
    local ret = {func(...)}
    ;
    (xlua.hotfix)(cs, field, func_after)
    return unpack(ret)
  end

  ;
  (xlua.hotfix)(cs, field, func_after)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local bind = function(func, obj)
  -- function num : 0_8
  return function(...)
    -- function num : 0_8_0 , upvalues : func, obj
    return func(obj, ...)
  end

end

local enum_or_op = ((debug.getmetatable)((((CS.System).Reflection).BindingFlags).Public)).__bor
local enum_or_op_ex = function(first, ...)
  -- function num : 0_9 , upvalues : _ENV, enum_or_op
  for _,e in ipairs({...}) do
    first = enum_or_op(first, e)
  end
  return first
end

local createdelegate = function(delegate_cls, obj, impl_cls, method_name, parameter_type_list)
  -- function num : 0_10 , upvalues : enum_or_op_ex, _ENV
  local flag = enum_or_op_ex((((CS.System).Reflection).BindingFlags).Public, (((CS.System).Reflection).BindingFlags).NonPublic, (((CS.System).Reflection).BindingFlags).Instance, (((CS.System).Reflection).BindingFlags).Static)
  if not parameter_type_list or not (typeof(impl_cls)):GetMethod(method_name, flag, nil, parameter_type_list, nil) then
    local m = (typeof(impl_cls)):GetMethod(method_name, flag)
  end
  return (((CS.System).Delegate).CreateDelegate)(typeof(delegate_cls), obj, m)
end

local state = function(csobj, state)
  -- function num : 0_11 , upvalues : _ENV
  local csobj_mt = getmetatable(csobj)
  for k,v in pairs(csobj_mt) do
    rawset(state, k, v)
  end
  local csobj_index, csobj_newindex = state.__index, state.__newindex
  state.__index = function(obj, k)
    -- function num : 0_11_0 , upvalues : _ENV, state, csobj_index
    if not rawget(state, k) then
      return csobj_index(obj, k)
    end
  end

  state.__newindex = function(obj, k, v)
    -- function num : 0_11_1 , upvalues : _ENV, state, csobj_newindex
    if rawget(state, k) ~= nil then
      rawset(state, k, v)
    else
      csobj_newindex(obj, k, v)
    end
  end

  ;
  (debug.setmetatable)(csobj, state)
  return state
end

local print_func_ref_by_csharp = function()
  -- function num : 0_12 , upvalues : _ENV
  local registry = (debug.getregistry)()
  for k,v in pairs(registry) do
    if type(k) == "number" and type(v) == "function" and registry[v] == k then
      local info = (debug.getinfo)(v)
      print((string.format)("%s:%d", info.short_src, info.linedefined))
    end
  end
end

return {async_to_sync = async_to_sync, coroutine_call = coroutine_call, cs_generator = cs_generator, loadpackage = loadpackage, auto_id_map = auto_id_map, hotfix_ex = hotfix_ex, bind = bind, createdelegate = createdelegate, state = state, print_func_ref_by_csharp = print_func_ref_by_csharp}

