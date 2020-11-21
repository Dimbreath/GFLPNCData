-- params : ...
-- function num : 0 , upvalues : _ENV
Stack = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

Stack.__index = Stack
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

Stack.New = function()
    -- function num : 0_0 , upvalues : _ENV
    local o = {}
    o.data = {}
    o.bottom = 1
    o.top = 1
    setmetatable(o, Stack)
    return o
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

Stack.Count = function(self)
    -- function num : 0_1
    return self.top - self.bottom
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

Stack.Empty = function(self)
    -- function num : 0_2
    do return self.bottom == self.top end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

Stack.Push = function(self, item)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    (self.data)[self.top] = item
    self.top = self.top + 1
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

Stack.Pop = function(self)
    -- function num : 0_4
    if self:Empty() then return nil end
    local index = self.top - 1
    local o = (self.data)[index] -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.data)[index] = nil
    self.top = index
    return o
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

Stack.Peek = function(self)
    -- function num : 0_5
    if self:Empty() then return nil end
    return (self.data)[self.top - 1]
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

Stack.Clear = function(self)
    -- function num : 0_6
    self.data = {}
    self.top = self.bottom
end

return Stack

