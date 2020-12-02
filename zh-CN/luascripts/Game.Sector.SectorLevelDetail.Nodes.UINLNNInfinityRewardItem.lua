-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLNNInfinityRewardItem = class("UINLNNInfinityRewardItem", UIBaseNode)
local base = UIBaseNode
UINLNNInfinityRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLNNInfinityRewardItem.InitReardItem = function(self, itemId, Num)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("can\'t read itemCfg id=" .. tostring(itemId))
    self:Hide()
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(Num)
end

UINLNNInfinityRewardItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLNNInfinityRewardItem

