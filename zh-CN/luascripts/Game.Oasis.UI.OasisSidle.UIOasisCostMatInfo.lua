-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisCostMatInfo = class("UIOasisCostMatInfo", UIBaseNode)
local base = UIBaseNode
UIOasisCostMatInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisCostMatInfo.UpdateUI = function(self, id, needCount, bagCount)
  -- function num : 0_1 , upvalues : _ENV
  local item = (ConfigData.item)[id]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  if item ~= nil then
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite(item.icon)
  end
  do
    if needCount > bagCount or not 1 then
      local index = needCount == nil or 2
    end
    ;
    ((self.ui).tex_TotalCount):SetIndex(index, tostring(bagCount), tostring(needCount))
    ;
    ((self.ui).tex_TotalCount):SetIndex(0, tostring(bagCount))
    if (self.ui).empty ~= nil then
      if bagCount == 0 then
        ((self.ui).empty):SetActive(true)
      else
        ;
        ((self.ui).empty):SetActive(false)
      end
    end
  end
end

UIOasisCostMatInfo.UpdateUIWithName = function(self, id, name, needCount, bagCount)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Name).text = name
  local item = (ConfigData.item)[id]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

  if item ~= nil then
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite(item.icon)
  end
  do
    if needCount > bagCount or not 1 then
      local index = needCount == nil or 2
    end
    ;
    ((self.ui).tex_TotalCount):SetIndex(index, tostring(bagCount), tostring(needCount))
    ;
    ((self.ui).tex_TotalCount):SetIndex(0, tostring(bagCount))
  end
end

UIOasisCostMatInfo.UpdateWithEmpty = function(self)
  -- function num : 0_3
  if (self.ui).empty ~= nil then
    ((self.ui).empty):SetActive(true)
  end
  if (self.ui).chipItemWithCount ~= nil then
    (((self.ui).chipItemWithCount).gameObject):SetActive(false)
  end
end

return UIOasisCostMatInfo

