-- params : ...
-- function num : 0 , upvalues : _ENV
local Messenger = class("Messenger")
Messenger.ctor = function(self)
    -- function num : 0_0
    self.events = {}
end

Messenger.AddListener = function(self, type, callback, ...)
    -- function num : 0_1 , upvalues : _ENV
    local event = (self.events)[type]
    if event == nil then event = setmetatable({}, {__mode = "k"}) end
    for k, v in pairs(event) do
        if k == callback then
            error("Aready cotains listener : " .. tostring(callback))
            return
        end
    end
    event[callback] = setmetatable(SafePack(...), {__mode = "kv"}) -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.events)[type] = event
end

Messenger.Broadcast = function(self, type, ...)
    -- function num : 0_2 , upvalues : _ENV
    local event = (self.events)[type]
    if event == nil then return end
    for k, v in pairs(event) do
        assert(k ~= nil)
        local args = ConcatSafePack(v, SafePack(...))
        k(SafeUnpack(args))
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Messenger.RemoveListener = function(self, type, callback)
    -- function num : 0_3
    local event = (self.events)[type]
    if event == nil or callback == nil then return end
    event[callback] = nil
end

Messenger.RemoveListenerByType = function(self, type)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.events)[type] = nil
end

Messenger.Clear = function(self)
    -- function num : 0_5
    self.events = {}
end

return Messenger

