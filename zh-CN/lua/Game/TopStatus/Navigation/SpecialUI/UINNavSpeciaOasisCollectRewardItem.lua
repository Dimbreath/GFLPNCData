local UINNavSpeciaOasisCollectRewardItem = class("UINNavSpeciaOasisCollectRewardItem", UIBaseNode)
local base = UIBaseNode
UINNavSpeciaOasisCollectRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINNavSpeciaOasisCollectRewardItem.SetNSOCRItemImage = function(self, itemId)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("itemCfg is nill id:" .. tostring(itemId))
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_SmallIcon).sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

UINNavSpeciaOasisCollectRewardItem.RefreshNSOCRItemRate = function(self, rate)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Rate).fillAmount = rate or 0
end

UINNavSpeciaOasisCollectRewardItem.GetFillAmountImage = function(self)
  -- function num : 0_3
  return (self.ui).img_Rate
end

UINNavSpeciaOasisCollectRewardItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINNavSpeciaOasisCollectRewardItem

