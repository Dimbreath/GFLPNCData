-- params : ...
-- function num : 0 , upvalues : _ENV
if not unpack then local unpack = table.unpack end
local util = require("XLua.Common.util")
local helper = require("XLua.Common.helper")
local cache = {}
local GetKey = function(...)
    -- function num : 0_0 , upvalues : _ENV
    local params = {...}
    local key = ""
    for _, v in ipairs(params) do key = key .. "\t" .. tostring(v) end
    return key
end

local GetCache = function(key)
    -- function num : 0_1 , upvalues : cache
    return cache[key]
end

local SetCache = function(key, value)
    -- function num : 0_2 , upvalues : _ENV, GetCache, cache
    assert(GetCache(key) == nil, "already contains key " .. key)
    cache[key] = value
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local ClearCache = function(key)
    -- function num : 0_3 , upvalues : cache
    cache[key] = nil
end

local add_listener_with_delegate = function(messengerName, cs_del_obj)
    -- function num : 0_4 , upvalues : _ENV
    ((CS.XLuaMessenger).AddListener)(messengerName, cs_del_obj)
end

local add_listener_with_func = function(messengerName, cs_obj, func)
    -- function num : 0_5 , upvalues : GetKey, GetCache, util, SetCache, _ENV
    local key = GetKey(cs_obj, func)
    local obj_bind_callback = GetCache(key)
    if obj_bind_callback == nil then
        obj_bind_callback = (util.bind)(func, cs_obj)
        SetCache(key, obj_bind_callback)
        local lua_callback = ((CS.XLuaMessenger).CreateDelegate)(messengerName,
                                                                 obj_bind_callback);
        ((CS.XLuaMessenger).AddListener)(messengerName, lua_callback)
    end
end

local add_listener_with_reflection =
    function(messengerName, cs_obj, method_name, ...)
        -- function num : 0_6 , upvalues : helper, _ENV
        local cs_del_obj = (helper.new_callback)(cs_obj, method_name, ...);
        ((CS.XLuaMessenger).AddListener)(messengerName, cs_del_obj)
    end

local add_listener = function(messengerName, ...)
    -- function num : 0_7 , upvalues : _ENV, add_listener_with_delegate, unpack, add_listener_with_func, add_listener_with_reflection
    local params = {...}
    assert(#params >= 1, "error params count!")
    if #params == 1 then
        add_listener_with_delegate(messengerName, unpack(params))
    elseif #params == 2 and type(params[2]) == "function" then
        add_listener_with_func(messengerName, unpack(params))
    else
        add_listener_with_reflection(messengerName, unpack(params))
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

local broadcast = function(messengerName, ...)
    -- function num : 0_8 , upvalues : _ENV
    ((CS.XLuaMessenger).Broadcast)(messengerName, ...)
end

local remove_listener_with_delegate = function(messengerName, cs_del_obj)
    -- function num : 0_9 , upvalues : _ENV
    ((CS.XLuaMessenger).RemoveListener)(messengerName, cs_del_obj)
end

local remove_listener_with_func = function(messengerName, cs_obj, func)
    -- function num : 0_10 , upvalues : GetKey, GetCache, ClearCache, _ENV
    local key = GetKey(cs_obj, func)
    local obj_bind_callback = GetCache(key)
    if obj_bind_callback ~= nil then
        ClearCache(key)
        local lua_callback = ((CS.XLuaMessenger).CreateDelegate)(messengerName,
                                                                 obj_bind_callback);
        ((CS.XLuaMessenger).RemoveListener)(messengerName, lua_callback)
    end
end

local remove_listener_with_reflection = function(messengerName, cs_obj,
                                                 method_name, ...)
    -- function num : 0_11 , upvalues : helper, _ENV
    local cs_del_obj = (helper.new_callback)(cs_obj, method_name, ...);
    ((CS.XLuaMessenger).RemoveListener)(messengerName, cs_del_obj)
end

local remove_listener = function(messengerName, ...)
    -- function num : 0_12 , upvalues : _ENV, remove_listener_with_delegate, unpack, remove_listener_with_func, remove_listener_with_reflection
    local params = {...}
    assert(#params >= 1, "error params count!")
    if #params == 1 then
        remove_listener_with_delegate(messengerName, unpack(params))
    elseif #params == 2 and type(params[2]) == "function" then
        remove_listener_with_func(messengerName, unpack(params))
    else
        remove_listener_with_reflection(messengerName, unpack(params))
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return {
    add_listener = add_listener,
    broadcast = broadcast,
    remove_listener = remove_listener
}

