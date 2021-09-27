local UINRewardItem = class("UINRewardItem", UIBaseNode)
UINRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINRewardItem.InitRewardItem = function(self, resloader, itemData, overCount)
  -- function num : 0_1 , upvalues : _ENV
  if not overCount then
    local count = itemData.count
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(count)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).sprite = CRH:GetSprite(itemData.icon)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = itemData.name
end

return UINRewardItem

