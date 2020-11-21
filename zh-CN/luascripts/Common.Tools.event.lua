-- params : ...
-- function num : 0 , upvalues : _ENV
local setmetatable = setmetatable
local xpcall = xpcall
local pcall = pcall
local assert = assert
local rawget = rawget
local error = error
local traceback = debug.traceback
local ilist = ilist
local event_err_handle = function(msg)
    -- function num : 0_0 , upvalues : error
    error(msg, 2)
end

local _pcall = {
    __call = function(self, ...)
        -- function num : 0_1 , upvalues : xpcall, traceback, event_err_handle
        local status, err = nil, nil
        if not self.obj then
            status = xpcall(self.func, traceback, ...)
        else
            -- DECOMPILER ERROR at PC18: Overwrote pending register: R2 in 'AssignReg'

            status = xpcall(self.func, traceback, self.obj, ...)
        end
        if not status then event_err_handle(err) end
        return status
    end,
    __eq = function(lhs, rhs)
        -- function num : 0_2
        do return lhs.func == rhs.func and lhs.obj == rhs.obj end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
}
local functor = function(func, obj)
    -- function num : 0_3 , upvalues : setmetatable, _pcall
    return setmetatable({func = func, obj = obj}, _pcall)
end

local _event = {}
_event.__index = _event
_event.CreateListener = function(self, func, obj)
    -- function num : 0_4 , upvalues : functor
    func = functor(func, obj)
    return {value = func, _prev = 0, _next = 0, removed = true}
end

_event.AddListener = function(self, handle)
    -- function num : 0_5 , upvalues : assert, _ENV
    assert(handle)
    if self.lock then
        (table.insert)(self.opList, function()
            -- function num : 0_5_0 , upvalues : self, handle
            (self.list):pushnode(handle)
        end)
    else

        (self.list):pushnode(handle)
    end
end

_event.RemoveListener = function(self, handle)
    -- function num : 0_6 , upvalues : assert, _ENV
    assert(handle)
    if self.lock then
        (table.insert)(self.opList, function()
            -- function num : 0_6_0 , upvalues : self, handle
            (self.list):remove(handle)
        end)
    else

        (self.list):remove(handle)
    end
end

_event.Count = function(self)
    -- function num : 0_7
    return (self.list).length
end

_event.Clear = function(self)
    -- function num : 0_8
    (self.list):clear()
    self.opList = {}
    self.lock = false
    self.current = nil
end

_event.__call = function(self, ...)
    -- function num : 0_9 , upvalues : ilist, _ENV
    local _list = self.list
    self.lock = true
    local ilist = ilist
    for i, f in ilist(_list) do
        self.current = i
        if not f(...) then
            _list:remove(i)
            self.lock = false
        end
    end
    local opList = self.opList
    self.lock = false
    for i, op in ipairs(opList) do
        op()
        opList[i] = nil
    end
end

event = function(name)
    -- function num : 0_10 , upvalues : setmetatable, _ENV, _event
    return setmetatable({
        name = name,
        lock = false,
        opList = {},
        list = list:new()
    }, _event)
end

UpdateBeat = event("Update")
LateUpdateBeat = event("LateUpdate")
FixedUpdateBeat = event("FixedUpdate")
Update = function(deltaTime, unscaledDeltaTime)
    -- function num : 0_11 , upvalues : _ENV
    Time:SetDeltaTime(deltaTime, unscaledDeltaTime)
    UpdateBeat()
end

LateUpdate = function()
    -- function num : 0_12 , upvalues : _ENV
    LateUpdateBeat()
    Time:SetFrameCount()
end

FixedUpdate = function(fixedDeltaTime)
    -- function num : 0_13 , upvalues : _ENV
    Time:SetFixedDelta(fixedDeltaTime)
    FixedUpdateBeat()
end

