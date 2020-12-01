-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisAreaLock = class("UINOasisAreaLock", UIBaseNode)
local base = UIBaseNode
UINOasisAreaLock.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINOasisAreaLock.InitOasisAreaLock = function(self)
  -- function num : 0_1
end

UINOasisAreaLock.UpdateOasisAreaLockPos = function(self, worldPos)
  -- function num : 0_2 , upvalues : _ENV
  local localPos = UIManager:World2UIPosition(worldPos)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = localPos
end

UINOasisAreaLock.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINOasisAreaLock

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisAreaLock = class("UINOasisAreaLock", UIBaseNode)
local base = UIBaseNode
UINOasisAreaLock.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINOasisAreaLock.InitOasisAreaLock = function(self)
    -- function num : 0_1
end

UINOasisAreaLock.UpdateOasisAreaLockPos =
    function(self, worldPos)
        -- function num : 0_2 , upvalues : _ENV
        local localPos = UIManager:World2UIPosition(worldPos) -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.transform).anchoredPosition = localPos
    end

UINOasisAreaLock.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINOasisAreaLock

