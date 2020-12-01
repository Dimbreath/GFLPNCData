-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisResNeedItem = class("UIOasisResNeedItem", UIBaseNode)
local base = UIBaseNode
UIOasisResNeedItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisResNeedItem.UpdateUI = function(self, name, currentNum, needNum, isBuilding)
  -- function num : 0_1 , upvalues : _ENV
  local index = ((not isBuilding or (needNum <= currentNum and 2) or not 3) and (needNum <= currentNum and 0)) or 1
  ;
  ((self.ui).tex_ResNum):SetIndex(index, name, tostring(currentNum), tostring(needNum))
end

UIOasisResNeedItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIOasisResNeedItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisResNeedItem = class("UIOasisResNeedItem", UIBaseNode)
local base = UIBaseNode
UIOasisResNeedItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisResNeedItem.UpdateUI = function(self, name, currentNum, needNum,
                                       isBuilding)
    -- function num : 0_1 , upvalues : _ENV
    local index =
        ((not isBuilding or (needNum <= currentNum and 2) or not 3) and
            (needNum <= currentNum and 0)) or 1;
    ((self.ui).tex_ResNum):SetIndex(index, name, tostring(currentNum),
                                    tostring(needNum))
end

UIOasisResNeedItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UIOasisResNeedItem

